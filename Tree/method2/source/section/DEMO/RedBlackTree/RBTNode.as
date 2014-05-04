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
	import section.DEMO.INode;
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
		public function RBTNode( a_value : Object = null, a_parent : INode = null )
		{
			super( a_value, a_parent );
			this.color = RBTNode.COLOR_RED;
		}
		/*public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 */
		public override function Clone() : INode
		{
			return new RBTNode();
		}
		/*
		 * 取代，將當前內容的數值更換為目標的數值
		 */
		public override function ReplaceValue( a_node : INode ) : void
		{
			var node : RBTNode = a_node as RBTNode;
			if( node != null )
			{
				this.keyValue = node.keyValue;
				this.color = node.color;
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
	}
}