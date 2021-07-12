package net.wg.gui.lobby.storage.categories
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.SearchInput;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class StorageVehicleFilterBlock extends BaseFilterBlock implements IPopOverCaller
   {
      
      private static const SEARCH_INPUT_OFFSET:int = 5;
       
      
      public var paramsFilter:ButtonIconNormal;
      
      public var searchInput:SearchInput;
      
      private var _searchInputTooltip:String;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _vehicleName:String;
      
      public function StorageVehicleFilterBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._toolTipMgr = null;
         this.searchInput.removeEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.searchInput.dispose();
         this.searchInput = null;
         this.paramsFilter.removeEventListener(ButtonEvent.CLICK,this.onParamsFilterClickHandler);
         this.paramsFilter.dispose();
         this.paramsFilter = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._toolTipMgr = App.toolTipMgr;
         this.searchInput.addEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.paramsFilter.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_PARAMS;
         this.paramsFilter.tooltip = TANK_CAROUSEL_FILTER.TOOLTIP_PARAMS;
         this.paramsFilter.addEventListener(ButtonEvent.CLICK,this.onParamsFilterClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.paramsFilter.x = width - this.paramsFilter.width >> 0;
            this.searchInput.x = this.paramsFilter.x - this.searchInput.width - SEARCH_INPUT_OFFSET >> 0;
         }
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.paramsFilter;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.paramsFilter;
      }
      
      public function updateSearch(param1:String, param2:String, param3:String, param4:int) : void
      {
         this.searchInput.defaultText = param1;
         this.searchInput.text = param2;
         this.searchInput.maxChars = param4;
         this._searchInputTooltip = param3;
      }
      
      protected function get filterPopoverAlias() : String
      {
         throw new AbstractException("BaseCarouselFilterBlock.filterPopoverAlias" + Errors.ABSTRACT_INVOKE);
      }
      
      private function onParamsFilterClickHandler(param1:ButtonEvent) : void
      {
         App.popoverMgr.show(this,this.filterPopoverAlias);
      }
      
      private function onSearchInputRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._searchInputTooltip);
      }
      
      private function onSearchInputRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onSearchInputChangeHandler(param1:Event) : void
      {
         var _loc3_:FiltersEvent = null;
         var _loc2_:String = this.searchInput.text;
         if(this._vehicleName != _loc2_)
         {
            this._vehicleName = _loc2_;
            _loc3_ = new FiltersEvent(FiltersEvent.SEARCH_VALUE_CHANGED);
            _loc3_.searchValue = _loc2_;
            dispatchEvent(_loc3_);
         }
      }
   }
}
