package net.wg.gui.components.carousels
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.components.controls.events.ScrollEvent;
   import net.wg.gui.components.controls.interfaces.IArrowButton;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ScrollCarousel extends UIComponentEx
   {
       
      
      public var scrollList:IScroller = null;
      
      public var startFadeMask:Sprite = null;
      
      public var endFadeMask:Sprite = null;
      
      public var leftArrow:IArrowButton = null;
      
      public var rightArrow:IArrowButton = null;
      
      protected var leftArrowOffset:int = 0;
      
      protected var rightArrowOffset:int = 0;
      
      protected var hasScrollButtons:Boolean = false;
      
      private var _isArrowScroll:Boolean = false;
      
      private var _roundCountRenderer:Boolean = true;
      
      public function ScrollCarousel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.scrollList.mouseWheelDirection = DirectionMode.HORIZONTAL;
         this.scrollList.addEventListener(ScrollEvent.SCROLL_COMPLETE,this.onScrollListScrollCompleteHandler);
         this.scrollList.addEventListener(ScrollEvent.SCROLL_START,this.onScrollListScrollStartHandler);
         this.scrollList.addEventListener(Event.RESIZE,this.onScrollListResizeHandler);
         this.hasScrollButtons = this.leftArrow != null && this.rightArrow != null;
         if(this.hasScrollButtons)
         {
            this.leftArrowOffset = this.leftArrow.x - this.scrollList.x >> 0;
            this.rightArrowOffset = this.rightArrow.x - this.scrollList.x - this.scrollList.width >> 0;
            this.leftArrow.addEventListener(ButtonEvent.PRESS,this.onLeftArrowPressHandler);
            this.leftArrow.addEventListener(ButtonEvent.CLICK,this.onArrowClickHandler);
            this.leftArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
            this.rightArrow.addEventListener(ButtonEvent.PRESS,this.onRightArrowPressHandler);
            this.rightArrow.addEventListener(ButtonEvent.CLICK,this.onArrowClickHandler);
            this.rightArrow.addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.hasScrollButtons)
         {
            this.leftArrow.removeEventListener(ButtonEvent.PRESS,this.onLeftArrowPressHandler);
            this.leftArrow.removeEventListener(ButtonEvent.CLICK,this.onArrowClickHandler);
            this.leftArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
            this.rightArrow.removeEventListener(ButtonEvent.PRESS,this.onRightArrowPressHandler);
            this.rightArrow.removeEventListener(ButtonEvent.CLICK,this.onArrowClickHandler);
            this.rightArrow.removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onArrowReleaseOutsideHandler);
            if(this._isArrowScroll)
            {
               this.scrollList.stopScroll();
            }
            this.leftArrow.dispose();
            this.leftArrow = null;
            this.rightArrow.dispose();
            this.rightArrow = null;
         }
         this.scrollList.removeEventListener(ScrollEvent.SCROLL_COMPLETE,this.onScrollListScrollCompleteHandler);
         this.scrollList.removeEventListener(ScrollEvent.SCROLL_START,this.onScrollListScrollStartHandler);
         this.scrollList.removeEventListener(Event.RESIZE,this.onScrollListResizeHandler);
         this.scrollList.dispose();
         this.scrollList = null;
         this.startFadeMask = null;
         this.endFadeMask = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.scrollList.pageWidth == 0 || this.scrollList.pageHeight == 0)
            {
               this.scrollList.validateNow();
            }
            this.updateLayout(width);
         }
      }
      
      public function goToItem(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         this.scrollList.goToItem(param1,param2,param3);
      }
      
      protected function updateLayout(param1:int, param2:int = 0) : void
      {
         var _loc3_:int = param1;
         if(this.hasScrollButtons)
         {
            _loc3_ += this.leftArrowOffset - this.rightArrowOffset >> 0;
         }
         if(this._roundCountRenderer)
         {
            _loc3_ = (_loc3_ / this.scrollList.pageWidth >> 0) * this.scrollList.pageWidth - this.scrollList.horizontalGap;
         }
         this.scrollList.width = _loc3_;
         this.scrollList.x = param2;
         if(this.hasScrollButtons)
         {
            this.leftArrow.x = this.scrollList.x + this.leftArrowOffset >> 0;
            this.rightArrow.x = this.scrollList.x + _loc3_ + this.rightArrowOffset >> 0;
         }
      }
      
      protected function updateAvailableScroll(param1:Boolean, param2:Boolean) : void
      {
         if(this.hasScrollButtons)
         {
            this.leftArrow.enabled = param1;
            this.rightArrow.enabled = param2;
         }
      }
      
      protected function scrollListResizeComplete() : void
      {
         this.updateAvailableScroll(this.scrollList.availableScrollLeft,this.scrollList.availableScrollRight);
      }
      
      protected function onScrollListScrollComplete() : void
      {
         this.updateAvailableScroll(this.scrollList.availableScrollLeft,this.scrollList.availableScrollRight);
         if(this._isArrowScroll)
         {
            this.stopScroll();
         }
      }
      
      protected function stopScroll() : void
      {
         this._isArrowScroll = false;
         this.scrollList.stopScroll();
      }
      
      public function get rendererWidth() : Number
      {
         return this.scrollList.rendererWidth;
      }
      
      public function set rendererWidth(param1:Number) : void
      {
         this.scrollList.rendererWidth = param1;
      }
      
      public function get rendererHeight() : Number
      {
         return this.scrollList.rendererHeight;
      }
      
      public function set rendererHeight(param1:Number) : void
      {
         this.scrollList.rendererHeight = param1;
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this.scrollList.dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         this.scrollList.dataProvider = param1;
      }
      
      public function get pageWidth() : Number
      {
         return this.scrollList.pageWidth;
      }
      
      public function set pageWidth(param1:Number) : void
      {
         this.scrollList.pageWidth = param1;
      }
      
      public function get pageHeight() : Number
      {
         return this.scrollList.pageHeight;
      }
      
      public function set pageHeight(param1:Number) : void
      {
         this.scrollList.pageHeight = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this.scrollList.selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         this.scrollList.selectedIndex = param1;
      }
      
      [Inspectable(name="itemRenderer",type="String")]
      public function get itemRenderer() : String
      {
         return this.scrollList.itemRendererClassReference;
      }
      
      public function set itemRenderer(param1:String) : void
      {
         this.scrollList.itemRendererClassReference = param1;
      }
      
      [Inspectable(name="horizontalGap",type="Number")]
      public function get horizontalGap() : int
      {
         return this.scrollList.horizontalGap;
      }
      
      public function set horizontalGap(param1:int) : void
      {
         this.scrollList.horizontalGap = param1;
      }
      
      [Inspectable(name="verticalGap",type="Number")]
      public function get verticalGap() : int
      {
         return this.scrollList.verticalGap;
      }
      
      public function set verticalGap(param1:int) : void
      {
         this.scrollList.verticalGap = param1;
      }
      
      public function get roundCountRenderer() : Boolean
      {
         return this._roundCountRenderer;
      }
      
      public function set roundCountRenderer(param1:Boolean) : void
      {
         this._roundCountRenderer = param1;
         invalidateSize();
      }
      
      private function onLeftArrowPressHandler(param1:ButtonEvent) : void
      {
         this._isArrowScroll = true;
         this.scrollList.startScrollToBegin();
      }
      
      private function onRightArrowPressHandler(param1:ButtonEvent) : void
      {
         this._isArrowScroll = true;
         this.scrollList.startScrollToEnd();
      }
      
      private function onArrowClickHandler(param1:Event) : void
      {
         this.stopScroll();
      }
      
      private function onArrowReleaseOutsideHandler(param1:Event) : void
      {
         this.stopScroll();
      }
      
      private function onScrollListResizeHandler(param1:Event) : void
      {
         this.scrollListResizeComplete();
      }
      
      private function onScrollListScrollCompleteHandler(param1:Event) : void
      {
         this.onScrollListScrollComplete();
      }
      
      private function onScrollListScrollStartHandler(param1:Event) : void
      {
         this.updateAvailableScroll(this.scrollList.availableScrollLeft,this.scrollList.availableScrollRight);
      }
   }
}
