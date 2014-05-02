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

package section.DEMO.RedBlackTree
{
	/*import：Flash內建元件庫*/
	import flash.display.*;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.utils.setInterval;
	import section.DEMO.ISearchTreeAlgorithm;
	import section.DEMO.BinarySearchTree.BSTNode;
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public class RBTNode extends BSTNode
	{
		/*static const variable : 靜態常數變數*/
		public static const COLOR_RED : Number = 1;
		public static const COLOR_BLACK : Number = 2;
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/		
		private var m_color : Number;
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function RBTNode( a_value : Object = null, a_parent : ISearchTreeAlgorithm = null )
		{
			super( a_value, a_parent );
			this.color = RBTNode.COLOR_RED;
		}
		/*public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 */
		public override function Clone() : ISearchTreeAlgorithm
		{
			return new RBTNode();
		}
		/*
		 * 插入數值，依據演算規則從填入適當的結構。
		 */
		public override function Insert( a_value : Object ) : ISearchTreeAlgorithm
		{
			// 執行父級插入行為。
			var node : RBTNode = super.Insert( a_value ) as RBTNode;
			
			// 修正顏色與調整
			// 0. default node color is red.
			node.color = RBTNode.COLOR_RED;
			
			// 1. Fixup RBT structure
			this.InsertFixup( node );
			
			return node;
		}
		
		/*
		 * 移除數值，依據演算規則從結構挑選目標刪除，並保持結構完整。
		 */
		public override function Remove( a_value : Object ) : ISearchTreeAlgorithm
		{
			// 執行父級插入行為。
			
			// 1. 搜索刪除目標的父結點
			// search delete target and parent.
			var target : RBTNode = this.Retrieve( a_value ) as RBTNode;
			if( target == null )
				return null;
			else
				target = target.parentNode as RBTNode;
			
			// 2. 刪除結點
			// remove node by BST
			var node : RBTNode = super.Remove( a_value ) as RBTNode;			
			
			// 3. 取回取代刪除點的子結點
			// take back child node who replace remove node
			var child : RBTNode = null;
			if( target == null )
				child = this;
			else
			{
				if( node.keyValue < target.keyValue )
					child = target.leftNode as RBTNode;
				else
					child = target.rightNode as RBTNode;
			}
			
			// 4. Fixup RBT structure, when delete node color is black.
			if( node.color == RBTNode.COLOR_BLACK )
			{
				// 4.1 child color is red, change color to black
				if( child != null && child.color == RBTNode.COLOR_RED )
					child.color = RBTNode.COLOR_BLACK;
				// 4.2 child color is black, fixup structure
				else
					this.RemoveFixup( child, target );
			}
			return node;
		}
		
		/*
		 * 取代，將當前內容的數值更換為目標的數值
		 */
		public override function ReplaceValue( a_node : ISearchTreeAlgorithm ) : void
		{
			var node : RBTNode = a_node as RBTNode;
			if( node != null )
			{
				this.keyValue = node.keyValue;
				this.color = node.color;
			}
		}
		/*
		 * 左迴旋，將當前結點左迴旋；結點的右子為父，結點為父的左子，父的左子為結點的右子。
		 */
		public function RotateToLeft() : void
		{
			var temp : RBTNode = null;
			
			// 1. Take right node is temp node.
			temp = this.rightNode as RBTNode;
			
			// 2. When temp node isn't null.
			if( temp != null )
			{
				// this isn't root
				if( this.parentNode != null )
				{
					// 2.1 Replace right node to left node of temp node.
					this.rightNode = temp.leftNode;
					if( temp.leftNode != null )
						temp.leftNode.parentNode = this;
				
					// 2.2 Replace temp node to this parent.
					this.parentNode.Replace( this, temp );
			
					// 2.3 Setting this parent is right node of temp node.
					temp.leftNode = this;
					this.parentNode = temp;
				}
				// this is root
				else
				{
					// 2.4 temp right is this right
					this.rightNode = temp.rightNode;
					if( temp.rightNode != null )
						temp.rightNode.parentNode = this;
					
					// 2.5 change temp and this value, color
					var copy : RBTNode = new RBTNode();
					copy.ReplaceValue( this );
					this.ReplaceValue( temp );
					temp.ReplaceValue( copy );
					
					// 2.6 temp right is left
					temp.rightNode = temp.leftNode;
					
					// 2.7 temp left is this left
					temp.leftNode = this.leftNode;
					if( this.leftNode != null )
						this.leftNode.parentNode = temp;
					
					// 2.8 this left is temp
					this.leftNode = temp;
				}
			}
		}
		/*
		 * 右迴旋，將當前結點右迴旋；結點的左子為新父，結點為新父的右子，新父的右子為結點的左子。
		 */
		public function RotateToRight() : void
		{
			var temp : RBTNode = null;
			
			// 1. Take left node is temp node.
			temp = this.leftNode as RBTNode;
			
			// 2. When temp node isn't null.
			if( temp != null )
			{
				// this isn't root
				if( this.parentNode != null )
				{
					// 2.1 Replace left node to right node of temp node.
					this.leftNode = temp.rightNode;
					if( temp.rightNode != null )
						temp.rightNode.parentNode = this;
				
					// 2.2 Replace temp node to this parent.
					this.parentNode.Replace( this, temp );
				
					// 2.3 Setting this parent is right node of temp node.
					temp.rightNode = this;
					this.parentNode = temp;
				}
				// this is root
				else
				{
					// 2.4 temp left is this left.
					this.leftNode = temp.leftNode;
					if( temp.leftNode != null )
						temp.leftNode.parentNode = this;
					
					// 2.5 change temp and this value, COLOR
					var copy : RBTNode = new RBTNode();
					copy.ReplaceValue( this );
					this.ReplaceValue( temp );
					temp.ReplaceValue( copy );
					
					// 2.6 temp left is right
					temp.leftNode = temp.rightNode;
					
					// 2.7 temp right is this right
					temp.rightNode = this.rightNode;
					if( this.rightNode != null )
						this.rightNode.parentNode = temp;
					
					// 2.8 this right is temp
					this.rightNode = temp;
				}
			}
		}		
		
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*
		 * [讀寫]，更換顏色
		 */
		public function get color() : Number
		{
			return this.m_color;
		}
		public function set color( a_color : Number ) : void
		{
			this.m_color = a_color;
		}
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		private function GetSibling( a_node : RBTNode, a_parent : RBTNode = null ) : RBTNode
		{
			// if input node isn't null.
			if( a_node != null )
				return a_node.siblingNode as RBTNode;
			// if input node is null, it mean node is NIL node and color is black, use parent.
			else if( a_parent != null )
			{
				if( a_parent.leftNode == null )
					return a_parent.rightNode as RBTNode;
				else
					return a_parent.leftNode as RBTNode;
			}
			return null;
		}
		private function RemoveFixup( a_node : RBTNode, a_parent : RBTNode = null ) : void
		{
			// Reference : http://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91
			//
			var parent : RBTNode = ( a_node != null ) ? a_node.parentNode as RBTNode : a_parent;
			var sibling : RBTNode = this.GetSibling( a_node, a_parent );
			
			// case 1. node is root
			if( parent == null )
			{
				// tree structure is correct. 
			}
			// case 2 ~ 5. if node have a sibling 
			else if( sibling != null )
			{
				// case 2. sibling color is red.
				if( sibling.color == RBTNode.COLOR_RED )
				{
					// 2.1 setting node parent color is red and sibling is black
					parent.color = RBTNode.COLOR_RED;
					sibling.color = RBTNode.COLOR_BLACK;
					// 2.2 when node is left of parent, than parent rotate to left.
					if( a_node == parent.leftNode )
					{
						trace( "c2.1" );
						parent.RotateToLeft();
					}
					else
					{
						trace( "c2.2" );
						parent.RotateToRight();
					}
				}
				
				// execute case 2 function
				this.RemoveFixupCase2( a_node, a_parent );
			}
		}
		private function RemoveFixupCase2( a_node : RBTNode, a_parent : RBTNode = null ) : void
		{
			// Reference : http://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91
			//
			var parent : RBTNode = ( a_node != null ) ? a_node.parentNode as RBTNode : a_parent;
			var sibling : RBTNode = this.GetSibling( a_node, a_parent );
			
			if( parent!= null && sibling != null )
			{
				// case 3. parent, sibling, sbiling child all is black.
				if( parent.color == RBTNode.COLOR_BLACK && 
				   sibling.color == RBTNode.COLOR_BLACK &&
				   ( sibling.leftNode == null || (sibling.leftNode != null && (sibling.leftNode as RBTNode).color == RBTNode.COLOR_BLACK) ) &&
				   ( sibling.rightNode == null || (sibling.rightNode != null && (sibling.rightNode as RBTNode).color == RBTNode.COLOR_BLACK) ) )
				{
					trace( "c3" );
					// setting sibling color is red
					sibling.color = RBTNode.COLOR_RED;
					
					// Fixup parent node
					this.RemoveFixup( parent );
				}
				// case 4. parent is red, sibling and sibling child is black.
				else if( parent.color == RBTNode.COLOR_RED && 
						sibling.color == RBTNode.COLOR_BLACK && 
						( sibling.leftNode == null || (sibling.leftNode != null && (sibling.leftNode as RBTNode).color == RBTNode.COLOR_BLACK) ) &&
						( sibling.rightNode == null || (sibling.rightNode != null && (sibling.rightNode as RBTNode).color == RBTNode.COLOR_BLACK) ) )
				{
					trace( "c4" );
					// setting parent is black, sibling is red
					parent.color = RBTNode.COLOR_BLACK;
					sibling.color = RBTNode.COLOR_RED;
				}
				else 
				{
					if( sibling.color == RBTNode.COLOR_BLACK )
					{
						// case 5.1 left of sibling is red, right of sibling is black, and node is left of parent.
						if( a_node == parent.leftNode && 
						   ( sibling.leftNode != null && (sibling.leftNode as RBTNode).color == RBTNode.COLOR_RED) && 
						   ( sibling.rightNode == null || (sibling.rightNode != null && (sibling.rightNode as RBTNode).color == RBTNode.COLOR_BLACK) ) )
						{
						trace( "c5.1" );
							sibling.color = RBTNode.COLOR_RED;
							(sibling.leftNode as RBTNode).color = RBTNode.COLOR_BLACK;
							sibling.RotateToRight();
						}
						// case 5.2 left of sibling is black, right of sibling is red, and node is right of parent.
						else if( a_node == parent.rightNode && 
								( sibling.rightNode != null && (sibling.rightNode as RBTNode).color == RBTNode.COLOR_RED) && 
								( sibling.leftNode == null || (sibling.leftNode != null && (sibling.leftNode as RBTNode).color == RBTNode.COLOR_BLACK) ) )
						{
							trace( "c5.2" );
							sibling.color = RBTNode.COLOR_RED;
							(sibling.rightNode as RBTNode).color = RBTNode.COLOR_BLACK;
							sibling.RotateToLeft();
						}
					}
					
					// execute case 3 function
					this.RemoveFixupCase3( a_node, a_parent );
				}
			}
		}
		private function RemoveFixupCase3( a_node : RBTNode, a_parent : RBTNode = null ) : void
		{
			// Reference : http://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91
			//
			var parent : RBTNode = ( a_node != null ) ? a_node.parentNode as RBTNode : a_parent;
			var sibling : RBTNode = this.GetSibling( a_node, a_parent );
			
			if( parent!= null && sibling != null )
			{
				// case 6. 
				sibling.color = parent.color;
				parent.color = RBTNode.COLOR_BLACK;
					
				// case 6.1 node is left of parent, and sibling right node is red.
				if( a_node == parent.leftNode && ( sibling.rightNode != null && (sibling.rightNode as RBTNode).color == RBTNode.COLOR_RED))
				{
					trace( "c6.1" );
					(sibling.rightNode as RBTNode).color = RBTNode.COLOR_BLACK;
					parent.RotateToLeft();
				}
				// case 6.2 node is right of parent, and sibling left node is red.
				else if( a_node == parent.rightNode && ( sibling.leftNode != null && (sibling.leftNode as RBTNode).color == RBTNode.COLOR_RED))
				{
					trace( "c6.2" );
					(sibling.leftNode as RBTNode).color = RBTNode.COLOR_BLACK;
					parent.RotateToRight();
				}
			}
		}
		private function InsertFixup( a_node : RBTNode ) : void
		{
			// Reference : http://zh.wikipedia.org/wiki/%E7%BA%A2%E9%BB%91%E6%A0%91
			//
			var parent : RBTNode = a_node.parentNode as RBTNode;
			var grandparent : RBTNode = a_node.grandparentNode as RBTNode;
			var uncle : RBTNode = a_node.uncleNode as RBTNode;
			
			// case 1. node don't have parent, make node color is black.
			/*
			trace( "G", grandparent, (grandparent != null) ? grandparent.color : null );
			trace( "P", parent, (parent != null) ? parent.color : null );
			trace( "U", uncle, (uncle != null) ? uncle.color : null );
			trace( "N", a_node.keyValue, a_node.color );
			*/
			if( a_node.parentNode == null )
			{
				a_node.color = RBTNode.COLOR_BLACK;
			}
			// case 2. if parent color is black, it is normal state, pass all check.
			else if( parent.color == RBTNode.COLOR_BLACK )
			{
				// tree structure is correct.
			}
			// case 3. if parent and uncle ( parent and uncle have the same grand parent ) color is red.
			else if( uncle != null && uncle.color == RBTNode.COLOR_RED )
			{
				// make parent and uncle color is black, grand parent color is red				
				grandparent.color = RBTNode.COLOR_RED;
				parent.color = RBTNode.COLOR_BLACK;
				uncle.color = RBTNode.COLOR_BLACK;
				
				// Fixup grand parent, make sure structure is correct
				this.InsertFixup( grandparent );
			}
			// case 4. if parent color is red, but uncle is null or uncle color is black.
			else if( grandparent != null && (uncle == null || (uncle != null && uncle.color == RBTNode.COLOR_BLACK)))
			{
				// 4.1 node is right node of parent, and parent is left node of grand parent, parent rotate to left.
				if( a_node == parent.rightNode && parent == grandparent.leftNode )
				{
					parent.RotateToLeft();
					a_node = parent;
				}
				// 4.2 node is left node of parent, and parent is right node of grand parent, parent rotate to right.
				else if( a_node == parent.leftNode && parent == grandparent.rightNode )
				{
					parent.RotateToRight();
					a_node = parent;
				}
				// 4.3 Re take parent, uncle, grand parent
				parent = a_node.parentNode as RBTNode;
				grandparent = a_node.grandparentNode as RBTNode;
				uncle = a_node.uncleNode as RBTNode;
				
				// case 5. if parent color is red, but uncle is null or uncle color is black.
				if( grandparent != null && parent.color == RBTNode.COLOR_RED && 
				   (uncle == null || (uncle != null && uncle.color == RBTNode.COLOR_BLACK)))
				{
					// 5.1 remake parent color is black. grandparent color is red.
					parent.color = RBTNode.COLOR_BLACK;
					grandparent.color = RBTNode.COLOR_RED;
					
					// 5.2 node is left node of parent, and parent is left node of grand parent, grand parent rotate to right.
					if( a_node == parent.leftNode && parent == grandparent.leftNode )
					{
						grandparent.RotateToRight();
					}
					// 5.3 node is right node of parent, and parent is right node of grand parent, grand parent rotate to left.
					else if( a_node == parent.rightNode && parent == grandparent.rightNode )
					{
						grandparent.RotateToLeft();
					}
				}
			}
			
			/*
			trace( "G", a_node.grandparentNode, (a_node.grandparentNode != null) ? (a_node.grandparentNode as RBTNode).color : null );
			trace( "P", a_node.parentNode, (a_node.parentNode != null) ? (a_node.parentNode as RBTNode).color : null );
			trace( "U", a_node.uncleNode, (a_node.uncleNode != null) ? (a_node.uncleNode as RBTNode).color : null );
			trace( "N", a_node.keyValue, a_node.color );
			trace( "=============" );
			*/
			
		}
		
	}
}