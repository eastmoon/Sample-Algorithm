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
	import section.DEMO.INode;
		
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public class BSTNode implements INode
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_left : INode;
		private var m_right : INode;
		private var m_parent : INode;
		private var m_value : Object;
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function BSTNode( a_value : Object = null, a_parent : INode = null )
		{
			this.m_value = a_value;
			this.m_parent = a_parent;
		}
		/*public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 */
		public function Clone() : INode
		{
			return new BSTNode();
		}
		/*
		 * 取代，將指定的內容物連結，更換為目標物。
		 */
		public function Replace( a_sourceNode : INode, a_targetNode : INode ) : void
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
		public function ReplaceNode( a_node : INode ) : void
		{
			// input node have value, replace all value and link by input node.
			this.keyValue = a_node.keyValue;
			this.leftNode = a_node.leftNode;
			this.rightNode = a_node.rightNode;
		}
		/*
		 * 取代，將當前內容的數值更換為目標的數值
		 */
		public function ReplaceValue( a_node : INode ) : void
		{
			this.keyValue = a_node.keyValue;
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
			trace( this.keyValue );
			// 顯示右子
			if( this.m_right != null )
			{
				this.m_right.toList();
			}
		}
		/*
		 * 內容列表，以矩陣輸出。
		 */
		public function toArray( a_output : Array ) : void
		{
			// 左子
			if( this.m_left != null )
			{
				this.m_left.toArray(a_output);
			}
			// 本值
			if( this.keyValue != null )
				a_output.push( this.keyValue );
			// 右子
			if( this.m_right != null )
			{
				this.m_right.toArray(a_output);
			}
			
		}
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		
		/*
		 * [唯讀]，當節點下屬樹中的最小值所屬節點
		 */
		public function get minimumNode() : INode
		{
			var target : INode = this;
			while( target.leftNode != null )
			{
				target = target.leftNode;
			}
			return target;
		}
		
		/*
		 * [唯讀]，當節點下屬樹中的最大值所屬節點
		 */
		public function get maximumNode() : INode
		{
			var target : INode = this;
			while( target.rightNode != null )
			{
				target = target.rightNode;
			}
			return target;
		}
		
		/*
		 * [唯讀]，最近且大於當前節點值的後繼值(節點值)
		 */
		public function get successorNode() : INode
		{
			// reference : http://algorithmsandme.blogspot.tw/2013/08/binary-search-tree-inorder-successor.html
			// In-order successor of a node is the node which will come after the given node in in-order traversal of binary search tree. 
			// In other words, it would be the next larger element in BST.
			var successor : INode = null;
			var current : INode = this;
			
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
		public function get predecessorNode() : INode
		{
			// reference : http://algorithmsandme.blogspot.tw/2013/08/binary-search-tree-inorder-successor.html
			// In-order predecessor of a node is the node which will come after the given node in in-order traversal of binary search tree. 
			// In other words, it would be the up small element in BST.
			var predecessor : INode = null;
			var current : INode = this;
			
			// 1. if this have left node, that maximum node in left node is predecessor.
			if( this.leftNode != null )
				predecessor = this.leftNode.maximumNode;
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
		/*
		 * [唯讀]，祖父結點
		 */
		public function get grandparentNode() : INode
		{
			if( this.parentNode != null )
				return this.parentNode.parentNode;
			return null;
		}
		/*
		 * [唯讀]，叔父結點
		 */
		public function get uncleNode() : INode
		{
			var grandparent : INode = this.grandparentNode;
			if( grandparent != null )
			{
				if( grandparent.leftNode == this.parentNode )
					return grandparent.rightNode;
				else
					return grandparent.leftNode;
			}
			return null;
		}
		/*
		 * [唯讀]，兄弟結點
		 */
		public function get siblingNode() : INode
		{
			if( this.parentNode != null )
			{
				if( this.parentNode.leftNode == this )
					return this.parentNode.rightNode;
				else
					return this.parentNode.leftNode;
			}
			return null;
		}
		/*read/write：讀寫*/
		/*
		 * [讀寫]，存取左子
		 */
		public function get leftNode() : INode
		{
			return this.m_left;
		}
		public function set leftNode( a_node : INode ) : void
		{
			this.m_left = a_node;
			if( this.m_left != null )
				this.m_left.parentNode = this;
		}
		/*
		 * [讀寫]，存取右子
		 */
		public function get rightNode() : INode
		{
			return this.m_right;
		}
		public function set rightNode( a_node : INode ) : void
		{
			this.m_right = a_node;
			if( this.m_right != null )
				this.m_right.parentNode = this;
		}
		/*
		 * [讀寫]，存取父層
		 */
		public function get parentNode() : INode
		{
			return this.m_parent;
		}
		public function set parentNode( a_node : INode ) : void
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