package net.wg.gui.components.carousels.data
{
   import scaleform.clik.data.DataProvider;
   
   public class FilterRoleItemData extends FilterCarouseItemData
   {
       
      
      private var _selectedVehTypeIdx:int = -1;
      
      public function FilterRoleItemData(param1:int, param2:String, param3:DataProvider, param4:int)
      {
         super(param1,param2,param3);
         this._selectedVehTypeIdx = param4;
      }
      
      public function get selectedVehTypeIdx() : int
      {
         return this._selectedVehTypeIdx;
      }
   }
}
