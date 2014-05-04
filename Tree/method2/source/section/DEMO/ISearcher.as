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
		
	public interface ISearcher
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
		function CloneNode() : INode
		/*
		 * 插入數值，依據演算規則從填入適當的結構。
		 */
		function Insert( a_value : Object ) : INode
		/*
		 * 移除數值，依據演算規則從結構挑選目標刪除，並保持結構完整。
		 */
		function Remove( a_value : Object ) : INode
		/*
		 * 取回數值，依據演算規則從結構挑選目標回傳，其搜尋效率應低於O(N)。
		 */
		function Retrieve( a_value : Object ) : INode
		/*
		 * 內容列表。
		 */
		function toList() : void
		/*
		 * 內容列表，以矩陣輸出。
		 */
		function toArray() : Array
		/*public get/set function：變數存取介面*/
		/*write only：唯寫*/
		/*read only：唯讀*/
		/*read/write：讀寫*/
		/*
		 * [讀寫]，存取根節點
		 */
		function get rootNode() : INode
		function set rootNode( a_node : INode ) : void
		/*private event function：私用事件函數*/
		/*private function：私用函數*/
		
	}
}