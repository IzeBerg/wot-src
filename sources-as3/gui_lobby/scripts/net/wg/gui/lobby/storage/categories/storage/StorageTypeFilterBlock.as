package net.wg.gui.lobby.storage.categories.storage
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.ButtonFilters;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.storage.categories.BaseFilterBlock;
   import scaleform.clik.constants.InvalidationType;
   
   public class StorageTypeFilterBlock extends BaseFilterBlock
   {
      
      protected static const FILTER_NAME_GAP:int = 7;
      
      protected static const TYPE_FILTERS_X_OFFSET:int = 27;
      
      private static const FILTERS_BUTTON_GAP:int = 7;
      
      protected static const INVALID_RESET:String = "invalidateResetData";
       
      
      public var typeFilters:ButtonFilters = null;
      
      public var typeFilterName:TextField = null;
      
      private var _typeFiltersVO:ButtonFiltersVO = null;
      
      private var _resetData:int = 0;
      
      public function StorageTypeFilterBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setupFilter(this.typeFilters);
         this.typeFilterName.autoSize = TextFieldAutoSize.LEFT;
         this.typeFilterName.text = STORAGE.STORAGE_TABS_MODULES_FILTER_TYPE_LABEL;
      }
      
      override protected function onDispose() : void
      {
         this._typeFiltersVO = null;
         this.typeFilterName = null;
         this.clearFilter(this.typeFilters);
         this.typeFilters = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_RESET))
         {
            this.doResetFilters(this._resetData);
         }
         if(this._typeFiltersVO && isInvalid(InvalidationType.DATA))
         {
            App.utils.commons.updateTextFieldSize(this.typeFilterName,true,false);
            this.typeFilters.setData(this._typeFiltersVO);
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updatePositions();
         }
      }
      
      public function resetFilters(param1:int) : void
      {
         this._resetData = param1;
         invalidate(INVALID_RESET);
      }
      
      public function initTypeFilter(param1:ButtonFiltersVO) : void
      {
         this.typeFilterName.text = param1.filterTypeName == Values.EMPTY_STR ? STORAGE.STORAGE_TABS_MODULES_FILTER_TYPE_LABEL : param1.filterTypeName;
         this._typeFiltersVO = param1;
         invalidateData();
      }
      
      protected function updatePositions() : void
      {
         this.typeFilters.x = width - this.typeFilters.width;
         this.typeFilterName.x = this.typeFilters.x - this.typeFilterName.width - FILTER_NAME_GAP;
      }
      
      private function setupFilter(param1:ButtonFilters) : void
      {
         param1.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
         param1.addEventListener(Event.RESIZE,this.onFilterBlockResizeHandler);
         param1.layout = new HorizontalGroupLayout(FILTERS_BUTTON_GAP,false);
         param1.buttonLinkage = Linkages.BUTTON_BLACK;
      }
      
      private function clearFilter(param1:ButtonFilters) : void
      {
         param1.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
         param1.removeEventListener(Event.RESIZE,this.onFilterBlockResizeHandler);
         param1.dispose();
      }
      
      protected function doResetFilters(param1:int) : void
      {
         this.typeFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
         this.typeFilters.resetFilters(param1);
         this.typeFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
      }
      
      private function onFilterBlockResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onFilterBlockFiltersChangedHandler(param1:FiltersEvent) : void
      {
         var _loc2_:int = this.typeFilters.filtersValue;
         dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,_loc2_));
      }
   }
}
