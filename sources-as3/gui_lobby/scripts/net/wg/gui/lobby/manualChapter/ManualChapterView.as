package net.wg.gui.lobby.manualChapter
{
   import fl.motion.easing.Linear;
   import fl.transitions.easing.Regular;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import net.wg.gui.bootcamp.interfaces.IAnimatedButtonRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.paginator.PaginationDetailsNumButton;
   import net.wg.gui.components.paginator.PaginationGroup;
   import net.wg.gui.components.paginator.PaginatorArrowsController;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.manualChapter.controls.ManualBackgroundContainer;
   import net.wg.gui.lobby.manualChapter.controls.VideoContainer;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterContainerVO;
   import net.wg.gui.lobby.manualChapter.data.ManualPageDetailedViewVO;
   import net.wg.gui.lobby.manualChapter.events.ManualViewEvent;
   import net.wg.infrastructure.base.meta.IManualChapterViewMeta;
   import net.wg.infrastructure.base.meta.impl.ManualChapterViewMeta;
   import net.wg.infrastructure.uilogger.manual.ManualPageLogger;
   import net.wg.utils.ICounterManager;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class ManualChapterView extends ManualChapterViewMeta implements IManualChapterViewMeta
   {
      
      private static const ARROW_BTN_GAP:int = 50;
      
      private static const INV_PAGE:String = "InvPage";
      
      private static const MANUAL_CHAPTER_GROUP:String = "ManualChapterGroup";
      
      private static const NUM_GAP:int = 50;
      
      private static const TOP_PANEL_HEIGHT:int = 34;
      
      private static const FADE_IN_DELAY:Number = 200;
      
      private static const FADE_IN_DURATION:Number = 400;
      
      private static const MIN_PAGES:int = 1;
      
      private static const VIEW_CENTER_OFFSET:int = 10;
      
      private static const CLOSE_BTN_PADDING:int = 40;
      
      private static const MIN_FULL_WIDTH:int = 1920;
      
      private static const MIN_FULL_HEIGHT:int = 926;
      
      private static const SMALL_SCALE:Number = 0.7;
      
      private static const FULL_SCALE:int = 1;
      
      private static const TWEEN_DURATION:int = 300;
      
      private static const RIGHT_TWEEN_HEIGHT_OFFSET:int = 340;
      
      private static const LEFT_TWEEN_HEIGHT_OFFSET:int = 110;
      
      private static const SWAP_ROTATION:int = 15;
      
      private static const STACK_IMAGE_OFFSET:int = 80;
      
      private static const IN_LABEL:String = "in";
      
      private static const OUT_LABEL:String = "out";
      
      private static const MAX_PAGES:int = 20;
      
      private static const PAGES_GAP:int = -8;
       
      
      public var view:ManualPageView;
      
      public var arrowLeftBtn:ISoundButtonEx;
      
      public var arrowRightBtn:ISoundButtonEx;
      
      public var pageButtons:PaginationGroup;
      
      public var bg:Sprite;
      
      public var pageBackground:ManualBackgroundContainer;
      
      public var prevBackground:ManualBackgroundContainer;
      
      public var stackBackground:UILoaderAlt;
      
      public var btnClose:IAnimatedButtonRenderer = null;
      
      private var _data:ManualChapterContainerVO;
      
      private var _pages:DataProvider = null;
      
      private var _currentMissionIndex:int = -1;
      
      private var _fadeTween:Tween;
      
      private var _bgFadeTween:Tween;
      
      private var _swapTween1:Tween;
      
      private var _swapTween2:Tween;
      
      private var _goRight:Boolean = false;
      
      private var _viewOpacity:Number = 1;
      
      private var _contentScale:Number = 1;
      
      private var _isNewPage:Boolean = false;
      
      private var _pageController:PaginatorArrowsController = null;
      
      private var _counterManager:ICounterManager;
      
      private var _logger:ManualPageLogger = null;
      
      public function ManualChapterView()
      {
         this._counterManager = App.utils.counterManager;
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._contentScale = param1 >= MIN_FULL_WIDTH && param2 >= MIN_FULL_HEIGHT ? Number(FULL_SCALE) : Number(SMALL_SCALE);
         this.view.updateScaleFactor(this._contentScale);
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this);
      }
      
      override protected function setPages(param1:DataProvider) : void
      {
         this._pages = param1;
         invalidateData();
      }
      
      override protected function setInitData(param1:ManualChapterContainerVO) : void
      {
         this._data = param1;
         this._pages = param1.pages;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.pageBackground.dispose();
         this.pageBackground = null;
         this.prevBackground.dispose();
         this.prevBackground = null;
         this._data = null;
         this._counterManager = null;
         this.view.dispose();
         this.view = null;
         this.stackBackground.dispose();
         this.stackBackground = null;
         this.arrowLeftBtn.dispose();
         this.arrowLeftBtn = null;
         this.arrowRightBtn.dispose();
         this.arrowRightBtn = null;
         this.pageButtons.dispose();
         this.pageButtons = null;
         this.bg = null;
         this._bgFadeTween.dispose();
         this._bgFadeTween = null;
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
         this.btnClose.dispose();
         this.btnClose = null;
         this.clearTweens();
         this._pageController.dispose();
         this._pageController = null;
         if(this._logger)
         {
            this._logger.stopPageLog();
            this._logger.dispose();
            this._logger = null;
         }
         this._pages = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._pageController = new PaginatorArrowsController(this,this.pageButtons,this.arrowLeftBtn,this.arrowRightBtn,MANUAL_CHAPTER_GROUP,MAX_PAGES,true,PAGES_GAP,true);
         this.viewOpacity = 0;
         this.bg.alpha = 0;
         this._bgFadeTween = new Tween(FADE_IN_DURATION,this.bg,{"alpha":1},{
            "paused":false,
            "ease":Linear.easeOut
         });
         this._logger = new ManualPageLogger();
         this.addListeners();
      }
      
      override protected function draw() : void
      {
         var _loc1_:DataProvider = null;
         var _loc2_:int = 0;
         var _loc3_:PaginatorPageNumVO = null;
         var _loc4_:int = 0;
         var _loc5_:ManualPageDetailedViewVO = null;
         super.draw();
         if(this._pages != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._pages;
            _loc2_ = _loc1_.length;
            if(_loc2_ > MIN_PAGES)
            {
               this._pageController.setPages(_loc1_);
               for each(_loc3_ in _loc1_)
               {
                  if(_loc3_.selected)
                  {
                     this._currentMissionIndex = _loc3_.pageIndex;
                     break;
                  }
               }
            }
            invalidate(INV_PAGE,InvalidationType.SIZE);
            this.playFadeInTween();
         }
         if(this._data != null && isInvalid(INV_PAGE))
         {
            this._pageController.setPageIndex(this._currentMissionIndex);
            _loc4_ = this._data.details.length;
            if(_loc4_ > this._currentMissionIndex)
            {
               _loc5_ = this._data.details[this._currentMissionIndex];
               if(_loc5_ != null)
               {
                  if(this._isNewPage)
                  {
                     this.tweenBackground();
                     this.view.fadeOut();
                     this.btnClose.gotoAndPlay(OUT_LABEL);
                     this._logger.stopPageLog();
                  }
                  else
                  {
                     this.view.fadeIn();
                     this.view.setData(_loc5_);
                     this.btnClose.gotoAndPlay(IN_LABEL);
                     this._logger.startPageLog(_loc5_.id);
                  }
                  this.pageBackground.imageSource = _loc5_.background;
                  this.pageBackground.backgroundSource = RES_ICONS.MAPS_ICONS_MANUAL_BACKGROUNDS_MANUAL_CARD_BACK;
               }
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._pageController)
            {
               this._pageController.updateSize(_width,_height);
            }
            this.updateLayout();
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.stackBackground.source = RES_ICONS.MAPS_ICONS_MANUAL_BACKGROUNDS_IMAGE_BACK;
      }
      
      public function as_showPage(param1:int) : void
      {
         this._goRight = param1 > this._currentMissionIndex;
         this.setPageIndex(param1);
      }
      
      private function setPageIndex(param1:int) : void
      {
         if(this._currentMissionIndex != param1)
         {
            this._isNewPage = this._currentMissionIndex != -1;
            this._currentMissionIndex = param1;
            invalidate(INV_PAGE);
         }
      }
      
      private function clearTweens() : void
      {
         if(this._swapTween1)
         {
            this._swapTween1.dispose();
            this._swapTween1 = null;
         }
         if(this._swapTween2)
         {
            this._swapTween2.dispose();
            this._swapTween2 = null;
         }
      }
      
      private function onSwapComplete() : void
      {
         this._pageController.allowPageChange = true;
         this._isNewPage = false;
         invalidateData();
      }
      
      private function swapBackgrounds() : void
      {
         swapChildren(this.prevBackground,this.pageBackground);
      }
      
      private function tweenBackground() : void
      {
         this._pageController.allowPageChange = false;
         var _loc1_:ManualBackgroundContainer = this.prevBackground;
         this.prevBackground = this.pageBackground;
         this.pageBackground = _loc1_;
         var _loc2_:ManualBackgroundContainer = !!this._goRight ? this.prevBackground : this.pageBackground;
         this.clearTweens();
         var _loc3_:int = this.pageBackground.x;
         var _loc4_:int = this.pageBackground.y;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this._goRight)
         {
            _loc7_ = SWAP_ROTATION;
            _loc5_ = this.pageBackground.x + this.pageBackground.width;
            _loc6_ = this.pageBackground.y - RIGHT_TWEEN_HEIGHT_OFFSET * this._contentScale;
         }
         else
         {
            _loc7_ = -SWAP_ROTATION;
            _loc5_ = this.pageBackground.x - this.pageBackground.width;
            _loc6_ = this.pageBackground.y - LEFT_TWEEN_HEIGHT_OFFSET * this._contentScale;
         }
         this._swapTween1 = new Tween(TWEEN_DURATION,_loc2_,{
            "x":_loc5_,
            "y":_loc6_,
            "rotation":_loc7_
         },{
            "onComplete":this.swapBackgrounds,
            "paused":false,
            "ease":Regular.easeIn
         });
         this._swapTween2 = new Tween(TWEEN_DURATION,_loc2_,{
            "x":_loc3_,
            "y":_loc4_,
            "rotation":0
         },{
            "onComplete":this.onSwapComplete,
            "delay":TWEEN_DURATION,
            "paused":false,
            "ease":Regular.easeOut
         });
         this._swapTween1.fastTransform = false;
         this._swapTween2.fastTransform = false;
      }
      
      private function updateLayout() : void
      {
         this.pageBackground.scaleX = this.pageBackground.scaleY = this._contentScale;
         this.prevBackground.scaleX = this.prevBackground.scaleY = this._contentScale;
         this.stackBackground.scaleX = this.stackBackground.scaleY = this._contentScale;
         this.view.x = width - this.view.width >> 1;
         this.view.y = (height - this.view.height >> 1) - VIEW_CENTER_OFFSET;
         this.pageBackground.x = width - this.pageBackground.width >> 1;
         this.pageBackground.y = (height - this.pageBackground.height >> 1) - VIEW_CENTER_OFFSET;
         this.prevBackground.x = this.pageBackground.x;
         this.prevBackground.y = this.pageBackground.y;
         var _loc1_:Number = STACK_IMAGE_OFFSET * this._contentScale | 0;
         this.stackBackground.x = this.pageBackground.x - _loc1_;
         this.stackBackground.y = this.pageBackground.y - _loc1_;
         this.btnClose.x = this.view.x + this.view.width - CLOSE_BTN_PADDING * this._contentScale | 0;
         this.btnClose.y = this.view.y + CLOSE_BTN_PADDING * this._contentScale | 0;
         this.arrowLeftBtn.height = this.arrowRightBtn.height = this.view.height;
         this.arrowLeftBtn.y = this.arrowRightBtn.y = this.view.y;
         var _loc2_:int = ARROW_BTN_GAP * this._contentScale;
         this.arrowLeftBtn.x = this.view.x - this.arrowLeftBtn.width - _loc2_;
         this.arrowRightBtn.x = this.view.x + this.view.width + this.arrowRightBtn.width + _loc2_;
         var _loc3_:Point = new Point(this.view.x + (this.view.width >> 1),this.view.y + this.view.height + NUM_GAP * this._contentScale);
         this._pageController.setPositions(_loc3_);
         this.bg.width = _width;
         this.bg.height = _height - TOP_PANEL_HEIGHT;
         this.bg.y = TOP_PANEL_HEIGHT;
      }
      
      private function addListeners() : void
      {
         var _loc1_:Button = this.btnClose.button;
         this._pageController.addEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
         _loc1_.addEventListener(ButtonEvent.CLICK,this.onAnimatedButtonContentClickHandler);
         this.view.addEventListener(ManualViewEvent.BUTTON_CLICKED,this.onViewButtonClickedHandler);
         this.view.addEventListener(ManualViewEvent.BOOTCAMP_HIGHLIGHTED,this.onViewBootcampHighlightedHandler);
         this.view.addEventListener(ManualViewEvent.PREVIEW_CLICKED,this.onViewPreviewClickedHandler);
      }
      
      private function removeListeners() : void
      {
         var _loc1_:Button = this.btnClose.button;
         this._pageController.removeEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
         _loc1_.removeEventListener(ButtonEvent.CLICK,this.onAnimatedButtonContentClickHandler);
         this.view.removeEventListener(ManualViewEvent.BUTTON_CLICKED,this.onViewButtonClickedHandler);
         this.view.removeEventListener(ManualViewEvent.BOOTCAMP_HIGHLIGHTED,this.onViewBootcampHighlightedHandler);
         this.view.removeEventListener(ManualViewEvent.PREVIEW_CLICKED,this.onViewPreviewClickedHandler);
      }
      
      private function playFadeInTween() : void
      {
         this._fadeTween = new Tween(FADE_IN_DURATION,this,{"viewOpacity":1},{
            "paused":false,
            "ease":Linear.easeOut,
            "delay":FADE_IN_DELAY
         });
      }
      
      public function get viewOpacity() : Number
      {
         return this._viewOpacity;
      }
      
      public function set viewOpacity(param1:Number) : void
      {
         this._viewOpacity = param1;
         this.arrowLeftBtn.alpha = this.arrowRightBtn.alpha = this.view.alpha = this._viewOpacity;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            closeViewS();
         }
      }
      
      private function onViewButtonClickedHandler(param1:ManualViewEvent) : void
      {
         var _loc2_:ManualPageDetailedViewVO = this._data.details[this._currentMissionIndex];
         pageButtonClickedS(_loc2_.pageType);
      }
      
      private function onViewBootcampHighlightedHandler(param1:ManualViewEvent) : void
      {
         bootcampHighlightedS();
      }
      
      private function onViewPreviewClickedHandler(param1:ManualViewEvent) : void
      {
         var _loc2_:VideoContainer = param1.target as VideoContainer;
         if(_loc2_)
         {
            onPreviewClickedS(_loc2_.getVideoUrl());
         }
      }
      
      private function onAnimatedButtonContentClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onPageControllerChangeHandler(param1:Event) : void
      {
         var _loc3_:ManualPageDetailedViewVO = null;
         var _loc2_:int = PaginationDetailsNumButton(this._pageController.getSelectedButton()).pageIndex;
         this._goRight = _loc2_ > this._currentMissionIndex;
         if(_loc2_ != this._currentMissionIndex)
         {
            _loc3_ = this._data.details[_loc2_];
            onPageChangedS(_loc3_.id);
         }
         this.setPageIndex(_loc2_);
      }
   }
}
