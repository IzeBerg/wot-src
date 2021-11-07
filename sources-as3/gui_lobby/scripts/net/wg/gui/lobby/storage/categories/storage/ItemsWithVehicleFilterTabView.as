package net.wg.gui.lobby.storage.categories.storage
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.meta.IItemsWithVehicleFilterTabViewMeta;
   import net.wg.infrastructure.base.meta.impl.ItemsWithVehicleFilterTabViewMeta;
   
   public class ItemsWithVehicleFilterTabView extends ItemsWithVehicleFilterTabViewMeta implements IItemsWithVehicleFilterTabViewMeta
   {
       
      
      private var currentFiltersBlock:StorageTypeAndVehicleFilterBlock;
      
      public function ItemsWithVehicleFilterTabView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.currentFiltersBlock = filtersBlock as StorageTypeAndVehicleFilterBlock;
         App.utils.asserter.assertNotNull(this.currentFiltersBlock,"currentFiltersBlock " + Errors.CANT_NULL);
         this.currentFiltersBlock.addEventListener(FiltersEvent.RESET_VEHICLE_FILTERS,this.onFiltersBlockResetVehicleFiltersHandler);
      }
      
      override protected function onDispose() : void
      {
         this.currentFiltersBlock.removeEventListener(FiltersEvent.RESET_VEHICLE_FILTERS,this.onFiltersBlockResetVehicleFiltersHandler);
         this.currentFiltersBlock = null;
         super.onDispose();
      }
      
      override protected function initVehicleFilter(param1:VehicleVO) : void
      {
         this.currentFiltersBlock.updateVehicleFilterButton(param1);
      }
      
      override protected function updateVehicleFilterButton(param1:VehicleVO) : void
      {
         this.currentFiltersBlock.updateVehicleFilterButton(param1);
      }
      
      private function onFiltersBlockResetVehicleFiltersHandler(param1:FiltersEvent) : void
      {
         resetVehicleFilterS();
      }
      
      override protected function initNoItemsView() : void
      {
         noItemsView.setTexts(STORAGE.STORAGE_NOITEMS_TITLESHORT);
      }
      
      override protected function disposeNoItemsView() : void
      {
      }
   }
}
