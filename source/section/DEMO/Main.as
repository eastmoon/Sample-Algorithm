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

package section.DEMO
{
	/*import：Flash內建元件庫*/
	import flash.display.*;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.utils.setInterval;
	import section.DEMO.BinarySearchTree.BSTNode;
		
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public class Main extends MovieClip
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		public function Main()
		{
			// 範例
			// Binary Search Tree
			this.DEMO_BinarySearchTree();
		}
		/*public function：對外公開函數*/
		public function LogOut( a_str : String ) : void
		{
			trace( a_str );
		}
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		private function DEMO_BinarySearchTree() : void
		{
			this.LogOut("===== Binary Search Tree Operation =====\n"); 
			var i = 0, j = 0, k = 0, l = 0
			var bt : ISearchTreeAlgorithm = new BSTNode();
			var temp : ISearchTreeAlgorithm = null;
			var input : Array = [10,6,14,4,8,12,15,9,13,16];
			var removeList : Array = new Array();
			
			this.LogOut("Input : ");
			for( i = 0 ; i < input.length ; i++ )
			{
				bt.Insert( input[i] );
			}
			
			this.LogOut("Min : " + bt.minimumNode.keyValue.toString() );
			this.LogOut("Max : " + bt.maximumNode.keyValue.toString() );
			this.LogOut("List Node : ");
			if( bt != null )
				bt.toList();
				
			this.LogOut("\nFind 10 : ");
			temp = bt.Retrieve( 10 );
			this.LogOut( temp.keyValue.toString() );
			
			this.LogOut("\nFind 8 : ");
			temp = bt.Retrieve( 8 );
			this.LogOut( temp.keyValue.toString() );
			
			this.LogOut("\nFind 12 : ");
			temp = bt.Retrieve( 12 );
			this.LogOut( temp.keyValue.toString() );
			
			this.LogOut("\nIn-order successor : ");
			
			temp = bt.Retrieve( 8 );
			this.LogOut( "In this in-order successor of 8 is " + temp.successorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 12 );
			this.LogOut( "In this in-order successor of 12 is " + temp.successorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 4 );
			this.LogOut( "In this in-order successor of 4 is " + temp.successorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 14 );
			this.LogOut( "In this in-order successor of 14 is " + temp.successorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 15 );
			this.LogOut( "In this in-order successor of 15 is null : " + (temp.successorNode == null).toString() );
			
			this.LogOut("\nIn-order predecessor : ");
			
			temp = bt.Retrieve( 6 );
			this.LogOut( "In this in-order predecessor of 6 is " + temp.predecessorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 15 );
			this.LogOut( "In this in-order predecessor of 15 is " + temp.predecessorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 8 );
			this.LogOut( "In this in-order predecessor of 8 is " + temp.predecessorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 12 );
			this.LogOut( "In this in-order predecessor of 12 is " + temp.predecessorNode.keyValue.toString() );
			
			temp = bt.Retrieve( 4 );
			this.LogOut( "In this in-order predecessor of 4 is null : " + (temp.predecessorNode == null).toString() );
			
			for( i = 0, j = 0, k = 0, l = 0; i < input.length ; i++ )
			{
				removeList.push( input[i] );
				j = Math.floor( Math.random() * removeList.length );
				k = Math.floor( Math.random() * removeList.length );
				l = removeList[j];
				removeList[j] = removeList[k];
				removeList[k] = l;
			}
			
			for( i = 0 ; i < removeList.length ; i++ )
			{
				temp = bt.Remove(removeList[i]);
				if( temp != null )
					this.LogOut( "\nRemove " + temp.keyValue.toString() );
				bt.toList();
			}
			
			this.LogOut("\nRe-Insert");
			for( i = 0 ; i < input.length ; i++ )
			{
				bt.Insert( input[i] );
			}
			bt.toList();
			this.LogOut("===== END =====\n"); 
		}
	}
}