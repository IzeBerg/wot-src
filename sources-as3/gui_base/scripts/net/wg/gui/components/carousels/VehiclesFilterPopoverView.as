package net.wg.gui.components.carousels
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.interfaces.ISearchInput;
   import net.wg.gui.components.carousels.data.FilterCarouseInitVO;
   import net.wg.gui.components.carousels.data.FiltersStateVO;
   import net.wg.gui.components.carousels.events.FiltersTileListEvent;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.infrastructure.base.meta.ITankCarouselFilterPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.TankCarouselFilterPopoverMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehiclesFilterPopoverView extends TankCarouselFilterPopoverMeta implements ITankCarouselFilterPopoverMeta
   {
      
      protected static const PADDING:int = 17;
      
      protected static const SEPARATOR_OFFSET:int = -26;
      
      protected static const SEARCH_INPUT_OFFSET:int = 18;
       
      
      public var lblTitle:TextField = null;
      
      public var countVehicles:TextField = null;
      
      public var content:VehiclesFilterPopoverContent = null;
      
      public var searchInput:ISearchInput = null;
      
      public var separatorTop:DisplayObject = null;
      
      public var separatorBottom:DisplayObject = null;
      
      protected var initData:FilterCarouseInitVO = null;
      
      private var _vehicleName:String = null;
      
      private var _caller:DisplayObject = null;
      
      public function VehiclesFilterPopoverView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.searchInput.addEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.content.addEventListener(FiltersTileListEvent.ITEM_CLICK,this.onContentItemClickHandler);
         this.content.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this._caller = App.popoverMgr.popoverCaller as DisplayObject;
         this._caller.addEventListener(Event.RESIZE,this.onCallerResizeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            updateCallerGlobalPosition();
            popoverLayout.invokeLayout();
         }
         if(this.initData && isInvalid(InvalidationType.DATA))
         {
            this.lblTitle.htmlText = this.initData.titleLabel;
            this.searchInput.visible = this.separatorBottom.visible = this.initData.searchSectionVisible;
            this.searchInput.defaultText = this.initData.searchInputLabel;
            this.searchInput.text = this.initData.searchInputName;
            this.searchInput.maxChars = this.initData.searchInputMaxChars;
            popoverLayout.changeableArrowDirection = this.initData.changeableArrowDirection;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = this.getPreferredLayout();
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function onDispose() : void
      {
         this.searchInput.removeEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.searchInput.dispose();
         this.searchInput = null;
         this.content.removeEventListener(FiltersTileListEvent.ITEM_CLICK,this.onContentItemClickHandler);
         this.content.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.content.dispose();
         this.content = null;
         this.lblTitle = null;
         this.countVehicles = null;
         this.separatorBottom = null;
         this.separatorTop = null;
         this.initData = null;
         if(this._caller)
         {
            this._caller.removeEventListener(Event.RESIZE,this.onCallerResizeHandler);
            this._caller = null;
         }
         super.onDispose();
      }
      
      override protected function setInitData(param1:FilterCarouseInitVO) : void
      {
         if(this.initData != param1)
         {
            this.initData = param1;
            this.content.setInitData(param1);
            invalidateData();
         }
      }
      
      override protected function setState(param1:FiltersStateVO) : void
      {
         this.content.setStateData(param1);
      }
      
      public function as_showCounter(param1:String) : void
      {
         this.countVehicles.htmlText = param1;
      }
      
      protected function getPreferredLayout() : int
      {
         return PopOverConst.ARROW_TOP;
      }
      
      protected function updateSize() : void
      {
         setViewSize(width,this.getNewHeight(this.content.y + this.content.height));
      }
      
      protected function getNewHeight(param1:int) : int
      {
         if(this.initData.searchSectionVisible)
         {
            this.separatorBottom.y = param1 + SEPARATOR_OFFSET;
            this.searchInput.y = this.separatorBottom.y + this.separatorBottom.height + SEARCH_INPUT_OFFSET | 0;
            param1 = this.searchInput.y + this.searchInput.height + PADDING;
         }
         return param1;
      }
      
      private function onContentItemClickHandler(param1:FiltersTileListEvent) : void
      {
         changeFilterS(param1.groupId,param1.itemId);
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         invalidateSize();
         validateNow();
      }
      
      private function onSearchInputRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onSearchInputRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this.initData.searchInputTooltip);
      }
      
      private function onCallerResizeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
      
      private function onSearchInputChangeHandler(param1:Event) : void
      {
         var _loc2_:String = this.searchInput.text;
         if(this._vehicleName != _loc2_)
         {
            this._vehicleName = _loc2_;
            changeSearchNameVehicleS(this._vehicleName);
         }
      }
   }
}
