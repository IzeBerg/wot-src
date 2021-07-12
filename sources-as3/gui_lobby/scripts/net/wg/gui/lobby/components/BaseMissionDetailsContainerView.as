package net.wg.gui.lobby.components
{
   import fl.motion.easing.Linear;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.interfaces.IPaginatorArrowsController;
   import net.wg.gui.components.paginator.PaginationDetailsNumButton;
   import net.wg.gui.components.paginator.PaginationGroup;
   import net.wg.gui.components.paginator.PaginatorArrowBtn;
   import net.wg.gui.components.paginator.PaginatorArrowsController;
   import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailsContainerVO;
   import net.wg.gui.lobby.personalMissions.events.PersonalMissionDetailedViewEvent;
   import net.wg.infrastructure.base.interfaces.IWaiting;
   import net.wg.infrastructure.base.meta.IBaseMissionDetailsContainerViewMeta;
   import net.wg.infrastructure.base.meta.impl.BaseMissionDetailsContainerViewMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class BaseMissionDetailsContainerView extends BaseMissionDetailsContainerViewMeta implements IBaseMissionDetailsContainerViewMeta
   {
      
      protected static const MISSION_DETAILS_PAGE_GROUP:String = "MissionDetailsPageGroup";
      
      protected static const TOP_PANEL_HEIGHT:int = 34;
      
      private static const INV_PAGE:String = "InvPage";
      
      private static const INV_PAGINATOR_DATA:String = "InvPaginnatorData";
      
      private static const FADE_IN_DELAY:Number = 200;
      
      private static const FADE_IN_DURATION:Number = 400;
      
      private static const MIN_PAGES:int = 1;
      
      private static const MAX_BUTTONS_PER_PAGE:int = 15;
      
      private static const NUM_GAP:int = 16;
      
      private static const ARROW_HORIZONTAL_GAP:int = 25;
       
      
      public var btnClose:ISoundButtonEx;
      
      public var view:BaseMissionDetailedView;
      
      public var arrowLeftBtn:PaginatorArrowBtn;
      
      public var arrowRightBtn:PaginatorArrowBtn;
      
      public var pageButtons:PaginationGroup;
      
      public var waiting:IWaiting;
      
      public var bg:Sprite;
      
      private var _missionData:BaseMissionDetailedViewVO;
      
      private var _data:BaseMissionDetailsContainerVO;
      
      private var _currentMissionIndex:int = 0;
      
      private var _fadeTween:Tween;
      
      private var _bgFadeTween:Tween;
      
      private var _pageController:IPaginatorArrowsController = null;
      
      private var _viewOpacity:Number = 1.0;
      
      public function BaseMissionDetailsContainerView()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         var _loc2_:InteractiveObject = this.view.getFocusItem();
         if(_loc2_)
         {
            setFocus(_loc2_);
         }
      }
      
      override protected function setInitData(param1:BaseMissionDetailsContainerVO) : void
      {
         this._data = param1;
         invalidate(INV_PAGINATOR_DATA);
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this._pageController.dispose();
         this._pageController = null;
         this._data = null;
         this._missionData = null;
         this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.btnClose.dispose();
         this.btnClose = null;
         this.view.removeEventListener(PersonalMissionDetailedViewEvent.CONTROLS_VISIBLE_SET,this.onViewControlsVisibleSetHandler);
         this.view.dispose();
         this.view = null;
         this.arrowLeftBtn.dispose();
         this.arrowLeftBtn = null;
         this.arrowRightBtn.dispose();
         this.arrowRightBtn = null;
         this.pageButtons.dispose();
         this.pageButtons = null;
         this.bg = null;
         this.waiting.dispose();
         this.waiting = null;
         this._bgFadeTween.paused = true;
         this._bgFadeTween.dispose();
         this._bgFadeTween = null;
         if(this._fadeTween)
         {
            this._fadeTween.paused = true;
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._pageController = this.createPaginatorController();
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.backgroundVisibility = false;
         this.btnClose.label = VEH_COMPARE.HEADER_CLOSEBTN_LABEL;
         this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.btnClose.validateNow();
         this.viewOpacity = 0;
         this.bg.alpha = 0;
         var _loc1_:Number = this.getBgFadeInTweenAlpha();
         this._bgFadeTween = new Tween(FADE_IN_DURATION,this.bg,{"alpha":_loc1_},{
            "paused":false,
            "ease":Linear.easeOut
         });
         this.addListeners();
         this.bg.y = TOP_PANEL_HEIGHT;
         this.view.addEventListener(PersonalMissionDetailedViewEvent.CONTROLS_VISIBLE_SET,this.onViewControlsVisibleSetHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.waiting.show();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DataProvider = null;
         var _loc3_:PaginatorPageNumVO = null;
         var _loc4_:int = 0;
         super.draw();
         if(this._data != null && isInvalid(INV_PAGINATOR_DATA))
         {
            _loc1_ = this._data.len;
            if(_loc1_ > MIN_PAGES)
            {
               _loc2_ = this._data.pages;
               this._pageController.setPages(_loc2_);
               for each(_loc3_ in _loc2_)
               {
                  if(_loc3_.selected)
                  {
                     this._pageController.setPageIndex(_loc3_.pageIndex);
                     break;
                  }
               }
            }
            else
            {
               requestMissionDataS(this._currentMissionIndex);
            }
            invalidate(InvalidationType.SIZE);
            this.waiting.hide();
            this.playFadeInTween();
         }
         if(this._data != null && this._missionData != null && isInvalid(INV_PAGE))
         {
            _loc4_ = this._data.len;
            if(this._currentMissionIndex < _loc4_)
            {
               this.view.setData(this._missionData);
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
            this._pageController.updateSize(_width,_height);
            this.updateArrowsLayout();
            this.updatePaginatorLayout();
         }
      }
      
      override protected function setMissionData(param1:BaseMissionDetailedViewVO) : void
      {
         this._missionData = param1;
         invalidate(INV_PAGE);
      }
      
      protected function createPaginatorController() : IPaginatorArrowsController
      {
         return new PaginatorArrowsController(this,this.pageButtons,this.arrowLeftBtn,this.arrowRightBtn,MISSION_DETAILS_PAGE_GROUP,MAX_BUTTONS_PER_PAGE);
      }
      
      protected function getBgFadeInTweenAlpha() : Number
      {
         return Values.DEFAULT_ALPHA;
      }
      
      protected function updateLayout() : void
      {
         this.waiting.width = _width;
         this.waiting.height = _height;
         this.view.x = _width >> 1;
         this.bg.width = _width;
         this.bg.height = _height - TOP_PANEL_HEIGHT;
      }
      
      protected function updateArrowsLayout() : void
      {
         var _loc1_:int = this.view.width >> 1;
         this.arrowLeftBtn.x = this.view.x - _loc1_ - ARROW_HORIZONTAL_GAP - this.arrowLeftBtn.width | 0;
         this.arrowRightBtn.x = this.view.x + _loc1_ + ARROW_HORIZONTAL_GAP + this.arrowLeftBtn.width | 0;
         this.arrowLeftBtn.y = this.arrowRightBtn.y = this.view.y;
      }
      
      protected function addListeners() : void
      {
         this._pageController.addEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
      }
      
      protected function removeListeners() : void
      {
         this._pageController.removeEventListener(Event.CHANGE,this.onPageControllerChangeHandler);
      }
      
      protected function getPaginatorPos() : Point
      {
         return new Point(this.view.x,this.view.y + this.view.height + NUM_GAP);
      }
      
      private function updatePaginatorLayout() : void
      {
         var _loc1_:Point = this.getPaginatorPos();
         this._pageController.setPositions(_loc1_);
      }
      
      private function updateFocus(param1:InteractiveObject) : void
      {
         if(param1)
         {
            setFocus(param1);
         }
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
         this.arrowLeftBtn.alpha = this.arrowRightBtn.alpha = this.view.alpha = this.btnClose.alpha = param1;
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
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onPageControllerChangeHandler(param1:Event) : void
      {
         var _loc2_:PaginationDetailsNumButton = PaginationDetailsNumButton(this._pageController.getSelectedButton());
         if(_loc2_)
         {
            this._currentMissionIndex = _loc2_.pageIndex;
            requestMissionDataS(this._currentMissionIndex);
         }
      }
      
      private function onViewControlsVisibleSetHandler(param1:PersonalMissionDetailedViewEvent) : void
      {
         this.updateFocus(this.view.getFocusItem());
      }
   }
}
