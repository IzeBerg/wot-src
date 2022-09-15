package net.wg.gui.lobby.storage.categories.personalreserves
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.ButtonFilters;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.storage.categories.BaseFilterBlock;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalReserveFilterBlock extends BaseFilterBlock
   {
      
      private static const FILTERS_BUTTON_GAP:int = 7;
      
      private static const FILTER_NAME_GAP:int = 7;
      
      private static const FILTERS_BLOCK_GAP:int = 20;
      
      private static const INVALID_RESET:String = "invalidateResetData";
       
      
      public var buyButton:SoundButtonEx;
      
      public var typeFilters:ButtonFilters = null;
      
      public var typeFilterName:TextField = null;
      
      private var _resetData:int = 0;
      
      private var _typeFiltersVO:ButtonFiltersVO;
      
      private var _onBuyInStoreClicked:Function;
      
      public function PersonalReserveFilterBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setupFilter(this.typeFilters);
         this.typeFilterName.text = STORAGE.PERSONALRESERVES_TYPEFILTER_LABEL;
         this.typeFilterName.autoSize = TextFieldAutoSize.LEFT;
         this.buyButton.label = PERSONAL_RESERVES.DEPOT_BUYBUTTON;
         this.buyButton.addEventListener(MouseEvent.CLICK,this.onBuyButtonClickedHandle);
      }
      
      override protected function onDispose() : void
      {
         this._typeFiltersVO = null;
         this.typeFilterName = null;
         this.clearFilter(this.typeFilters);
         this.typeFilters = null;
         this.buyButton.removeEventListener(MouseEvent.CLICK,this.onBuyButtonClickedHandle);
         this.buyButton = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._typeFiltersVO)
         {
            if(isInvalid(INVALID_RESET))
            {
               this.typeFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
               this.typeFilters.resetFilters(this._resetData);
               this.typeFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFilterBlockFiltersChangedHandler);
            }
            if(isInvalid(InvalidationType.DATA))
            {
               this.typeFilters.setData(this._typeFiltersVO);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.buyButton.x = width - this.buyButton.width;
               this.typeFilters.x = this.buyButton.x - this.buyButton.width - FILTERS_BLOCK_GAP;
               this.typeFilterName.x = this.typeFilters.x - this.typeFilterName.width - FILTER_NAME_GAP >> 0;
            }
         }
      }
      
      public function resetFilters(param1:int) : void
      {
         this._resetData = param1;
         invalidate(INVALID_RESET);
      }
      
      public function setData(param1:ButtonFiltersVO, param2:Function) : void
      {
         this._typeFiltersVO = param1;
         this._onBuyInStoreClicked = param2;
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
         dispatchEvent(new FiltersEvent(FiltersEvent.FILTERS_CHANGED,this.typeFilters.filtersValue));
      }
      
      private function onBuyButtonClickedHandle(param1:MouseEvent) : void
      {
         this._onBuyInStoreClicked();
      }
   }
}
