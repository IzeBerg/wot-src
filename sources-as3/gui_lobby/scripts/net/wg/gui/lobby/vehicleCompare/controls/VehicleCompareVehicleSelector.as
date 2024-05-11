package net.wg.gui.lobby.vehicleCompare.controls
{
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.gui.components.controls.VehicleSelectorBase;
   import net.wg.gui.lobby.components.VehicleSelectorFilter;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareVehicleSelectorItemVO;
   
   public class VehicleCompareVehicleSelector extends VehicleSelectorBase
   {
       
      
      public function VehicleCompareVehicleSelector()
      {
         super();
         dataProvider = new SortableVoDAAPIDataProvider(VehicleCompareVehicleSelectorItemVO);
         VehicleSelectorFilter(filtersView).mode = VehicleSelectorFilter.MODE_USER_VEHICLES;
      }
   }
}
