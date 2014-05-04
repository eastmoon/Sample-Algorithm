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
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public interface INode
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		/*public function：對外公開函數*/
		/*
		 * 複製物件；數據、連接點不可複製
		 */
		function Clone() : INode
		/*
		 * 取代，將指定的內容物連結，更換為目標物。
		 */
		function Replace( a_sourceNode : INode, a_targetNode : INode ) : void
		/*
		 * 取代，將當前內容更換為輸入目標的內容
		 */
		function ReplaceNode( a_node : INode ) : void
		/*
		 * 取代，將當前內容的數值更換為目標的數值
		 */
		function ReplaceValue( a_node : INode ) : void
		/*
		 * 內容列表。
		 */
		function toList() : void
		/*
		 * 內容列表，以矩陣輸出。
		 */
		function toArray( a_output : Array ) : void
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*
		 * [唯讀]，當節點下屬樹中的最小值所屬節點
		 */
		function get minimumNode() : INode
		/*
		 * [唯讀]，當節點下屬樹中的最大值所屬節點
		 */
		function get maximumNode() : INode
		/*
		 * [唯讀]，最近且大於當前節點值的後繼值(節點值)
		 */
		function get successorNode() : INode
		/*
		 * [唯讀]，最近且小於當前節點值的前任值(節點值)
		 */
		function get predecessorNode() : INode
		/*
		 * [唯讀]，祖父結點
		 */
		function get grandparentNode() : INode
		/*
		 * [唯讀]，叔父結點
		 */
		function get uncleNode() : INode
		/*
		 * [唯讀]，兄弟結點
		 */
		function get siblingNode() : INode
		/*read/write：讀寫*/
		/*
		 * [讀寫]，存取左子
		 */
		function get leftNode() : INode
		function set leftNode( a_node : INode ) : void
		/*
		 * [讀寫]，存取右子
		 */
		function get rightNode() : INode
		function set rightNode( a_node : INode ) : void
		/*
		 * [讀寫]，存取父層
		 */
		function get parentNode() : INode
		function set parentNode( a_node : INode ) : void
		/*
		 * [讀寫]，存取數值
		 */
		function get keyValue() : Object
		function set keyValue( a_value : Object ) : void
		
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}