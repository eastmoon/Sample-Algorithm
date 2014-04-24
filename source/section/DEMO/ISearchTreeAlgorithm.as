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
		
	/*external import：外部元件庫、開發人員自定元件庫*/
		
	public interface ISearchTreeAlgorithm
	{
		/*static const variable : 靜態常數變數*/
		/*const variable：常數變數*/
		/*function variable：函數變數*/
		/*member variable：物件內部操作變數*/
		
		/*display object variable：顯示物件變數，如MovieClip等*/
		/*constructor：建構值*/
		/*public function：對外公開函數*/
		/*
		 * 插入數值，依據演算規則從填入適當的結構。
		 */
		function Insert( a_value : Object ) : void
		/*
		 * 移除數值，依據演算規則從結構挑選目標刪除，並保持結構完整。
		 */
		function Remove( a_value : Object ) : ISearchTreeAlgorithm
		/*
		 * 取回數值，依據演算規則從結構挑選目標回傳，其搜尋效率應低於O(N)。
		 */
		function Retrieve( a_value : Object ) : ISearchTreeAlgorithm
		/*
		 * 取代，將指定的內容物連結，更換為目標物。
		 */
		function Replace( a_sourceNode : ISearchTreeAlgorithm, a_targetNode : ISearchTreeAlgorithm ) : void
		/*
		 * 取代，將當前內容更換為輸入目標的內容
		 */
		function ReplaceNode( a_node : ISearchTreeAlgorithm ) : void
		/*
		 * 內容列表。
		 */
		function toList() : void
		
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*
		 * [唯讀]，當節點下屬樹中的最小值所屬節點
		 */
		function get minimumNode() : ISearchTreeAlgorithm
		/*
		 * [唯讀]，當節點下屬樹中的最大值所屬節點
		 */
		function get maximumNode() : ISearchTreeAlgorithm
		/*
		 * [唯讀]，最近且大於當前節點值的後繼值(節點值)
		 */
		function get successorNode() : ISearchTreeAlgorithm
		/*
		 * [唯讀]，最近且小於當前節點值的前任值(節點值)
		 */
		function get predecessorNode() : ISearchTreeAlgorithm
		
		/*read/write：讀寫*/
		/*
		 * [讀寫]，存取左子
		 */
		function get leftNode() : ISearchTreeAlgorithm
		function set leftNode( a_node : ISearchTreeAlgorithm ) : void
		/*
		 * [讀寫]，存取右子
		 */
		function get rightNode() : ISearchTreeAlgorithm
		function set rightNode( a_node : ISearchTreeAlgorithm ) : void
		/*
		 * [讀寫]，存取父層
		 */
		function get parentNode() : ISearchTreeAlgorithm
		function set parentNode( a_node : ISearchTreeAlgorithm ) : void
		/*
		 * [讀寫]，存取數值
		 */
		function get keyValue() : Object
		function set keyValue( a_value : Object ) : void
		
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}