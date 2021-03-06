package net.wg.gui.lobby.hangar
{
   import fl.motion.easing.Quadratic;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEROYALE_ALIASES;
   import net.wg.data.constants.generated.DAILY_QUESTS_WIDGET_CONSTANTS;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.controls.CloseButtonText;
   import net.wg.gui.components.controls.CrewOperationBtn;
   import net.wg.gui.components.miniclient.HangarMiniClientComponent;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.lobby.battleRoyale.HangarComponentsContainer;
   import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
   import net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;
   import net.wg.gui.lobby.hangar.ammunitionPanel.data.AmmunitionPanelVO;
   import net.wg.gui.lobby.hangar.ammunitionPanelInject.AmmunitionPanelInject;
   import net.wg.gui.lobby.hangar.ammunitionPanelInject.events.AmmunitionPanelInjectEvents;
   import net.wg.gui.lobby.hangar.crew.Crew;
   import net.wg.gui.lobby.hangar.eventEntryPoint.HangarEventEntriesContainer;
   import net.wg.gui.lobby.hangar.interfaces.IHangar;
   import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
   import net.wg.gui.lobby.hangar.tcarousel.TankCarousel;
   import net.wg.gui.lobby.post.Teaser;
   import net.wg.gui.lobby.post.TeaserEvent;
   import net.wg.gui.lobby.post.data.TeaserVO;
   import net.wg.gui.notification.events.NotificationLayoutEvent;
   import net.wg.gui.tutorial.components.TutorialClip;
   import net.wg.infrastructure.base.meta.impl.HangarMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IGameInputManager;
   import net.wg.utils.IUtils;
   import net.wg.utils.helpLayout.IHelpLayout;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class Hangar extends HangarMeta implements IHangar, ITutorialCustomComponent
   {
      
      private static const INVALIDATE_CAROUSEL_SIZE:String = "InvalidateCarouselSize";
      
      private static const INVALIDATE_ENABLED_CREW:String = "InvalidateEnabledCrew";
      
      private static const INVALIDATE_AMMUNITION_PANEL_SIZE:String = "InvalidateAmmunitionPanelSize";
      
      private static const ENTRY_CONT_POSITION_INVALID:String = "enrtyContPositionInvalid";
      
      private static const PARAMS_POSITION_INVALID:String = "paramsPositionInvalid";
      
      private static const CAROUSEL_NAME:String = "carousel";
      
      private static const PARAMS_TOP_MARGIN:int = 3;
      
      private static const PARAMS_BOTTOM_MARGIN:int = 80;
      
      private static const TOP_MARGIN:Number = 33;
      
      private static const MINI_CLIENT_GAP:Number = 1;
      
      private static const ANIM_SPEED_TIME:int = 600;
      
      private static const TEASER_SHOW_X_OFFSET:int = 10;
      
      private static const TEASER_SHOW_SMALL_X_OFFSET:int = -110;
      
      private static const TEASER_HIDE_SMALL_X_OFFSET:int = -355;
      
      private static const SM_CAROUSEL_PADDING:Number = 30;
      
      private static const SM_AMMUNITION_PANEL_PADDING:Number = 86;
      
      private static const SM_THRESHOLD_X:Number = 1360;
      
      private static const SM_PADDING_X:Number = 4;
      
      private static const ALERT_MESSAGE_GAP:int = 40;
      
      private static const RIGHT_MARGIN:int = 5;
      
      private static const ROYALE_CLOSE_BTN_RIGHT_OFFSET:int = -6;
      
      private static const BR_UNBOUND_HEADER_TOP_MARGIN:int = 17;
      
      private static const VEH_RESEARCH_PANEL_Y:int = 45;
      
      private static const VEH_RESEARCH_PANEL_OFFSET:int = 37;
      
      private static const CREW_OPERATION_BG_Y:int = 47;
      
      private static const CREW_OPERATION_Y:int = 56;
      
      private static const CREW_OPERATION_MARGIN_Y:int = 2;
      
      private static const CREW_XP_PANEL_INJECT_WIDTH:int = 390;
      
      private static const CREW_XP_PANEL_INJECT_HEIGHT:int = 35;
      
      private static const DQ_WIDGET_NORMAL_HEIGHT:int = 184;
      
      private static const DQ_WIDGET_MINI_HEIGHT:int = 70;
      
      private static const DQ_WIDGET_MICRO_HEIGHT:int = 58;
      
      private static const DQ_WIDGET_NORMAL_LAYOUT_CAROUSEL_THRESHOLD:int = 699;
      
      private static const DQ_WIDGET_WIDTH_THRESHOLD:int = 1200;
      
      private static const DQ_WIDGET_VERTICAL_OFFSET:int = 15;
      
      private static const DQ_WIDGET_VERTICAL_OFFSET_SINGLE:int = 20;
      
      private static const DQ_WIDGET_VERTICAL_OFFSET_SINGLE_NOCAROUSEL:int = -7;
      
      private static const DQ_WIDGET_VERTICAL_OFFSET_MINI:int = 37;
      
      private static const DQ_WIDGET_VERTICAL_OFFSET_MICRO:int = 36;
      
      private static const DQ_WIDGET_HORIZONTAL_MARGIN:int = 0;
      
      private static const SMALL_SCREEN_WIDTH_THRESHOLD:int = 1280;
      
      private static const PARAMS_SMALL_SCREEN_BOTTOM_MARGIN:int = 36;
      
      private static const AMMUNITION_PANEL_OFFSET_Y:int = 4;
      
      private static const AMMUNITION_PANEL_INJECT_OFFSET_RIGHT:int = 5;
      
      private static const WIDGETS_OFFSET_Y:int = 64;
       
      
      public var vehResearchPanel:ResearchPanel;
      
      public var vehResearchBG:TutorialClip;
      
      public var tmenXpPanel:TmenXpPanel;
      
      public var crewOperationBtn:CrewOperationBtn;
      
      public var crew:Crew;
      
      public var params:IVehicleParameters;
      
      public var ammunitionPanel:AmmunitionPanel;
      
      public var ammunitionPanelInject:AmmunitionPanelInject;
      
      public var bottomBg:TutorialClip;
      
      public var carouselContainer:TutorialClip;
      
      public var switchModePanel:SwitchModePanel;
      
      public var crewBG:TutorialClip;
      
      public var teaser:Teaser;
      
      public var dqWidget:DailyQuestWidget;
      
      public var closeBtn:CloseButtonText;
      
      public var crewXPPanelInject:CrewXPPanelInject;
      
      private var _header:HangarHeader;
      
      private var _carousel:TankCarousel;
      
      private var _isControlsVisible:Boolean = false;
      
      private var _carouselAlias:String;
      
      private var _alertMessageBlock:AlertMessageBlock;
      
      private var _miniClient:HangarMiniClientComponent;
      
      private var _crewEnabled:Boolean = true;
      
      private var _gameInputMgr:IGameInputManager;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _utils:IUtils;
      
      private var _helpLayout:IHelpLayout;
      
      private var _teaserX:int = 0;
      
      private var _teaserOffsetX:int = 0;
      
      private var _tweenTeaser:Tween;
      
      private var _isTeaserShow:Boolean;
      
      private var _hangarViewSwitchAnimator:HangarAmunitionSwitchAnimator;
      
      private var _isVisibleByAnimator:Boolean = true;
      
      private var _isVisible:Boolean = true;
      
      private var _isCnSubscribeVisible:Boolean = false;
      
      private var _isBattleRoyale:Boolean = false;
      
      private var _appStage:Stage;
      
      private var _topMargin:int = 0;
      
      private var _currentWidgetLayout:int = 99;
      
      private var _forcedWidgetLayout:int = -1;
      
      private var _widgetInitialized:Boolean;
      
      private var _widgetSizes:Dictionary;
      
      private var _eventsEntryContainer:HangarEventEntriesContainer = null;
      
      private var _battleRoyaleComponents:HangarComponentsContainer = null;
      
      public function Hangar()
      {
         this._gameInputMgr = App.gameInputMgr;
         this._toolTipMgr = App.toolTipMgr;
         this._utils = App.utils;
         this._helpLayout = App.utils.helpLayout;
         this._appStage = App.stage;
         super();
         _deferredDispose = true;
         this.switchModePanel.visible = false;
         this.setupWidgetSizes();
         this._eventsEntryContainer = new HangarEventEntriesContainer();
         this._eventsEntryContainer.addEventListener(Event.RESIZE,this.onEventsEntryContainerResizeHandler);
         this._eventsEntryContainer.visible = false;
         addChildAt(this._eventsEntryContainer,getChildIndex(this.carouselContainer) + 1);
         this._header = App.instance.utils.classFactory.getComponent(Linkages.HANGAR_HEADER,HangarHeader);
         this._header.name = HANGAR_ALIASES.HEADER;
         addChildAt(this._header,getChildIndex(this.vehResearchPanel as DisplayObject) + 1);
         this.closeBtn.visible = false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = null;
         _originalWidth = param1;
         _originalHeight = param2;
         setSize(param1,param2);
         if(this.carousel != null)
         {
            this.carousel.updateStage(param1,param2);
            this.updateCarouselPosition();
         }
         if(this.bottomBg != null)
         {
            this.bottomBg.x = 0;
            this.bottomBg.y = _originalHeight >> 0;
            this.bottomBg.width = _originalWidth;
         }
         this.alignToCenter(this.switchModePanel);
         this.alignToCenter(this._miniClient);
         if(this.header != null)
         {
            this.header.x = param1 >> 1;
         }
         if(this._alertMessageBlock)
         {
            this._alertMessageBlock.x = _width - this._alertMessageBlock.width >> 1;
         }
         if(this.vehResearchPanel != null)
         {
            this.vehResearchPanel.x = param1;
            _loc3_ = this.vehResearchBG.getBounds(this.vehResearchBG);
            this.vehResearchBG.x = param1 - _loc3_.x - _loc3_.width - RIGHT_MARGIN >> 0;
         }
         this._helpLayout.hide();
         invalidate(ENTRY_CONT_POSITION_INVALID);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.crew,HANGAR_ALIASES.CREW);
         registerFlashComponentS(this.tmenXpPanel,HANGAR_ALIASES.TMEN_XP_PANEL);
         registerFlashComponentS(this.ammunitionPanel,HANGAR_ALIASES.AMMUNITION_PANEL);
         registerFlashComponentS(this.ammunitionPanelInject,HANGAR_ALIASES.AMMUNITION_PANEL_INJECT);
         registerFlashComponentS(this.switchModePanel,Aliases.SWITCH_MODE_PANEL);
         registerFlashComponentS(this.params,HANGAR_ALIASES.VEHICLE_PARAMETERS);
         registerFlashComponentS(this.dqWidget,Aliases.DAILY_QUEST_WIDGET);
         registerFlashComponentS(this._eventsEntryContainer,HANGAR_ALIASES.ENTRIES_CONTAINER);
         registerFlashComponentS(this.crewXPPanelInject,HANGAR_ALIASES.CREW_XP_PANEL_INJECT);
         registerFlashComponentS(this._header,HANGAR_ALIASES.HEADER);
         this.ammunitionPanelInject.addEventListener(Event.RESIZE,this.onAmmunitionPanelInjectResizeHandler);
         this.ammunitionPanelInject.addEventListener(AmmunitionPanelInjectEvents.HELP_LAYOUT_CHANGED,this.onAmmunitionPanelInjectHelpLayoutChangedHandler);
         addEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onHangarShowDropDownHandler);
         if(this.vehResearchPanel != null)
         {
            registerFlashComponentS(this.vehResearchPanel,HANGAR_ALIASES.RESEARCH_PANEL);
         }
         this.crewXPPanelInject.setSize(CREW_XP_PANEL_INJECT_WIDTH,CREW_XP_PANEL_INJECT_HEIGHT);
         this.updateControlsVisibility();
         this.updateElementsPosition();
         this.updateHeaderMargin();
         this.closeBtn.visible = false;
      }
      
      override protected function onBeforeDispose() : void
      {
         this.ammunitionPanelInject.removeEventListener(Event.RESIZE,this.onAmmunitionPanelInjectResizeHandler);
         this.ammunitionPanelInject.removeEventListener(AmmunitionPanelInjectEvents.HELP_LAYOUT_CHANGED,this.onAmmunitionPanelInjectHelpLayoutChangedHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscapeHandler);
         this._appStage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         removeEventListener(CrewDropDownEvent.SHOW_DROP_DOWN,this.onHangarShowDropDownHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN,this.showLayoutHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP,this.closeLayoutHandler);
         this.crewOperationBtn.removeEventListener(ButtonEvent.CLICK,this.onCrewOperationBtnClickHandler);
         this.ammunitionPanel.removeEventListener(Event.RESIZE,this.onAmmunitionPanelResizeHandler);
         this.ammunitionPanel.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onAmmunitionPanelRequestFocusHandler);
         this.vehResearchPanel.removeEventListener(Event.RESIZE,this.onVehResearchPanelResizeHandler);
         this.teaser.removeEventListener(TeaserEvent.TEASER_CLICK,this.onTeaserTeaserClickHandler);
         this.teaser.removeEventListener(TeaserEvent.HIDE,this.onTeaserHideHandler);
         this.switchModePanel.removeEventListener(ComponentEvent.SHOW,this.onSwitchModePanelShowHandler);
         this.switchModePanel.removeEventListener(ComponentEvent.HIDE,this.onSwitchModePanelHideHandler);
         this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
         if(this._hangarViewSwitchAnimator)
         {
            this._hangarViewSwitchAnimator.dispose();
            this._hangarViewSwitchAnimator = null;
         }
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         App.utils.counterManager.removeCounter(this.crewOperationBtn);
         this.removeBattleRoyaleContainer();
         this.crewOperationBtn.dispose();
         this.crewOperationBtn = null;
         this.bottomBg.dispose();
         this.bottomBg = null;
         this.crewBG.dispose();
         this.crewBG = null;
         this.teaser.dispose();
         this.teaser = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         if(this._tweenTeaser)
         {
            this._tweenTeaser.paused = true;
            this._tweenTeaser.dispose();
            this._tweenTeaser = null;
         }
         this._miniClient = null;
         this.vehResearchPanel = null;
         this.vehResearchBG.dispose();
         this.vehResearchBG = null;
         this.tmenXpPanel = null;
         this.crew = null;
         this.params = null;
         this.ammunitionPanel = null;
         this.ammunitionPanelInject = null;
         this._carousel = null;
         this.switchModePanel = null;
         this._header = null;
         this._alertMessageBlock = null;
         this.dqWidget = null;
         this._widgetInitialized = false;
         this.crewXPPanelInject = null;
         App.utils.data.cleanupDynamicObject(this._widgetSizes);
         this._widgetSizes = null;
         this._gameInputMgr = null;
         this._toolTipMgr = null;
         this._utils = null;
         this._helpLayout = null;
         this._appStage = null;
         this.carouselContainer.dispose();
         this.carouselContainer = null;
         this._eventsEntryContainer.removeEventListener(Event.RESIZE,this.onEventsEntryContainerResizeHandler);
         removeChild(this._eventsEntryContainer);
         this._eventsEntryContainer = null;
         this._currentWidgetLayout = 99;
         App.utils.data.cleanupDynamicObject(this._widgetSizes);
         this._widgetSizes = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
         this._appStage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
         mouseEnabled = false;
         this.bottomBg.mouseEnabled = false;
         this._gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_DOWN,this.showLayoutHandler,true);
         this._gameInputMgr.setKeyHandler(Keyboard.F1,KeyboardEvent.KEY_UP,this.closeLayoutHandler,true);
         this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscapeHandler,true);
         this.crewOperationBtn.tooltip = CREW_OPERATIONS.CREWOPERATIONS_BTN_TOOLTIP;
         this.crewOperationBtn.helpText = LOBBY_HELP.HANGAR_CREWOPERATIONBTN;
         this.crewOperationBtn.addEventListener(ButtonEvent.CLICK,this.onCrewOperationBtnClickHandler,false,0,true);
         this.crewOperationBtn.iconSource = RES_ICONS.MAPS_ICONS_TANKMEN_CREW_CREWOPERATIONS;
         this.ammunitionPanel.addEventListener(Event.RESIZE,this.onAmmunitionPanelResizeHandler);
         this.ammunitionPanel.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onAmmunitionPanelRequestFocusHandler);
         this.switchModePanel.addEventListener(ComponentEvent.SHOW,this.onSwitchModePanelShowHandler);
         this.switchModePanel.addEventListener(ComponentEvent.HIDE,this.onSwitchModePanelHideHandler);
         this.vehResearchPanel.addEventListener(Event.RESIZE,this.onVehResearchPanelResizeHandler);
         this.teaser.addEventListener(TeaserEvent.TEASER_CLICK,this.onTeaserTeaserClickHandler);
         this.teaser.addEventListener(TeaserEvent.HIDE,this.onTeaserHideHandler);
         this.carouselContainer.mouseEnabled = false;
         this._teaserX = -this.teaser.over.width;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.label = BATTLE_ROYALE.HANGAR_CLOSEBTN;
         this.closeBtn.validateNow();
         this.updateCloseBtnPos();
      }
      
      override protected function allowHandleInput() : Boolean
      {
         return false;
      }
      
      override protected function draw() : void
      {
         var _loc4_:Number = NaN;
         super.draw();
         if(isInvalid(INVALIDATE_ENABLED_CREW))
         {
            this.crew.enabled = this._crewEnabled;
            this.crewOperationBtn.enabled = this._crewEnabled;
         }
         var _loc1_:Boolean = isInvalid(ENTRY_CONT_POSITION_INVALID,INVALIDATE_AMMUNITION_PANEL_SIZE);
         var _loc2_:Boolean = isInvalid(PARAMS_POSITION_INVALID);
         var _loc3_:Boolean = false;
         if(isInvalid(INVALIDATE_CAROUSEL_SIZE))
         {
            this.carousel.visible = true;
            this.updateCarouselPosition();
            this.updateCrewSize();
            if(hasEventListener(Event.RESIZE))
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
            _loc4_ = SM_CAROUSEL_PADDING;
            if(width > SM_THRESHOLD_X)
            {
               _loc4_ = SM_AMMUNITION_PANEL_PADDING;
            }
            this.updateTeaserSize();
            App.systemMessages.dispatchEvent(new NotificationLayoutEvent(NotificationLayoutEvent.UPDATE_LAYOUT,new Point(SM_PADDING_X,height - this.ammunitionPanel.y - _loc4_)));
            this.checkToIfLayoutNeedsUpdate();
            this.updateBRComponentsPos();
            _loc1_ = true;
            _loc3_ = true;
         }
         if(_loc1_)
         {
            this.updateEntriesPosition();
            _loc2_ = true;
         }
         if(_loc2_)
         {
            this.updateParamsPosition();
            if(!_loc3_)
            {
               this.repositionWidget();
            }
         }
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         if(param1 == null)
         {
            param1 = this;
         }
         super.onSetModalFocus(param1);
      }
      
      override protected function setupAmmunitionPanel(param1:AmmunitionPanelVO) : void
      {
         this.ammunitionPanel.updateAmmunitionPanel(param1.maintenanceEnabled,param1.maintenanceTooltip);
         this.ammunitionPanel.updateTuningButton(param1.customizationEnabled,param1.customizationTooltip);
         this.ammunitionPanel.updateChangeNationButton(param1.changeNationVisible,param1.changeNationEnable,param1.changeNationTooltip,param1.changeNationIsNew);
      }
      
      override protected function show3DSceneTooltip(param1:String, param2:Array) : void
      {
         this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[param1,null].concat(param2));
      }
      
      override protected function showTeaser(param1:TeaserVO) : void
      {
         this.teaser.setData(param1);
         this._isTeaserShow = true;
         if(!this._tweenTeaser)
         {
            this.teaser.alpha = 0;
            this._tweenTeaser = new Tween(ANIM_SPEED_TIME,this.teaser,{
               "x":this._teaserOffsetX,
               "alpha":1
            },{
               "paused":false,
               "onComplete":this.animationFinished,
               "ease":Quadratic.easeInOut
            });
         }
      }
      
      public function as_closeHelpLayout() : void
      {
         this._helpLayout.hide();
      }
      
      public function as_setDQWidgetLayout(param1:int) : void
      {
         this._forcedWidgetLayout = param1;
      }
      
      public function as_createDQWidget() : void
      {
         if(!this.dqWidget)
         {
            this.dqWidget = new DailyQuestWidget();
            addChild(this.dqWidget);
            registerFlashComponentS(this.dqWidget,Aliases.DAILY_QUEST_WIDGET);
            this.repositionWidget();
         }
      }
      
      public function as_destroyDQWidget() : void
      {
         if(this.dqWidget)
         {
            this.dqWidget.dispose();
         }
         this.dqWidget = null;
      }
      
      public function as_hide3DSceneTooltip() : void
      {
         this.hideTooltip();
      }
      
      public function as_hideTeaserTimer() : void
      {
         this.teaser.hideTimer();
      }
      
      public function as_setAlertMessageBlockVisible(param1:Boolean) : void
      {
         var _loc2_:String = HANGAR_ALIASES.ALERT_MESSAGE_BLOCK;
         var _loc3_:Boolean = isFlashComponentRegisteredS(_loc2_);
         var _loc4_:Boolean = Boolean(this._alertMessageBlock) ? Boolean(contains(this._alertMessageBlock)) : Boolean(false);
         if(param1)
         {
            if(this._alertMessageBlock == null)
            {
               this._alertMessageBlock = App.instance.utils.classFactory.getComponent(Linkages.ALERT_MESSAGE_BLOCK,AlertMessageBlock);
               this._alertMessageBlock.name = _loc2_;
            }
            if(!_loc4_)
            {
               addChildAt(this._alertMessageBlock,getChildIndex(this.crewOperationBtn as DisplayObject) - 1);
            }
            if(!_loc3_)
            {
               registerFlashComponentS(this._alertMessageBlock,_loc2_);
            }
         }
         else if(this._alertMessageBlock)
         {
            if(_loc3_)
            {
               unregisterFlashComponentS(_loc2_);
            }
            if(_loc4_)
            {
               removeChild(this._alertMessageBlock);
            }
            this._alertMessageBlock = null;
         }
         this.updateElementsPosition();
      }
      
      public function as_setCarousel(param1:String, param2:String) : void
      {
         if(this.carousel != null)
         {
            this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
            this.carouselContainer.removeChild(this.carousel);
            unregisterFlashComponentS(this._carouselAlias);
         }
         this._carouselAlias = param2;
         this._carousel = App.instance.utils.classFactory.getComponent(param1,TankCarousel);
         this.carousel.visible = false;
         this.carousel.addEventListener(Event.RESIZE,this.onCarouselResizeHandler);
         this.carousel.updateStage(_originalWidth,_originalHeight);
         this.carousel.name = CAROUSEL_NAME;
         this.carouselContainer.addChild(this.carousel);
         registerFlashComponentS(this.carousel,this._carouselAlias);
         this.carousel.validateNow();
         invalidate(INVALIDATE_CAROUSEL_SIZE);
      }
      
      public function as_setCarouselEnabled(param1:Boolean) : void
      {
         this.carousel.enabled = param1;
      }
      
      public function as_setControlsVisible(param1:Boolean) : void
      {
         if(param1 != this.isControlsVisible)
         {
            this._isControlsVisible = param1;
            this.updateControlsVisibility();
         }
      }
      
      public function as_setCrewEnabled(param1:Boolean) : void
      {
         this._crewEnabled = param1;
         invalidate(INVALIDATE_ENABLED_CREW);
      }
      
      public function as_setNotificationEnabled(param1:Boolean) : void
      {
         if(param1 && this.crewOperationBtn.visible)
         {
            App.utils.counterManager.setCounter(this.crewOperationBtn,MENU.HEADER_NOTIFICATIONSIGN);
         }
         else
         {
            App.utils.counterManager.removeCounter(this.crewOperationBtn);
         }
      }
      
      public function as_setTeaserTimer(param1:String) : void
      {
         this.teaser.setTime(param1);
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      public function as_showHelpLayout() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.crewOperationBtn.visible)
         {
            _loc1_ = this.crewOperationBtn.width;
            _loc1_ += !!this.tmenXpPanel.panelVisible ? this.tmenXpPanel.width : 0;
            this.crewOperationBtn.showHelpLayoutEx(1,_loc1_);
         }
         if(this.params.visible)
         {
            _loc2_ = Math.max(this.params.getHelpLayoutWidth(),this.vehResearchPanel.getHelpLayoutWidth());
            this.params.showHelpLayoutEx(this.vehResearchPanel.x - this.params.x,_loc2_);
         }
         this._helpLayout.show();
      }
      
      public function as_showMiniClientInfo(param1:String, param2:String) : void
      {
         this._miniClient = HangarMiniClientComponent(this._utils.classFactory.getComponent(Linkages.HANGAR_MINI_CLIENT_COMPONENT,HangarMiniClientComponent));
         this._miniClient.update(param1,param2);
         addChild(this._miniClient);
         registerFlashComponentS(this._miniClient,Aliases.MINI_CLIENT_LINKED);
         this.updateElementsPosition();
      }
      
      public function as_showSwitchToAmmunition() : void
      {
         this.initHangarSwitchAnimator();
         this._hangarViewSwitchAnimator.playHideAnimation();
      }
      
      public function as_toggleCnSubscription(param1:Boolean) : void
      {
         this._isCnSubscribeVisible = param1;
         this.updateCrewOperationsVisibility();
      }
      
      public function as_toggleBattleRoyale(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         if(this._isBattleRoyale == param1)
         {
            return;
         }
         this._isBattleRoyale = param1;
         var _loc2_:Boolean = !param1 && this._isControlsVisible;
         this.crew.visible = _loc2_;
         this.ammunitionPanel.visible = _loc2_;
         this.ammunitionPanelInject.visible = _loc2_;
         this.vehResearchBG.visible = _loc2_;
         this.vehResearchPanel.visible = _loc2_;
         this.params.visible = _loc2_;
         this.updateCrewOperationsVisibility();
         if(param1)
         {
            if(this._battleRoyaleComponents == null)
            {
               this._battleRoyaleComponents = new HangarComponentsContainer();
               _loc3_ = getChildIndex(this.carouselContainer as DisplayObject) + 1;
               addChildAt(this._battleRoyaleComponents,_loc3_);
            }
            registerFlashComponentS(this._battleRoyaleComponents.commander,BATTLEROYALE_ALIASES.COMMANDER_COMPONENT);
            registerFlashComponentS(this._battleRoyaleComponents.techParameters,BATTLEROYALE_ALIASES.TECH_PARAMETERS_COMPONENT);
            registerFlashComponentS(this._battleRoyaleComponents.bottomPanel,BATTLEROYALE_ALIASES.BOTTOM_PANEL_COMPONENT);
            registerFlashComponentS(this._battleRoyaleComponents.proxyCurrencyPanel,BATTLEROYALE_ALIASES.PROXY_CURRENCY_PANEL_COMPONENT);
            this.updateBRComponentsPos();
         }
         else
         {
            unregisterFlashComponentS(BATTLEROYALE_ALIASES.COMMANDER_COMPONENT);
            unregisterFlashComponentS(BATTLEROYALE_ALIASES.TECH_PARAMETERS_COMPONENT);
            unregisterFlashComponentS(BATTLEROYALE_ALIASES.BOTTOM_PANEL_COMPONENT);
            unregisterFlashComponentS(BATTLEROYALE_ALIASES.PROXY_CURRENCY_PANEL_COMPONENT);
            this.removeBattleRoyaleContainer();
         }
         if(this._battleRoyaleComponents)
         {
            this._battleRoyaleComponents.visible = param1;
         }
      }
      
      private function removeBattleRoyaleContainer() : void
      {
         if(this._battleRoyaleComponents != null)
         {
            removeChild(this._battleRoyaleComponents);
            this._battleRoyaleComponents.dispose();
            this._battleRoyaleComponents = null;
         }
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.crewOperationBtn;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.crewOperationBtn;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function updateAmmunitionPanelPosition() : void
      {
         var _loc1_:int = 0;
         if(this.carousel != null)
         {
            this.ammunitionPanel.x = _width - this.ammunitionPanel.width >> 1;
            _loc1_ = this.ammunitionPanel.height + AmmunitionPanel.SLOTS_HEIGHT_AND_OFFSET;
            if(!this.carouselContainer.visible)
            {
               this.ammunitionPanel.y = height - _loc1_ | 0;
            }
            else
            {
               this.ammunitionPanel.y = Math.min(this.carousel.y - _loc1_ + AMMUNITION_PANEL_OFFSET_Y | 0,height - _loc1_ | 0);
            }
            this.ammunitionPanel.updateStage(_width,this.carousel.y);
            this.updateAmmunitionPanelInjectPosition();
         }
         invalidate(PARAMS_POSITION_INVALID);
      }
      
      public function setAnimatorVisibility(param1:Boolean) : void
      {
         this._isVisibleByAnimator = param1;
         this.resolveVisibility();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         this._isVisible = param1;
         this.resolveVisibility();
      }
      
      protected function updateControlsVisibility() : void
      {
         this.params.visible = this.isControlsVisible;
         this.crew.visible = this.isControlsVisible;
         this.ammunitionPanel.visible = this.isControlsVisible;
         this.bottomBg.visible = this.isControlsVisible;
         this.vehResearchPanel.visible = this.isControlsVisible;
         this.vehResearchBG.visible = this.isControlsVisible;
         this.ammunitionPanelInject.visible = this.isControlsVisible;
         this.updateCrewOperationsVisibility();
      }
      
      protected function updateCrewOperationsVisibility() : void
      {
         if(this._isBattleRoyale)
         {
            this.crewXPPanelInject.visible = this.tmenXpPanel.visible = this.crewBG.visible = this.crewOperationBtn.visible = false;
         }
         else
         {
            this.tmenXpPanel.visible = this.crewBG.visible = this.crewOperationBtn.visible = this.isCrewOperationVisible;
            this.crewXPPanelInject.visible = this.isControlsVisible && this._isCnSubscribeVisible;
         }
      }
      
      private function resolveVisibility() : void
      {
         super.visible = this._isVisibleByAnimator && this._isVisible;
      }
      
      private function initHangarSwitchAnimator() : void
      {
         if(!this._hangarViewSwitchAnimator)
         {
            this._hangarViewSwitchAnimator = new HangarAmunitionSwitchAnimator(this,Vector.<DisplayObject>([this.params,this.crew,this.dqWidget,this.teaser,this.crewBG,this.crewOperationBtn,this.crewXPPanelInject,this._alertMessageBlock,this.vehResearchPanel,this.vehResearchBG,this.tmenXpPanel,this.header,this.ammunitionPanel,this.bottomBg]),Vector.<DisplayObject>([this.carouselContainer]),this.ammunitionPanelInject,height);
         }
      }
      
      private function setupWidgetSizes() : void
      {
         this._widgetSizes = new Dictionary();
         this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_NORMAL] = [340,186];
         this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MINI] = [190,65];
         this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MICRO] = [155,55];
         this._widgetSizes[DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_SINGLE] = [340,62];
      }
      
      private function updateEntriesPosition() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc3_:Boolean = false;
         _loc1_ = this.ammunitionPanelInject.hitObject;
         var _loc2_:Boolean = this.carousel && this._eventsEntryContainer.isActive && _loc1_ && _loc1_.width > 0;
         this._eventsEntryContainer.visible = _loc2_;
         if(_loc2_)
         {
            this._eventsEntryContainer.x = _width - this._eventsEntryContainer.width - this._eventsEntryContainer.margin.width | 0;
            this._eventsEntryContainer.y = this.carousel.y - this._eventsEntryContainer.height | 0;
            _loc3_ = false;
            if(this.ammunitionPanelInject.visible)
            {
               _loc3_ = this.ammunitionPanelInject.x + _loc1_.x + _loc1_.width + AMMUNITION_PANEL_INJECT_OFFSET_RIGHT > this._eventsEntryContainer.x;
            }
            if(_loc3_)
            {
               this._eventsEntryContainer.y -= _loc1_.y + (_loc1_.height >> 1);
            }
            else
            {
               this._eventsEntryContainer.y -= this._eventsEntryContainer.margin.height;
            }
         }
      }
      
      private function checkToIfLayoutNeedsUpdate() : void
      {
         if(!this._widgetInitialized)
         {
            if(this.dqWidget == null || !isFlashComponentRegisteredS(Aliases.DAILY_QUEST_WIDGET))
            {
               return;
            }
            this.dqWidget.x = DQ_WIDGET_HORIZONTAL_MARGIN;
            this._widgetInitialized = true;
         }
         if(!this._header || !this._carousel)
         {
            return;
         }
         var _loc1_:int = this.determineLayout();
         if(this._currentWidgetLayout != _loc1_)
         {
            this._currentWidgetLayout = _loc1_;
            this.dqWidget.setSize(this._widgetSizes[this._currentWidgetLayout][0],this._widgetSizes[this._currentWidgetLayout][1]);
         }
         this.repositionWidget();
      }
      
      private function repositionWidget() : void
      {
         switch(this._currentWidgetLayout)
         {
            case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_NORMAL:
               this.dqWidget.y = this.ammunitionPanel.y + WIDGETS_OFFSET_Y - DQ_WIDGET_NORMAL_HEIGHT + DQ_WIDGET_VERTICAL_OFFSET;
               break;
            case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MINI:
               this.dqWidget.y = this.ammunitionPanel.y + WIDGETS_OFFSET_Y - DQ_WIDGET_MINI_HEIGHT + DQ_WIDGET_VERTICAL_OFFSET_MINI;
               break;
            case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MICRO:
               this.dqWidget.y = this.ammunitionPanel.y + WIDGETS_OFFSET_Y - DQ_WIDGET_MICRO_HEIGHT + DQ_WIDGET_VERTICAL_OFFSET_MICRO;
               break;
            case DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_SINGLE:
               this.dqWidget.y = this.ammunitionPanel.y + WIDGETS_OFFSET_Y - DQ_WIDGET_MICRO_HEIGHT + (!!this.carouselContainer.visible ? DQ_WIDGET_VERTICAL_OFFSET_SINGLE : DQ_WIDGET_VERTICAL_OFFSET_SINGLE_NOCAROUSEL);
         }
      }
      
      private function determineLayout() : int
      {
         if(this._forcedWidgetLayout != Values.DEFAULT_INT)
         {
            return this._forcedWidgetLayout;
         }
         if(App.appWidth >= DQ_WIDGET_WIDTH_THRESHOLD && this._carousel.y >= DQ_WIDGET_NORMAL_LAYOUT_CAROUSEL_THRESHOLD)
         {
            return DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_NORMAL;
         }
         if(App.appWidth > DQ_WIDGET_WIDTH_THRESHOLD)
         {
            return DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MINI;
         }
         return DAILY_QUESTS_WIDGET_CONSTANTS.WIDGET_LAYOUT_MICRO;
      }
      
      private function updateBRComponentsPos() : void
      {
         if(this._battleRoyaleComponents != null)
         {
            this._battleRoyaleComponents.y = BR_UNBOUND_HEADER_TOP_MARGIN;
            this._battleRoyaleComponents.updateStage(_width,this.carousel.y - BR_UNBOUND_HEADER_TOP_MARGIN);
         }
      }
      
      private function updateCloseBtnPos() : void
      {
         this.closeBtn.x = _width - this.closeBtn.actualWidth + ROYALE_CLOSE_BTN_RIGHT_OFFSET ^ 0;
      }
      
      private function updateHeaderMargin() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = this._topMargin;
         this._topMargin = 0;
         if(_loc1_ != this._topMargin)
         {
            _loc2_ = CREW_OPERATION_BG_Y + this._topMargin;
            this.tmenXpPanel.y = this.crewOperationBtn.y = CREW_OPERATION_Y + this._topMargin;
            this.crewXPPanelInject.y = this.crewBG.y = _loc2_;
            this.crew.y = _loc2_ + this.crewBG.height + CREW_OPERATION_MARGIN_Y;
            _loc3_ = VEH_RESEARCH_PANEL_Y + this._topMargin;
            this.vehResearchPanel.y = this.vehResearchBG.y = _loc3_;
            this.updateParamsPosition();
         }
      }
      
      private function hideTeaserAnim() : void
      {
         this._isTeaserShow = false;
         this._teaserX = this.teaser.x = -this.teaser.width;
         this.teaser.alpha = 0;
         hideTeaserS();
      }
      
      private function updateTeaserSize() : void
      {
         if(stage.stageWidth <= Teaser.STAGE_WIDTH_BOUNDARY)
         {
            this._teaserOffsetX = TEASER_SHOW_SMALL_X_OFFSET;
            this._teaserX = !!this._isTeaserShow ? int(this._teaserOffsetX) : int(TEASER_HIDE_SMALL_X_OFFSET);
         }
         else
         {
            this._teaserOffsetX = TEASER_SHOW_X_OFFSET;
            this._teaserX = !!this._isTeaserShow ? int(this._teaserOffsetX) : int(-this.teaser.over.width);
         }
         this.teaser.x = this._teaserX;
         this.teaser.y = this._carousel.y - this.teaser.height - TEASER_SHOW_X_OFFSET;
         this.teaser.invalidateSize();
      }
      
      private function animationFinished() : void
      {
         this._tweenTeaser = null;
         this._teaserX = this.teaser.x;
      }
      
      private function updateParamsPosition() : void
      {
         this.vehResearchBG.y = VEH_RESEARCH_PANEL_OFFSET + this.vehResearchPanel.offset;
         this.params.x = _originalWidth - this.params.width - RIGHT_MARGIN ^ 0;
         this.params.y = this.vehResearchBG.y + this.vehResearchBG.height + PARAMS_TOP_MARGIN ^ 0;
         var _loc1_:int = _originalWidth <= SMALL_SCREEN_WIDTH_THRESHOLD ? int(PARAMS_SMALL_SCREEN_BOTTOM_MARGIN) : int(0);
         var _loc2_:int = this.ammunitionPanel.y - this.params.y + PARAMS_BOTTOM_MARGIN - _loc1_;
         if(this._eventsEntryContainer && this._eventsEntryContainer.isActive && this._eventsEntryContainer.height > 0)
         {
            _loc2_ = this._eventsEntryContainer.y - this.params.y - this._eventsEntryContainer.margin.top;
         }
         if(_loc2_ > 0)
         {
            this.params.height = _loc2_;
         }
      }
      
      private function hideTooltip() : void
      {
         this._toolTipMgr.hide();
      }
      
      private function updateCarouselPosition() : void
      {
         this._carousel.updateCarouselPosition(_height - this._carousel.getBottom() ^ 0);
         this.updateAmmunitionPanelPosition();
         if(this._hangarViewSwitchAnimator)
         {
            this._hangarViewSwitchAnimator.updateStage(width,height);
         }
      }
      
      private function updateElementsPosition() : void
      {
         var _loc1_:int = TOP_MARGIN;
         if(this._miniClient != null)
         {
            this._miniClient.y = _loc1_;
            _loc1_ += this._miniClient.height + MINI_CLIENT_GAP;
         }
         if(this._alertMessageBlock)
         {
            this._alertMessageBlock.x = _width - this._alertMessageBlock.width >> 1;
            this._alertMessageBlock.y = _loc1_;
            _loc1_ += ALERT_MESSAGE_GAP;
         }
         if(this.header != null)
         {
            this.header.x = _width >> 1;
            this.header.y = _loc1_;
         }
         if(this.switchModePanel.visible)
         {
            this.switchModePanel.y = _loc1_;
         }
         if(this.switchModePanel.visible)
         {
            this.switchModePanel.y = _loc1_;
         }
      }
      
      private function alignToCenter(param1:DisplayObject) : void
      {
         if(param1)
         {
            param1.x = width - param1.width >> 1;
         }
      }
      
      private function closeLayoutHandler() : void
      {
         closeHelpLayoutS();
      }
      
      private function updateCrewSize() : void
      {
         var _loc1_:int = this.ammunitionPanel.y + WIDGETS_OFFSET_Y - this.crew.y;
         this.crew.updateSize(_loc1_);
      }
      
      private function updateAmmunitionPanelInjectPosition() : void
      {
         if(this.carousel != null && this.ammunitionPanelInject.width > 0)
         {
            this.ammunitionPanelInject.x = _width - this.ammunitionPanelInject.width >> 1;
            this.ammunitionPanelInject.y = this.ammunitionPanel.y + this.ammunitionPanelInject.offsetY;
            this.ammunitionPanelInject.validatePanelSize();
         }
      }
      
      public function get carousel() : TankCarousel
      {
         return this._carousel;
      }
      
      public function get header() : HangarHeader
      {
         return this._header;
      }
      
      public function get isControlsVisible() : Boolean
      {
         return this._isControlsVisible;
      }
      
      public function get isCrewOperationVisible() : Boolean
      {
         return !this._isCnSubscribeVisible && this.isControlsVisible;
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         onCloseBtnClickS();
      }
      
      private function onTeaserTeaserClickHandler(param1:TeaserEvent) : void
      {
         onTeaserClickS();
      }
      
      private function onTeaserHideHandler(param1:TeaserEvent) : void
      {
         this.hideTeaserAnim();
      }
      
      private function onAmmunitionPanelResizeHandler(param1:Event) : void
      {
         invalidate(INVALIDATE_AMMUNITION_PANEL_SIZE);
      }
      
      private function onAmmunitionPanelRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
      }
      
      private function onCrewOperationBtnClickHandler(param1:Event) : void
      {
         App.popoverMgr.show(this,Aliases.CREW_OPERATIONS_POPOVER);
      }
      
      private function handleEscapeHandler(param1:InputEvent) : void
      {
         if(!this._helpLayout.isShown())
         {
            onEscapeS();
         }
      }
      
      private function onHangarShowDropDownHandler(param1:CrewDropDownEvent) : void
      {
         var _loc2_:MovieClip = param1.dropDownref;
         var _loc3_:Point = globalToLocal(new Point(_loc2_.x,_loc2_.y));
         addChild(_loc2_);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
      }
      
      private function showLayoutHandler(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.altKey || _loc2_.ctrlKey || _loc2_.shiftKey)
         {
            return;
         }
         showHelpLayoutS();
      }
      
      private function onSwitchModePanelShowHandler(param1:ComponentEvent) : void
      {
         this.updateElementsPosition();
      }
      
      private function onSwitchModePanelHideHandler(param1:ComponentEvent) : void
      {
         this.updateElementsPosition();
      }
      
      private function onCarouselResizeHandler(param1:Event) : void
      {
         invalidate(INVALIDATE_CAROUSEL_SIZE);
      }
      
      private function onVehResearchPanelResizeHandler(param1:Event) : void
      {
         this.updateParamsPosition();
      }
      
      private function onEventsEntryContainerResizeHandler(param1:Event) : void
      {
         invalidate(ENTRY_CONT_POSITION_INVALID);
      }
      
      private function onAmmunitionPanelInjectResizeHandler(param1:Event) : void
      {
         this.updateAmmunitionPanelInjectPosition();
      }
      
      private function onAmmunitionPanelInjectHelpLayoutChangedHandler(param1:Event) : void
      {
         invalidate(ENTRY_CONT_POSITION_INVALID);
      }
   }
}
