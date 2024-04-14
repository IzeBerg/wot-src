package net.wg.gui.lobby.storage.categories.storage
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.storage.data.StorageNationFilterVO;
   import scaleform.clik.events.ListEvent;
   
   public class StorageTypeAndNationFilterBlock extends StorageTypeFilterBlock
   {
      
      private static const NATION_DROPDOWN_X_OFFSET:int = 2;
      
      private static const INVALID_INIT_NATION_FILTER:String = "initNationFilter";
       
      
      public var nationFilterName:TextField = null;
      
      public var nationDropdown:DropdownMenu = null;
      
      private var _selectedNationIndex:int = 0;
      
      private var _storageNationFilterVO:StorageNationFilterVO;
      
      public function StorageTypeAndNationFilterBlock()
      {
         super();
      }
      
      public function initNationFilter(param1:StorageNationFilterVO) : void
      {
         this._storageNationFilterVO = param1;
         invalidate(INVALID_INIT_NATION_FILTER);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.nationFilterName.text = STORAGE.CREWBOOKS_FILTERS_NATION;
         this.nationFilterName.autoSize = TextFieldAutoSize.LEFT;
         this.nationDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onNationIndexChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.nationFilterName = null;
         this.nationDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onNationIndexChangeHandler);
         this.nationDropdown.dispose();
         this.nationDropdown = null;
         this._storageNationFilterVO = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._storageNationFilterVO && isInvalid(INVALID_INIT_NATION_FILTER))
         {
            this._selectedNationIndex = this._storageNationFilterVO.selectedIndex;
            this.nationDropdown.enabled = this._storageNationFilterVO.enabled;
            this.nationDropdown.selectedIndex = this._storageNationFilterVO.selectedIndex;
            this.nationDropdown.dataProvider = this._storageNationFilterVO.nations;
         }
      }
      
      override protected function updatePositions() : void
      {
         this.nationDropdown.x = width - this.nationDropdown.width + NATION_DROPDOWN_X_OFFSET;
         this.nationFilterName.x = this.nationDropdown.x - this.nationFilterName.width;
         typeFilters.x = this.nationFilterName.x - typeFilters.width - TYPE_FILTERS_X_OFFSET;
         typeFilterName.x = typeFilters.x - typeFilterName.width - FILTER_NAME_GAP;
      }
      
      override protected function doResetFilters(param1:int) : void
      {
         this._selectedNationIndex = this.nationDropdown.selectedIndex = 0;
         super.doResetFilters(param1);
      }
      
      private function onNationIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.index != this._selectedNationIndex)
         {
            this._selectedNationIndex = param1.index;
            _loc2_ = this.nationDropdown.dataProvider[this.nationDropdown.selectedIndex].id;
            dispatchEvent(new FiltersEvent(FiltersEvent.NATION_FILTER_CHANGED,_loc2_));
         }
      }
   }
}
