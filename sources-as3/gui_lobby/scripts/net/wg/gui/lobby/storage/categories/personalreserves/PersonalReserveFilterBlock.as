package net.wg.gui.lobby.storage.categories.personalreserves
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.ButtonFilters;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.storage.categories.BaseFilterBlock;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalReserveFilterBlock extends BaseFilterBlock
   {
      
      private static const FILTERS_BUTTON_GAP:int = 7;
      
      private static const FILTERS_GROUP_GAP:int = 40;
      
      private static const FILTER_NAME_GAP:int = 7;
      
      private static const INVALID_RESET:String = "invalidateResetData";
       
      
      public var durationFilters:ButtonFilters = null;
      
      public var typeFilters:ButtonFilters = null;
      
      public var qualityFilterName:TextField = null;
      
      public var typeFilterName:TextField = null;
      
      private var _resetData:int = 0;
      
      private var _typeFiltersVO:ButtonFiltersVO;
      
      private var _durationFiltersVO:ButtonFiltersVO;
      
      public function PersonalReserveFilterBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setupFilter(this.durationFilters);
         this.setupFilter(this.typeFilters);
         this.qualityFilterName.text = STORAGE.PERSONALRESERVES_DURATIONFILTER_LABEL;
         this.qualityFilterName.autoSize = TextFieldAutoSize.LEFT;
         this.typeFilterName.text = STORAGE.PERSONALRESERVES_TYPEFILTER_LABEL;
         this.typeFilterName.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this._typeFiltersVO = null;
         this._durationFiltersVO = null;
         this.qualityFilterName = null;
         this.typeFilterName = null;
         this.clearFilter(this.durationFilters);
         this.durationFilters = null;
         this.clearFilter(this.typeFilters);
         this.typeFilters = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._typeFiltersVO || this._durationFiltersVO)
         {
            if(isInvalid(INVALID_RESET))
            {
               this.durationFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
               this.typeFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
               this.durationFilters.resetFilters(this._resetData);
               this.typeFilters.resetFilters(this._resetData);
               this.durationFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
               this.typeFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.durationFilters.setData(this._durationFiltersVO);
               this.typeFilters.setData(this._typeFiltersVO);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.typeFilters.x = width - this.typeFilters.width >> 0;
               this.typeFilterName.x = this.typeFilters.x - this.typeFilterName.width - FILTER_NAME_GAP >> 0;
               this.durationFilters.x = this.typeFilterName.x - FILTERS_GROUP_GAP - this.durationFilters.width >> 0;
               this.qualityFilterName.x = this.durationFilters.x - this.qualityFilterName.width - FILTER_NAME_GAP >> 0;
            }
         }
      }
      
      public function resetFilters(param1:int) : void
      {
         this._resetData = param1;
         invalidate(INVALID_RESET);
      }
      
      public function setData(param1:ButtonFiltersVO, param2:ButtonFiltersVO) : void
      {
         this._typeFiltersVO = param1;
         this._durationFiltersVO = param2;
         invalidateData();
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
      
      private function onFilterBlockResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onFilterBlockFiltersChangedHandler(param1:FiltersEvent) : void
      {
         var _loc2_:int = this.durationFilters.filtersValue | this.typeFilters.filtersValue;
         dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,_loc2_));
      }
   }
}
