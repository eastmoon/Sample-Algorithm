/*
//////////////////////////
////	 Main		 ////
//////////////////////////
	Info:
		- 各Section的程式進入點與主要Section內的物件管理
		
	Useage:(有開放public 讓外部使用)
		- FunctionName1 : function describe
		
	Date:
		- 9999.99.99
		
	Author:
		- Name : Author
		- Email : Author@email.com
*/

package section.DEMO.BinarySearchTree
{
	/*import：Flash內建元件庫*/
	import section.DEMO.ISearcher;
	import section.DEMO.INode;
		
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public class BSTSearcher implements ISearcher
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_node : INode;
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function BSTSearcher()
		{
		}
		/*public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 */
		public function CloneNode() : INode
		{
			return new BSTNode();
		}
		/*
		 * 插入數值，依據演算規則從填入適當的結構。
		 */
		public function Insert( a_value : Object ) : INode
		{
			// 插入
			var node : INode = null;
			if( this.m_node != null )
			{
				// 0. setting node.
				node = this.m_node;
				
				// 1. take a node that value is null.
				while( node.keyValue != null )
				{
					// 1.1 less than keyValue, next node is left of node.
					if( a_value <= node.keyValue )
					{
						if( node.leftNode == null )
						{
							node.leftNode = this.CloneNode();
							node.leftNode.parentNode = node;
						}
						else
							node = node.leftNode;
					}
					// 1.2 larger than keyValue, next node is right of node
					else
					{
						if( node.rightNode == null )
						{
							node.rightNode = this.CloneNode();
							node.rightNode.parentNode = node;
						}
						else
							node = node.rightNode;
					}
				}
				
				// 1. setting value to node
				node.keyValue = a_value;				
			}
			else
			{
				// Searcher didn't have any node.
				this.m_node = this.CloneNode();
				this.m_node.keyValue = a_value;
				node = this.m_node;
			}
			
			return node;
		}
		/*
		 * 移除數值，依據演算規則從結構挑選目標刪除，並保持結構完整。
		 */
		public function Remove( a_value : Object ) : INode
		{
			// 移除
			// 1. Take back remove node.
			var target : INode = this.Retrieve( a_value );
			var result : INode = null;
			if( target == null )
				return null;
			else
			{
				result = this.CloneNode();
				result.ReplaceValue( target );
			}
				
			// 2. Choose replace node. 
			// if remove node have left or right node, than replacer is target, 
			// else if remove node left and right both have node, than replacer is In-order successor of target.
			var replacer : INode = null;
			if( target.leftNode == null || target.rightNode == null )
				replacer = target;
			else
				replacer = target.successorNode;
				
			// 3. if replacer isn't null, choose splice out method.
			if( replacer != null )
			{
				// 3.1 choose splicer node, if replacer have left node, thane splicer is left node, else splicer is right node.
				var splicer : INode = null
				if( replacer.leftNode != null )
					splicer = replacer.leftNode;
				else
					splicer = replacer.rightNode;
				
				// 3.2 if replacer isnt't remove target, change replacer value and data to remove node.
				if( replacer != target )
				{
					target.ReplaceValue( replacer );
				}
				
				// 3.3 if replacer parent is null, than splicer is root in BST.
				// else if replacer is left node in parent node, than change parent left node to splicer, else change parent right node to splicer.
				if( replacer.parentNode == null )
				{
					if( splicer != null && splicer.parentNode != null )
						splicer.parentNode = null;
					this.m_node = splicer;
				}
				else
				{
					replacer.parentNode.Replace( replacer, splicer );
				}
			}
			
			return result;
		}
		/*
		 * 取回數值，依據演算規則從結構挑選目標回傳，其搜尋效率應低於O(N)。
		 */
		public function Retrieve( a_value : Object ) : INode
		{
			// 取回
			// Loop method
			var target : INode = this.m_node;
			
			while( target != null && target.keyValue != a_value )
			{
				if( a_value <= target.keyValue )
				{
					target = target.leftNode;
				}
				else
				{
					target = target.rightNode;
				}
			}
			
			return target;
		}
		/*
		 * 內容列表。
		 */
		public function toList() : void
		{
			this.m_node.toList();
		}
		/*
		 * 內容列表，以矩陣輸出。
		 */
		public function toArray() : Array
		{
			var output : Array = new Array();
			if( this.m_node != null )
				this.m_node.toArray( output );
			return output;
		}
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*
		 * [讀寫]，存取根節點
		 */
		public function get rootNode() : INode
		{
			return this.m_node;
		}
		public function set rootNode( a_node : INode ) : void
		{
			this.m_node = a_node;
			if( this.m_node.parentNode != null )
				this.m_node.parentNode = null;
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}