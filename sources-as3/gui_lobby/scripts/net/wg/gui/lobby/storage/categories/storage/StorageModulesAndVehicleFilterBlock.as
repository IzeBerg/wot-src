package net.wg.gui.lobby.storage.categories.storage
{
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.storage.data.StorageModulesFilterVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   
   public class StorageModulesAndVehicleFilterBlock extends StorageTypeAndVehicleFilterBlock
   {
      
      private static const INVALID_INIT_MODULES_FILTER:String = "invalidateInitModulesFilter";
       
      
      public var modulesDropdown:DropdownMenu = null;
      
      private var _selectedModulesIndex:int = 0;
      
      private var _modulesNationFilterVO:StorageModulesFilterVO;
      
      public function StorageModulesAndVehicleFilterBlock()
      {
         super();
      }
      
      override protected function doResetFilters(param1:int) : void
      {
         this._selectedModulesIndex = this.modulesDropdown.selectedIndex = 0;
         super.doResetFilters(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         typeFilters.visible = false;
         typeFilterName.visible = false;
         this.modulesDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onModulesIndexChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.modulesDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onModulesIndexChangeHandler);
         this.modulesDropdown.dispose();
         this.modulesDropdown = null;
         this._modulesNationFilterVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._modulesNationFilterVO && isInvalid(INVALID_INIT_MODULES_FILTER))
         {
            this._selectedModulesIndex = this._modulesNationFilterVO.selectedIndex;
            this.modulesDropdown.enabled = this._modulesNationFilterVO.enabled;
            this.modulesDropdown.selectedIndex = this._modulesNationFilterVO.selectedIndex;
            this.modulesDropdown.dataProvider = this._modulesNationFilterVO.modules;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.modulesDropdown.x = vehiclesFilterName.x - this.modulesDropdown.width - TYPE_FILTERS_X_OFFSET;
         }
      }
      
      override protected function updatePositions() : void
      {
         super.updatePositions();
         this.modulesDropdown.x = vehiclesFilterName.x - this.modulesDropdown.width - TYPE_FILTERS_X_OFFSET | 0;
      }
      
      public function initModulesFilter(param1:StorageModulesFilterVO) : void
      {
         this._modulesNationFilterVO = param1;
         invalidate(INVALID_INIT_MODULES_FILTER);
      }
      
      private function onModulesIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.index != this._selectedModulesIndex)
         {
            this._selectedModulesIndex = param1.index;
            _loc2_ = this.modulesDropdown.dataProvider[this.modulesDropdown.selectedIndex].id;
            dispatchEvent(new FiltersEvent(FiltersEvent.MODULES_FILTER_CHANGED,_loc2_));
         }
      }
   }
}
