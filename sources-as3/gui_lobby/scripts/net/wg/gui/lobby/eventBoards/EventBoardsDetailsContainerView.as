package net.wg.gui.lobby.eventBoards
{
   import fl.motion.easing.Linear;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.EVENTBOARDS_ALIASES;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsDetailsContainerVO;
   import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsTopPanel;
   import net.wg.gui.lobby.missions.event.MissionDetailsTopPanelEvent;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.base.interfaces.IWaiting;
   import net.wg.infrastructure.base.meta.IEventBoardsDetailsContainerViewMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsDetailsContainerViewMeta;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class EventBoardsDetailsContainerView extends EventBoardsDetailsContainerViewMeta implements IEventBoardsDetailsContainerViewMeta
   {
      
      private static const TOP_PANEL_HEIGHT:int = 34;
      
      private static const TITLE_OFFSET:int = 2;
      
      private static const MIN_HEIGHT:int = 677;
      
      private static const NUM_BTN_HEIGHT:int = 32;
      
      private static const MIN_CMP_PADDING:int = 12;
      
      private static const FADE_IN_DELAY:Number = 400;
      
      private static const FADE_IN_DURATION:Number = 800;
       
      
      public var topPanel:MissionDetailsTopPanel;
      
      public var waiting:IWaiting;
      
      public var bg:Sprite;
      
      public var bgWindow:MovieClip;
      
      public var container:Sprite = null;
      
      public var titleTf:TextField;
      
      protected var content:BaseDAAPIComponent = null;
      
      protected var contentLinkage:String = "";
      
      private var _data:EventBoardsDetailsContainerVO;
      
      private var _fadeTween:Tween;
      
      private var _bgFadeTween:Tween;
      
      private var _viewOpacity:Number = 1.0;
      
      private var _utils:IUtils;
      
      private var _linkagesDict:Dictionary;
      
      public function EventBoardsDetailsContainerView()
      {
         this._utils = App.utils;
         this._linkagesDict = new Dictionary();
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this);
      }
      
      override protected function setInitData(param1:EventBoardsDetailsContainerVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.waiting.setMessage(WAITING.LOADCONTENT);
         this.waiting.backgroundVisibility = false;
         this.viewOpacity = 0;
         this.bg.alpha = 0;
         this._bgFadeTween = new Tween(FADE_IN_DURATION,this.bg,{"alpha":1},{
            "paused":false,
            "ease":Linear.easeOut
         });
         this.addListeners();
         this.addLinkageWithAlias(EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_BROWSER_LINKAGE,EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_BROWSER_ALIAS);
         this.addLinkageWithAlias(EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_VEHICLES_LINKAGE,EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_VEHICLES_ALIAS);
         this.addLinkageWithAlias(EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_AWARDS_LINKAGE,EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_AWARDS_ALIAS);
         this.addLinkageWithAlias(EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_BATTLE_LINKAGE,EVENTBOARDS_ALIASES.EVENTBOARDS_DETAILS_BATTLE_ALIAS);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.waiting.show();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.waiting.hide();
            this.titleTf.htmlText = this._data.title;
            this.updateContent();
            this.playFadeInTween();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeListeners();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._utils.data.cleanupDynamicObject(this._linkagesDict);
         this._linkagesDict = null;
         this._utils = null;
         if(this.content)
         {
            this.container.removeChild(this.content);
            this.content = null;
         }
         this.container = null;
         this.contentLinkage = null;
         this._data = null;
         this.topPanel.dispose();
         this.topPanel = null;
         this.bg = null;
         this.bgWindow = null;
         this.waiting.dispose();
         this.waiting = null;
         this._bgFadeTween.dispose();
         this._bgFadeTween = null;
         this.titleTf = null;
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
         super.onDispose();
      }
      
      protected function updateContent() : void
      {
         if(this.contentLinkage == this._data.linkage)
         {
            return;
         }
         if(this.content)
         {
            this.container.removeChild(this.content);
            unregisterFlashComponentS(this.getAliasByLinkage(this.contentLinkage));
            this.content = null;
         }
         this.contentLinkage = this._data.linkage;
         this.content = this._utils.classFactory.getComponent(this.contentLinkage,BaseDAAPIComponent);
         this.container.addChild(this.content);
         registerFlashComponentS(this.content,this.getAliasByLinkage(this.contentLinkage));
      }
      
      private function updateLayout() : void
      {
         this.waiting.width = width;
         this.waiting.height = height;
         if(this._data.bgWidth != Values.DEFAULT_INT)
         {
            this.topPanel.setViewWidth(this._data.bgWidth);
            this.bgWindow.width = this._data.bgWidth;
         }
         if(this._data.bgHeight != Values.DEFAULT_INT)
         {
            this.bgWindow.height = this._data.bgHeight;
         }
         this.topPanel.width = width;
         var _loc1_:int = height - TOP_PANEL_HEIGHT;
         var _loc2_:int = height / MIN_HEIGHT * MIN_CMP_PADDING;
         var _loc3_:int = this.bgWindow.height + this.topPanel.height + NUM_BTN_HEIGHT + (_loc2_ << 1);
         this.topPanel.y = (_loc1_ - _loc3_ >> 1) + TOP_PANEL_HEIGHT;
         this.container.x = this.bgWindow.x = width - this.bgWindow.width >> 1;
         this.bgWindow.y = this.topPanel.y + this.topPanel.height + _loc2_;
         this.container.y = this.bgWindow.y + TOP_PANEL_HEIGHT;
         this.bg.width = width;
         this.bg.height = _loc1_;
         this.bg.y = TOP_PANEL_HEIGHT;
         this.titleTf.x = this.bgWindow.x + (this.bgWindow.width - this.titleTf.width >> 1);
         this.titleTf.y = this.topPanel.y + TITLE_OFFSET;
      }
      
      private function addListeners() : void
      {
         this.topPanel.addEventListener(MissionDetailsTopPanelEvent.CLOSE_CLICK,this.onTopPanelCloseClickHandler);
         this.bg.addEventListener(MouseEvent.CLICK,this.onBgClickHandler);
      }
      
      private function removeListeners() : void
      {
         this.topPanel.removeEventListener(MissionDetailsTopPanelEvent.CLOSE_CLICK,this.onTopPanelCloseClickHandler);
         this.bg.removeEventListener(MouseEvent.CLICK,this.onBgClickHandler);
      }
      
      private function playFadeInTween() : void
      {
         this._fadeTween = new Tween(FADE_IN_DURATION,this,{"viewOpacity":1},{
            "paused":false,
            "ease":Linear.easeOut,
            "delay":FADE_IN_DELAY
         });
      }
      
      private function getAliasByLinkage(param1:String) : String
      {
         var _loc2_:String = this._linkagesDict[param1];
         this._utils.asserter.assert(StringUtils.isNotEmpty(_loc2_),Errors.BAD_LINKAGE + param1);
         return _loc2_;
      }
      
      private function addLinkageWithAlias(param1:String, param2:String) : void
      {
         this._linkagesDict[param1] = param2;
      }
      
      public function get viewOpacity() : Number
      {
         return this._viewOpacity;
      }
      
      public function set viewOpacity(param1:Number) : void
      {
         this._viewOpacity = param1;
         this.container.alpha = this.topPanel.alpha = this._viewOpacity;
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
      
      private function onBgClickHandler(param1:MouseEvent) : void
      {
         closeViewS();
      }
      
      private function onTopPanelCloseClickHandler(param1:MissionDetailsTopPanelEvent) : void
      {
         closeViewS();
      }
   }
}
