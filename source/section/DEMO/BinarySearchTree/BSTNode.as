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
	import flash.display.*;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.utils.setInterval;
	import section.DEMO.ISearchTreeAlgorithm;
		
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public class BSTNode implements ISearchTreeAlgorithm
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_left : ISearchTreeAlgorithm;
		private var m_right : ISearchTreeAlgorithm;
		private var m_parent : ISearchTreeAlgorithm;
		private var m_value : Object;
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function BSTNode( a_value : Object = null, a_parent : ISearchTreeAlgorithm = null )
		{
			this.m_value = a_value;
			this.m_parent = a_parent;
		}
		/*public function：對外公開函數*/
		/*
		 * 插入數值，依據演算規則從填入適當的結構。
		 */
		public function Insert( a_value : Object ) : void
		{
			// 插入
			if( a_value != null )
			{
				// 0. this node value is null, input value is this.
				if( this.keyValue == null )
				{
					this.m_value = a_value;
				}
				// 1. less than keyValue, push in left
				else if( a_value <= this.keyValue )
				{
					// 1.1 left is null, create a new one.
					if( this.m_left == null )
					{
						this.m_left = new BSTNode( a_value, this );
					}
					// 1.2 left isn't null, push value to node to check.
					else
					{
						this.m_left.Insert( a_value );
					}
					
				}
				// 2. larger than keyValue, push in right
				else
				{
					// 2.1 right is null, create a new one.
					if( this.m_right == null )
					{
						this.m_right = new BSTNode( a_value, this );
					}
					// 2.2 right isn't null, push value to node to check.
					else
					{
						this.m_right.Insert( a_value );
					}
				}
			}
		}
		/*
		 * 移除數值，依據演算規則從結構挑選目標刪除，並保持結構完整。
		 */
		public function Remove( a_value : Object ) : ISearchTreeAlgorithm
		{
			// 移除
			// 1. Take back remove node.
			var target : ISearchTreeAlgorithm = this.Retrieve( a_value );
			var result : ISearchTreeAlgorithm = null;
			if( target == null )
				return null;
			else
			{
				result = new BSTNode( target.keyValue, null );
			}
				
			// 2. Choose replace node. 
			// if remove node have left or right node, than replacer is target, 
			// else if remove node left and right both have node, than replacer is In-order successor of target.
			var replacer : ISearchTreeAlgorithm = null;
			if( target.leftNode == null || target.rightNode == null )
				replacer = target;
			else
				replacer = target.successorNode;
			
			// 3. if replacer isn't null, choose splice out method.
			if( replacer != null )
			{
				// 3.1 choose splicer node, if replacer have left node, thane splicer is left node, else splicer is right node.
				var splicer : ISearchTreeAlgorithm = null
				if( replacer.leftNode != null )
					splicer = replacer.leftNode;
				else
					splicer = replacer.rightNode;
				
				// 3.2 if replacer isnt't remove target, change replacer value and data to remove node.
				if( replacer != target )
				{
					target.keyValue = replacer.keyValue;
				}
				
				// 3.3 if replacer parent is null, than splicer is root in BST, use splicer value and data to replace with root node.
				// else if replacer is left node in parent node, than change parent left node to splicer, else change parent right node to splicer.
				if( replacer.parentNode == null )
				{
					replacer.ReplaceNode( splicer );
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
		public function Retrieve( a_value : Object ) : ISearchTreeAlgorithm
		{
			// 取回
			/*
			// Recursive method
			// 1. input equal value, return this object.
			if( a_value == this.keyValue )
				return this;
			else
			{
				// 2. if input less than value, find in left.
				if( a_value <= this.keyValue )
				{
					trace( "Path : L" );
					return this.m_left.Retrieve( a_value );
				}
				// 3. if input larger than value, find in right.
				else
				{
					trace( "Path : R" );
					return this.m_right.Retrieve( a_value );
				}
				
			}
			return null;
			*/
			
			// Loop method
			var target : ISearchTreeAlgorithm = this;
			
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
		 * 取代，將指定的內容物連結，更換為目標物。
		 */
		public function Replace( a_sourceNode : ISearchTreeAlgorithm, a_targetNode : ISearchTreeAlgorithm ) : void
		{
			// Replace source node to target node, and source node must left or right node in this.
			if( this.m_left == a_sourceNode )
			{
				this.leftNode = a_targetNode;
			}
			else if( this.m_right == a_sourceNode )
			{
				this.rightNode = a_targetNode;
			}
		}
		/*
		 * 取代，將當前內容更換為輸入目標的內容
		 */
		public function ReplaceNode( a_node : ISearchTreeAlgorithm ) : void
		{
			if( a_node == null )
			{
				// 1. input node is null, initial this node.
				this.m_value = null;
				this.m_left = null;
				this.m_right = null;
				this.m_parent = null;
			}
			else
			{
				// 2. input node have value, replace all value and link by input node.
				this.keyValue = a_node.keyValue;
				this.leftNode = a_node.leftNode;
				this.rightNode = a_node.rightNode;
			}
		}
		/*
		 * 內容列表。
		 */
		public function toList() : void
		{
			// 顯示左子
			if( this.m_left != null )
			{
				this.m_left.toList();
			}
			// 顯示本值
			trace( this.m_value );
			// 顯示右子
			if( this.m_right != null )
			{
				this.m_right.toList();
			}
		}
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		
		/*
		 * [唯讀]，當節點下屬樹中的最小值所屬節點
		 */
		public function get minimumNode() : ISearchTreeAlgorithm
		{
			var target : ISearchTreeAlgorithm = this;
			while( target.leftNode != null )
			{
				target = target.leftNode;
			}
			return target;
		}
		
		/*
		 * [唯讀]，當節點下屬樹中的最大值所屬節點
		 */
		public function get maximumNode() : ISearchTreeAlgorithm
		{
			var target : ISearchTreeAlgorithm = this;
			while( target.rightNode != null )
			{
				target = target.rightNode;
			}
			return target;
		}
		
		/*
		 * [唯讀]，最近且大於當前節點值的後繼值(節點值)
		 */
		public function get successorNode() : ISearchTreeAlgorithm
		{
			// reference : http://algorithmsandme.blogspot.tw/2013/08/binary-search-tree-inorder-successor.html
			// In-order successor of a node is the node which will come after the given node in in-order traversal of binary search tree. 
			// In other words, it would be the next larger element in BST.
			var successor : ISearchTreeAlgorithm = null;
			var current : ISearchTreeAlgorithm = this;
			
			// 1. if this have right node, that minimum node in right node is successor.
			if( this.rightNode != null )
				successor = this.rightNode.minimumNode;
			// 2. if this have not right node, find this parent.
			else
			{
				// 2.1 when current is right node in parent, change current is parent, until the root.
				// - if this is maximum value in BST, than current will change to root.
				while( current.parentNode != null && current.parentNode.rightNode == current )
				{
					current = current.parentNode;
				}
				successor = current.parentNode;
			}
			return successor;
		}
		
		/*
		 * [唯讀]，最近且小於當前節點值的前任值(節點值)
		 */
		public function get predecessorNode() : ISearchTreeAlgorithm
		{
			// reference : http://algorithmsandme.blogspot.tw/2013/08/binary-search-tree-inorder-successor.html
			// In-order predecessor of a node is the node which will come after the given node in in-order traversal of binary search tree. 
			// In other words, it would be the up small element in BST.
			var predecessor : ISearchTreeAlgorithm = null;
			var current : ISearchTreeAlgorithm = this;
			
			// 1. if this have left node, that left node is predecessor.
			if( this.leftNode != null )
				predecessor = this.leftNode;
			// 2. if this have not left node, find this parent.
			else
			{
				// 2.1 when current is left node in parent, change current is parent, until the root.
				// - if this is minimum value in BST, than current will change to root.
				while( current.parentNode != null && current.parentNode.leftNode == current )
				{
					current = current.parentNode;
				}
				predecessor = current.parentNode;
			}
			return predecessor;
		}
		/*read/write：讀寫*/
		/*
		 * [讀寫]，存取左子
		 */
		public function get leftNode() : ISearchTreeAlgorithm
		{
			return this.m_left;
		}
		public function set leftNode( a_node : ISearchTreeAlgorithm ) : void
		{
			this.m_left = a_node;
			if( this.m_left != null )
				this.m_left.parentNode = this;
		}
		/*
		 * [讀寫]，存取右子
		 */
		public function get rightNode() : ISearchTreeAlgorithm
		{
			return this.m_right;
		}
		public function set rightNode( a_node : ISearchTreeAlgorithm ) : void
		{
			this.m_right = a_node;
			if( this.m_right != null )
				this.m_right.parentNode = this;
		}
		/*
		 * [讀寫]，存取父層
		 */
		public function get parentNode() : ISearchTreeAlgorithm
		{
			return this.m_parent;
		}
		public function set parentNode( a_node : ISearchTreeAlgorithm ) : void
		{
			if( a_node == null || a_node.rightNode == this || a_node.leftNode == this )
				this.m_parent = a_node;
		}
		/*
		 * [讀寫]，存取數值
		 */
		public function get keyValue() : Object
		{
			return this.m_value;
		}
		public function set keyValue( a_value : Object ) : void
		{
			this.m_value = a_value;
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}