package net.wg.gui.lobby.fortifications.cmp.selector
{
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.VehicleSelectorBase;
   import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectorItemVO;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class FortVehicleSelector extends VehicleSelectorBase
   {
       
      
      public function FortVehicleSelector()
      {
         super();
         dataProvider = new SortableVoDAAPIDataProvider(FortVehicleSelectorItemVO);
      }
      
      override public function setHeaderDP(param1:IDataProvider) : void
      {
         super.setHeaderDP(param1);
         NormalSortingBtnVO(table.headerDP[table.headerDP.length - 1]).showSeparator = false;
      }
      
      public function get toggles() : SimpleTileList
      {
         return FortVehicleSelectorFilter(filtersView).toggles;
      }
   }
}
