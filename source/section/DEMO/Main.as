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
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.utils.setInterval;
	import section.DEMO.BinarySearchTree.BSTNode;
	import flash.events.MouseEvent;
		
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public class Main extends MovieClip
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		private var m_node : ISearchTreeAlgorithm;
		/*display object variable：顯示物件變數，如MovieClip等*/
		public var mc_btn : MovieClip;
		public var mc_input : TextField;
		public var mc_findLabel : TextField;
		public var mc_resultLabel : TextField;
		public var mc_minLabel : TextField;
		public var mc_maxLabel : TextField;
		public var mc_successorInput : TextField;
		public var mc_successorOutput : TextField;
		public var mc_predecessorInput : TextField;
		public var mc_predecessorOutput : TextField;
		public var mc_treeSprite : Sprite;
		
		/*constructor：建構值*/
		public function Main()
		{
			// 範例
			// Binary Search Tree
			//this.DEMO_BinarySearchTree();
			
			// GUI DEMO
			this.DEMO_GUI();
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
		
		private function DEMO_GUI() : void
		{
			this.mc_btn.tf_text.text = "Build";
			this.mc_btn.buttonMode = true;
			this.mc_btn.addEventListener(MouseEvent.CLICK, this.DEMO_GUI_BinarySearchTree);
			this.mc_input.text = "10,6,14,4,8,12,15,9,13,16";
			this.mc_minLabel.text = "minimum";
			this.mc_maxLabel.text = "maximum";
			this.mc_findLabel.text = "0";
			this.mc_findLabel.addEventListener(Event.CHANGE, this.DEMO_GUI_Find);
			this.mc_resultLabel.text = "result";
			this.mc_successorInput.text = "x";
			this.mc_successorInput.addEventListener(Event.CHANGE, this.DEMO_GUI_Successor);
			this.mc_successorOutput.text = "y";
			this.mc_predecessorInput.text = "x";
			this.mc_predecessorInput.addEventListener(Event.CHANGE, this.DEMO_GUI_Predecessor);
			this.mc_predecessorOutput.text = "y";
			this.mc_treeSprite = new Sprite();
			this.mc_treeSprite.y = 150;
			this.addChild( this.mc_treeSprite );
		}
		
		private function DEMO_GUI_BinarySearchTree( a_event : MouseEvent ) : void
		{
			if( this.m_node == null || ( this.m_node != null && !(this.m_node is BSTNode)) )
			{
				this.m_node = null;
				this.m_node = new BSTNode();
			}
			
			var i : Number = 0, j : Number = 0, k : Number = 0;
			var input : Array = this.mc_input.text.split(",");
			var output : Array = new Array();
			
			// 1. have node, delete old node.
			this.m_node.toArray( output );
			if( output.length > 0 )
			{
				for( i = 0 ; i < output.length ; i++ )
				{
					var temp : ISearchTreeAlgorithm = this.m_node.Remove( output[i] );
					//if( temp != null )
						//this.LogOut( "Remove " + temp.keyValue.toString() );
				}
			}
			// 2. setting node by input label.
			for( i = 0 ; i < input.length ; i++ )
			{
				this.m_node.Insert( Number(input[i]) );
			}
			
			// 3. get minimum and maximum.
			this.mc_minLabel.text = this.m_node.minimumNode.keyValue.toString();
			this.mc_maxLabel.text = this.m_node.maximumNode.keyValue.toString();
			
			// 4. draw tree
			var tree : Sprite = new Sprite();
			var node : ISearchTreeAlgorithm = null;
			var nodeText : TextField = null;
			var curLayer : Array = new Array();
			var nextLayer : Array = new Array();
			var upWidth : Number = 900;
			var curWidth : Number = upWidth / 2;
			curLayer.push( this.m_node );
			j = 0;
			do
			{
				k = 0;
				for( i = 0 ; i < curLayer.length ; i++ )
				{
					// 4.1 crete value
					node = curLayer[i];
					nodeText = new TextField();
					nodeText.autoSize = TextFieldAutoSize.CENTER;
					if( node != null && node.keyValue != null )
					{
						nodeText.text = node.keyValue.toString();
					}
					else
						nodeText.text = "";
					tree.addChild( nodeText );
					nodeText.y = j * 50;
					if( j == 0 )
						nodeText.x = upWidth / 2;
					else
					{
						nodeText.x = upWidth * Math.floor(i / 2) + upWidth / 2 + (( i%2 ) ? curWidth / 2 : -curWidth / 2) - nodeText.width/2;
						// draw line to parent
						if( node != null )
						{
							tree.graphics.lineStyle(2, 0x990000, .75);
							tree.graphics.moveTo( nodeText.x + nodeText.width/2, nodeText.y - 5 );
							tree.graphics.lineTo( upWidth * Math.floor(i / 2) + upWidth / 2, ((j - 1) * 50 + 25) );
							tree.graphics.endFill();
						}
					}
					
					// 4.2 set next layer
					if( node != null )
					{
						nextLayer.push( node.leftNode );
						nextLayer.push( node.rightNode );
						if( node.leftNode != null || node.rightNode != null )
							k++;
					}
					else
					{
						nextLayer.push( null );
						nextLayer.push( null );
					}
				}
				// change array
				curLayer = null;
				curLayer = nextLayer;
				nextLayer = new Array();
				if( j > 0 )
				{
					upWidth = curWidth;
					curWidth = upWidth / 2;
				}
				j++;
			}while( k > 0 )
			
			//this.mc_treeSprite.addChild( tree );
			var bitmap : BitmapData = new BitmapData(950, 550, true, 0xffffffff );
			bitmap.draw( tree );
			var graphic : Graphics = this.mc_treeSprite.graphics;
			graphic.clear();
			graphic.beginBitmapFill( bitmap, null, false, true );
			graphic.drawRect( 0, 0, bitmap.width, bitmap.height );
			graphic.endFill();
		}
		
		private function DEMO_GUI_Find( a_event : Event ) : void
		{
			if( this.m_node == null )
				return ;
			var node : ISearchTreeAlgorithm = this.m_node.Retrieve( Number(this.mc_findLabel.text) );
			
			if( node != null )
				this.mc_resultLabel.text = node.keyValue.toString();
			else
				this.mc_resultLabel.text = "NULL";
		}
		
		private function DEMO_GUI_Successor( a_event : Event ) : void
		{
			if( this.m_node == null )
				return ;
			var node : ISearchTreeAlgorithm = this.m_node.Retrieve( Number(this.mc_successorInput.text) );
			if( node != null )
				node = node.successorNode;
			if( node != null )
				this.mc_successorOutput.text = node.keyValue.toString();
			else
				this.mc_successorOutput.text = "NULL";
		}
		
		private function DEMO_GUI_Predecessor( a_event : Event ) : void
		{
			if( this.m_node == null )
				return ;
			var node : ISearchTreeAlgorithm = this.m_node.Retrieve( Number(this.mc_predecessorInput.text) );
			if( node != null )
				node = node.predecessorNode;			
			if( node != null )
				this.mc_predecessorOutput.text = node.keyValue.toString();
			else
				this.mc_predecessorOutput.text = "NULL";
		}
	}
}