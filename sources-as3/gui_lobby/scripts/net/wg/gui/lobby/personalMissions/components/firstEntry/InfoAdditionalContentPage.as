package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.common.ArrowButtonWithNumber;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.personalMissions.data.InfoAdditionalDataVO;
   import net.wg.gui.lobby.personalMissions.events.FirstEntryCardEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class InfoAdditionalContentPage extends UIComponentEx
   {
      
      private static const SCROLL_BAR_PADDING:int = 10;
      
      private static const SCROLL_STEP_FACTOR:Number = 30;
      
      private static const BACK_BTN_RIGHT_MARGIN:int = 7;
      
      private static const ARROW_MARGIN:int = 50;
      
      private static const TWEEN_CONTENT_DELTA_Y:int = 350;
      
      protected static const TWEEN_CONTENT_SHOW_DURATION:int = 800;
      
      protected static const TWEEN_CONTROLS_SHOW_DURATION:int = 400;
      
      protected static const TWEEN_ARROW_DELTA_X:int = 50;
      
      protected static const TWEEN_BACK_BTN_DELTA_X:int = -50;
      
      protected static const CONTENT_SHOW_DELAY:int = 400;
      
      protected static const TWEEN_BTN_BACK_DELAY:int = TWEEN_CONTENT_SHOW_DURATION + CONTENT_SHOW_DELAY;
      
      protected static const TWEEN_ARROW_DELAY:int = TWEEN_BTN_BACK_DELAY + 200;
      
      protected static const TWEEN_SCROLL_DELAY:int = TWEEN_ARROW_DELAY + 200;
      
      protected static const HIDE_ARROW_PAGINATION_WIDTH_BREAK_POINT:int = 1100;
       
      
      public var solidBg:Sprite = null;
      
      public var arrowLeft:ArrowButtonWithNumber = null;
      
      public var arrowRight:ArrowButtonWithNumber = null;
      
      public var infoResizableScrollPane:ResizableScrollPane = null;
      
      public var content:InfoAdditionalContent = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var backBtn:BackButton = null;
      
      private var _slotIndex:int = -1;
      
      private var _allCards:int = -1;
      
      private var _dataData:InfoAdditionalDataVO = null;
      
      private var _tweenContent:Tween = null;
      
      private var _arrowLeftTween:Tween = null;
      
      private var _arrowRightTween:Tween = null;
      
      private var _scrollTween:Tween = null;
      
      private var _backBtnTween:Tween = null;
      
      private var _isTweenInProgress:Boolean = false;
      
      private var _firstShow:Boolean = true;
      
      public function InfoAdditionalContentPage()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.content.setSize(param1,param2);
         this.infoResizableScrollPane.setSize(param1,param2);
         this.arrowRight.visiblePagination = this.arrowLeft.visiblePagination = param1 > HIDE_ARROW_PAGINATION_WIDTH_BREAK_POINT;
         this.arrowLeft.height = this.arrowRight.height = _height - (SCROLL_BAR_PADDING << 1);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         this.hideControls();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hideControls();
         this.backBtn.label = PERSONAL_MISSIONS.PERSONALMISSIONFIRSTENTRYVIEW_DETAILEDDESCRIPTION_BTNBACK;
         this.scrollBar.y = SCROLL_BAR_PADDING;
         this.arrowLeft.y = this.arrowRight.y = SCROLL_BAR_PADDING;
         this.infoResizableScrollPane.scrollBar = this.scrollBar;
         this.infoResizableScrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.infoResizableScrollPane.isTargetHorizontalCentered = true;
         this.infoResizableScrollPane.target = this.content;
         this.infoResizableScrollPane.enabled = false;
         this.content.addEventListener(Event.COMPLETE,this.onContentCompleteHandler);
         this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.arrowLeft.initData(ArrowButtonWithNumber.BTN_TYPE_LEFT);
         this.arrowRight.initData(ArrowButtonWithNumber.BTN_TYPE_RIGHT);
         this.arrowLeft.addEventListener(ButtonEvent.CLICK,this.onArrowLeftBtnClickHandler);
         this.arrowLeft.addEventListener(MouseEvent.MOUSE_WHEEL,this.onArrowMouseWheelHandler);
         this.arrowRight.addEventListener(ButtonEvent.CLICK,this.onArrowRightBtnClickHandler);
         this.arrowRight.addEventListener(MouseEvent.MOUSE_WHEEL,this.onArrowMouseWheelHandler);
      }
      
      override protected function onDispose() : void
      {
         this.clearAllTweens();
         this.arrowLeft.removeEventListener(ButtonEvent.CLICK,this.onArrowLeftBtnClickHandler);
         this.arrowLeft.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onArrowMouseWheelHandler);
         this.arrowRight.removeEventListener(ButtonEvent.CLICK,this.onArrowRightBtnClickHandler);
         this.arrowRight.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onArrowMouseWheelHandler);
         this.arrowLeft.dispose();
         this.arrowLeft = null;
         this.arrowRight.dispose();
         this.arrowRight = null;
         this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.backBtn.dispose();
         this.backBtn = null;
         this.content.removeEventListener(Event.COMPLETE,this.onContentCompleteHandler);
         this.content = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.infoResizableScrollPane.dispose();
         this.infoResizableScrollPane = null;
         this.solidBg = null;
         this._dataData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._dataData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this._slotIndex = this._dataData.index;
               this.arrowLeft.label = this.getArrowIndex(this._slotIndex - 1);
               this.arrowRight.label = this.getArrowIndex(this._slotIndex + 1);
               this.createContent(this._dataData);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(this._isTweenInProgress)
               {
                  this.clearAllTweens();
                  this.onShowControlsCompleted();
               }
               _loc1_ = _width >> 1;
               this.solidBg.width = _width;
               this.solidBg.height = _height;
               this.solidBg.x = -_loc1_;
               this.backBtn.x = -_loc1_ + BACK_BTN_RIGHT_MARGIN;
               this.scrollBar.x = _loc1_ - this.scrollBar.width - SCROLL_BAR_PADDING;
               this.scrollBar.height = _height - (SCROLL_BAR_PADDING << 1);
               this.arrowLeft.x = -_loc1_ + ARROW_MARGIN;
               this.arrowRight.x = _loc1_ - ARROW_MARGIN;
            }
         }
      }
      
      public function clear() : void
      {
         this.content.clear();
         this._firstShow = true;
      }
      
      public function setData(param1:InfoAdditionalDataVO, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._allCards = param2;
         this._dataData = param1;
         invalidateData();
      }
      
      public function updateSettings(param1:PMInfoAdditionalViewSettings) : void
      {
         this.content.setSettings(param1);
      }
      
      private function clearAllTweens() : void
      {
         if(this._tweenContent)
         {
            this._tweenContent.dispose();
            this._tweenContent = null;
         }
         if(this._arrowLeftTween)
         {
            this._arrowLeftTween.dispose();
            this._arrowLeftTween = null;
         }
         if(this._arrowRightTween)
         {
            this._arrowRightTween.dispose();
            this._arrowRightTween = null;
         }
         if(this._scrollTween)
         {
            this._scrollTween.dispose();
            this._scrollTween = null;
         }
         if(this._backBtnTween)
         {
            this._backBtnTween.dispose();
            this._backBtnTween = null;
         }
      }
      
      private function getArrowIndex(param1:int) : String
      {
         if(param1 >= this._allCards)
         {
            param1 = Values.ZERO;
         }
         else if(param1 < Values.ZERO)
         {
            param1 = this._allCards - 1;
         }
         return (param1 + 1).toString();
      }
      
      private function createContent(param1:InfoAdditionalDataVO) : void
      {
         this.content.setData(param1);
      }
      
      private function showAnimContent() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.clearAllTweens();
         this.hideControls();
         this._isTweenInProgress = true;
         this.content.alpha = Values.ZERO;
         this.content.y = TWEEN_CONTENT_DELTA_Y;
         this.infoResizableScrollPane.enabled = false;
         var _loc1_:int = !!this._firstShow ? int(CONTENT_SHOW_DELAY) : int(Values.ZERO);
         this._tweenContent = new Tween(TWEEN_CONTENT_SHOW_DURATION,this.content,{
            "y":0,
            "alpha":Values.DEFAULT_ALPHA
         },{
            "paused":false,
            "ease":Cubic.easeOut,
            "delay":_loc1_,
            "fastTransform":false,
            "onComplete":(!!this._firstShow ? null : this.onShowControlsCompleted)
         });
         if(this._firstShow)
         {
            _loc2_ = _width >> 1;
            _loc3_ = Values.ZERO;
            _loc3_ = -_loc2_ + ARROW_MARGIN;
            this.arrowLeft.x = _loc3_ - TWEEN_ARROW_DELTA_X;
            this._arrowLeftTween = new Tween(TWEEN_CONTROLS_SHOW_DURATION,this.arrowLeft,{
               "x":_loc3_,
               "alpha":Values.DEFAULT_ALPHA
            },{
               "paused":false,
               "ease":Cubic.easeOut,
               "delay":TWEEN_ARROW_DELAY,
               "fastTransform":false
            });
            _loc3_ = _loc2_ - ARROW_MARGIN;
            this.arrowRight.x = _loc3_ + TWEEN_ARROW_DELTA_X;
            this._arrowRightTween = new Tween(TWEEN_CONTROLS_SHOW_DURATION,this.arrowRight,{
               "x":_loc3_,
               "alpha":Values.DEFAULT_ALPHA
            },{
               "paused":false,
               "ease":Cubic.easeOut,
               "delay":TWEEN_ARROW_DELAY,
               "fastTransform":false
            });
            _loc3_ = -_loc2_ + BACK_BTN_RIGHT_MARGIN;
            this.backBtn.x = _loc3_ + TWEEN_BACK_BTN_DELTA_X;
            this._backBtnTween = new Tween(TWEEN_CONTROLS_SHOW_DURATION,this.backBtn,{
               "x":_loc3_,
               "alpha":Values.DEFAULT_ALPHA
            },{
               "paused":false,
               "ease":Cubic.easeOut,
               "delay":TWEEN_BTN_BACK_DELAY,
               "fastTransform":false
            });
            this._scrollTween = new Tween(TWEEN_CONTROLS_SHOW_DURATION,this.scrollBar,{"alpha":Values.DEFAULT_ALPHA},{
               "paused":false,
               "ease":Cubic.easeOut,
               "delay":TWEEN_SCROLL_DELAY,
               "fastTransform":false,
               "onComplete":this.onShowControlsCompleted
            });
            this._firstShow = false;
         }
      }
      
      private function hideControls() : void
      {
         if(this._firstShow)
         {
            this.arrowLeft.alpha = this.arrowRight.alpha = this.scrollBar.alpha = this.backBtn.alpha = Values.ZERO;
         }
      }
      
      private function onShowControlsCompleted() : void
      {
         this.arrowLeft.alpha = this.arrowRight.alpha = this.scrollBar.alpha = this.backBtn.alpha = Values.DEFAULT_ALPHA;
         this.infoResizableScrollPane.enabled = true;
         this._isTweenInProgress = false;
      }
      
      private function onArrowMouseWheelHandler(param1:MouseEvent) : void
      {
         this.infoResizableScrollPane.doMouseWheel(param1.delta);
      }
      
      private function onArrowLeftBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new FirstEntryCardEvent(FirstEntryCardEvent.TO_PREV,this._slotIndex));
      }
      
      private function onArrowRightBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new FirstEntryCardEvent(FirstEntryCardEvent.TO_NEXT,this._slotIndex));
      }
      
      private function onContentCompleteHandler(param1:Event) : void
      {
         this.infoResizableScrollPane.scrollPosition = Values.ZERO;
         this.showAnimContent();
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new FirstEntryCardEvent(FirstEntryCardEvent.CLOSE_DESCRIPTION,this._slotIndex));
      }
   }
}
