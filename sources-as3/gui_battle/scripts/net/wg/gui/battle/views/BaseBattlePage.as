package net.wg.gui.battle.views
{
   import fl.motion.easing.Linear;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.gui.battle.interfaces.IPrebattleTimerBase;
   import net.wg.gui.battle.views.ammunitionPanel.PrbAmmunitionPanelEvent;
   import net.wg.gui.battle.views.ammunitionPanel.PrebattleAmmunitionPanelView;
   import net.wg.gui.battle.views.calloutPanel.CalloutPanel;
   import net.wg.gui.battle.views.damagePanel.DamagePanel;
   import net.wg.gui.battle.views.deathCamHud.DeathCamHud;
   import net.wg.gui.battle.views.dualGunPanel.DualGunPanel;
   import net.wg.gui.battle.views.gameMessagesPanel.GameMessagesPanel;
   import net.wg.gui.battle.views.gameMessagesPanel.events.GameMessagesPanelEvent;
   import net.wg.gui.battle.views.messages.MessageListDAAPI;
   import net.wg.gui.battle.views.minimap.BaseMinimap;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.perksPanel.PerksPanel;
   import net.wg.gui.battle.views.piercingDebugPanel.PiercingDebugPanel;
   import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonsPanel;
   import net.wg.gui.battle.views.rocketAcceleratorPanel.RocketAcceleratorPanel;
   import net.wg.gui.battle.views.spectatorView.SpectatorView;
   import net.wg.gui.battle.views.vehicleMessages.VehicleMessages;
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.infrastructure.base.meta.IBattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.BattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.BattleTimerMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.entity.IDisplayableComponent;
   import scaleform.clik.motion.Tween;
   
   public class BaseBattlePage extends BattlePageMeta implements IBattlePageMeta
   {
      
      protected static const VEHICLE_MESSAGES_LIST_OFFSET:Point = new Point(500,111);
      
      protected static const VEHICLE_MESSAGES_LIST_POSTMORTEM_Y_OFFSET:int = 20;
      
      protected static const VEHICLE_ERRORS_LIST_OFFSET:Point = new Point(300,30);
      
      protected static const PLAYER_MESSAGES_LIST_OFFSET:Point = new Point(350,-38);
      
      protected static const MESSENGER_Y_OFFSET:int = 2;
      
      private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 150;
      
      private static const RIBBONS_MIN_BOTTOM_PADDING_Y:int = 116;
      
      private static const CALLOUT_CENTER_SCREEN_OFFSET_Y:int = 14;
      
      private static const CALLOUT_CENTER_SCREEN_OFFSET_X:int = 136;
      
      private static const AMMUNITION_PANEL_Y_SHIFT:int = 498;
      
      private static const HIT_TEST_FIX_NAME:String = "HitTest Fix";
      
      private static const PERKS_PANEL_OFFSET_Y:int = 115;
      
      private static const TWEEN_DURATION:uint = 300;
       
      
      public var battleLoading:BaseBattleLoading = null;
      
      public var prebattleTimer:IPrebattleTimerBase = null;
      
      public var damagePanel:DamagePanel = null;
      
      public var dualGunPanel:DualGunPanel = null;
      
      public var rocketAcceleratorPanel:RocketAcceleratorPanel = null;
      
      public var minimap:BaseMinimap = null;
      
      public var battleTimer:BattleTimerMeta = null;
      
      public var ribbonsPanel:RibbonsPanel = null;
      
      public var perksPanel:PerksPanel = null;
      
      public var gameMessagesPanel:GameMessagesPanel = null;
      
      public var calloutPanel:CalloutPanel = null;
      
      public var prebattleAmmunitionPanel:PrebattleAmmunitionPanelView = null;
      
      protected var vehicleMessageList:VehicleMessages;
      
      protected var vehicleErrorMessageList:MessageListDAAPI;
      
      protected var playerMessageList:MessageListDAAPI;
      
      protected var battleStatisticDataController:BattleStatisticDataController;
      
      protected var piercingDebugPanel:PiercingDebugPanel = null;
      
      protected var isPostMortem:Boolean = false;
      
      public var deathCamHud:DeathCamHud = null;
      
      public var spectatorViewUI:SpectatorView = null;
      
      public var postmortemPanelUI:PostmortemPanel = null;
      
      protected var hitTestFix:Sprite;
      
      private var _messagesContainer:Sprite = null;
      
      private var _componentsStorage:Object;
      
      private var _tweens:Vector.<Tween>;
      
      public function BaseBattlePage()
      {
         this.hitTestFix = new Sprite();
         this._componentsStorage = {};
         this._tweens = new Vector.<Tween>();
         super();
         this.battleStatisticDataController = this.createStatisticsController();
         this.initializeStatisticsController(this.battleStatisticDataController);
         this.initializeMessageLists();
         this.hitTestFix.graphics.beginFill(16777215,0);
         this.hitTestFix.graphics.drawRect(0,0,1,1);
         this.hitTestFix.graphics.endFill();
         this.hitTestFix.name = HIT_TEST_FIX_NAME;
         this.hitTestFix.alpha = 0;
         addChildAt(this.hitTestFix,0);
      }
      
      override public function unregisterComponent(param1:String) : void
      {
         delete this._componentsStorage[param1];
         super.unregisterComponent(param1);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         super.updateStage(param1,param2);
         var _loc3_:int = param1 >> 1;
         var _loc4_:int = param2 >> 1;
         _originalWidth = param1;
         _originalHeight = param2;
         setSize(param1,param2);
         if(this.prebattleTimer)
         {
            this.prebattleTimer.updateStage(param1,param2);
         }
         this.updatePrebattleTimerPosition(_loc3_);
         this.damagePanel.x = 0;
         this.damagePanel.y = param2 - this.damagePanel.initedHeight;
         if(this.battleTimer)
         {
            this.battleTimer.x = param1 - this.battleTimer.initedWidth;
            this.battleTimer.y = 0;
         }
         if(this.dualGunPanel)
         {
            this.dualGunPanel.updateStage(param1,param2);
         }
         if(this.hitTestFix)
         {
            this.hitTestFix.width = param1;
            this.hitTestFix.height = param2;
         }
         if(this.ribbonsPanel)
         {
            this.ribbonsPanel.x = _loc3_ + this.ribbonsPanel.offsetX;
            _loc5_ = this.getRibbonsCenterOffset(param2);
            _loc6_ = _loc4_ - _loc5_ - RIBBONS_MIN_BOTTOM_PADDING_Y;
            this.ribbonsPanel.setFreeWorkingHeight(_loc6_);
            _loc7_ = _loc4_ + (_loc6_ - this.ribbonsPanel.freeHeightForRenderers >> 1) + _loc5_;
            this.ribbonsPanel.y = _loc7_;
         }
         if(this.perksPanel)
         {
            this.perksPanel.x = _loc3_;
            this.perksPanel.y = param2 - PERKS_PANEL_OFFSET_Y;
         }
         this.updateMinimapPosition();
         this.vehicleErrorMessageListPositionUpdate();
         this.playerMessageListPositionUpdate();
         this.vehicleMessageList.updateStage();
         this.vehicleMessageListPositionUpdate();
         if(this.battleLoading)
         {
            this.battleLoading.updateStage(param1,param2);
         }
         this.gameMessagesPanel.x = _loc3_;
         if(this.calloutPanel)
         {
            this.calloutPanel.x = _loc3_ - CALLOUT_CENTER_SCREEN_OFFSET_X;
            this.calloutPanel.y = _loc4_ + CALLOUT_CENTER_SCREEN_OFFSET_Y;
         }
         if(this.prebattleAmmunitionPanel)
         {
            this.prebattleAmmunitionPanel.x = _originalWidth - this.prebattleAmmunitionPanel.width >> 1;
            this.updateAmmunitionPanelY();
         }
         if(this.piercingDebugPanel)
         {
            this.piercingDebugPanel.updateStage(param1,param2);
         }
         if(this.deathCamHud)
         {
            this.deathCamHud.width = param1;
            this.deathCamHud.height = param2;
         }
         if(this.spectatorViewUI)
         {
            this.spectatorViewUI.updateStage(param1,param2);
         }
         if(this.postmortemPanelUI)
         {
            this.updatePostmortemUIPosition();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.gameMessagesPanel.addEventListener(GameMessagesPanelEvent.MESSAGES_STARTED_PLAYING,this.onMessagesStartedPlayingHandler);
         this.gameMessagesPanel.addEventListener(GameMessagesPanelEvent.MESSAGES_ENDED_PLAYING,this.onMessagesEndedPlayingHandler);
         this.gameMessagesPanel.addEventListener(GameMessagesPanelEvent.ALL_MESSAGES_ENDED_PLAYING,this.onAllMessagesEndedPlayingHandler);
         this.addDeathCamHud();
      }
      
      override protected function configUI() : void
      {
         this.updateStage(App.appWidth,App.appHeight);
         if(this.prebattleAmmunitionPanelAvailable && this.prebattleAmmunitionPanel)
         {
            this.prebattleAmmunitionPanel.addEventListener(PrbAmmunitionPanelEvent.VIEW_HIDDEN,this.onPrebattleAmmunitionPanelViewHiddenHandler);
            this.prebattleAmmunitionPanel.addEventListener(PrbAmmunitionPanelEvent.VIEW_SHOWN,this.onPrebattleAmmunitionPanelViewShownHandler);
            this.prebattleAmmunitionPanel.addEventListener(PrbAmmunitionPanelEvent.STATE_CHANGED,this.onPrebattleAmmunitionPanelStateChangedHandler);
         }
         this.minimap.addEventListener(MinimapEvent.TRY_SIZE_CHANGED,this.onMinimapTrySizeChangedHandler);
         this.minimap.addEventListener(MinimapEvent.SIZE_CHANGED,this.onMinimapSizeChangedHandler);
         this.minimap.addEventListener(MinimapEvent.VISIBILITY_CHANGED,this.onMinimapSizeChangedHandler);
         super.configUI();
      }
      
      override protected function onPopulate() : void
      {
         if(this.battleLoading)
         {
            this.registerComponent(this.battleLoading,BATTLE_VIEW_ALIASES.BATTLE_LOADING);
         }
         this.registerComponent(this.minimap,BATTLE_VIEW_ALIASES.MINIMAP);
         if(this.prebattleTimer)
         {
            this.registerComponent(this.prebattleTimer,BATTLE_VIEW_ALIASES.PREBATTLE_TIMER);
         }
         this.registerComponent(this.damagePanel,BATTLE_VIEW_ALIASES.DAMAGE_PANEL);
         if(this.battleTimer)
         {
            this.registerComponent(this.battleTimer,BATTLE_VIEW_ALIASES.BATTLE_TIMER);
         }
         if(this.ribbonsPanel)
         {
            this.registerComponent(this.ribbonsPanel,BATTLE_VIEW_ALIASES.RIBBONS_PANEL);
         }
         if(this.perksPanel)
         {
            this.registerComponent(this.perksPanel,BATTLE_VIEW_ALIASES.PERKS_PANEL);
         }
         this.registerComponent(this.vehicleMessageList,BATTLE_VIEW_ALIASES.VEHICLE_MESSAGES);
         this.registerComponent(this.vehicleErrorMessageList,BATTLE_VIEW_ALIASES.VEHICLE_ERROR_MESSAGES);
         this.registerComponent(this.playerMessageList,BATTLE_VIEW_ALIASES.PLAYER_MESSAGES);
         this.registerComponent(this.gameMessagesPanel,BATTLE_VIEW_ALIASES.GAME_MESSAGES_PANEL);
         if(this.calloutPanel)
         {
            this.registerComponent(this.calloutPanel,BATTLE_VIEW_ALIASES.CALLOUT_PANEL);
         }
         if(this.prebattleAmmunitionPanelAvailable && this.prebattleAmmunitionPanel)
         {
            this.registerComponent(this.prebattleAmmunitionPanel,BATTLE_VIEW_ALIASES.PREBATTLE_AMMUNITION_PANEL);
         }
         if(this.dualGunPanel)
         {
            this.registerComponent(this.dualGunPanel,BATTLE_VIEW_ALIASES.DUAL_GUN_PANEL);
         }
         else
         {
            DebugUtils.LOG_DEBUG("dualGunPanel component doesn\'t configured for this Battle Page");
         }
         if(this.rocketAcceleratorPanel)
         {
            this.registerComponent(this.rocketAcceleratorPanel,BATTLE_VIEW_ALIASES.ROCKET_ACCELERATOR_INDICATOR);
         }
         else
         {
            DebugUtils.LOG_DEBUG("rocketAcceleratorPanel component doesn\'t configured for this Battle Page");
         }
         this.createSpectatorViewComponent();
         this.createPostmortemPanelComponent();
         if(this.deathCamHud)
         {
            this.registerComponent(this.deathCamHud,BATTLE_VIEW_ALIASES.DEATH_CAM_HUD);
         }
         else
         {
            DebugUtils.LOG_WARNING("deathCamHud component is not configured for this Battle Page");
         }
         if(this.ribbonsPanel)
         {
            this.ribbonsPanel.addEventListener(Event.CHANGE,this.onRibbonsPanelChangeHandler);
         }
         this.onRegisterStatisticController();
         super.onPopulate();
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this.prebattleAmmunitionPanel)
         {
            this.prebattleAmmunitionPanel.removeEventListener(PrbAmmunitionPanelEvent.VIEW_HIDDEN,this.onPrebattleAmmunitionPanelViewHiddenHandler);
            this.prebattleAmmunitionPanel.removeEventListener(PrbAmmunitionPanelEvent.VIEW_SHOWN,this.onPrebattleAmmunitionPanelViewShownHandler);
            this.prebattleAmmunitionPanel.removeEventListener(PrbAmmunitionPanelEvent.STATE_CHANGED,this.onPrebattleAmmunitionPanelStateChangedHandler);
            this.prebattleAmmunitionPanel = null;
         }
         if(this.ribbonsPanel)
         {
            this.ribbonsPanel.removeEventListener(Event.CHANGE,this.onRibbonsPanelChangeHandler);
         }
         this.gameMessagesPanel.removeEventListener(GameMessagesPanelEvent.MESSAGES_STARTED_PLAYING,this.onMessagesStartedPlayingHandler);
         this.gameMessagesPanel.removeEventListener(GameMessagesPanelEvent.MESSAGES_ENDED_PLAYING,this.onMessagesEndedPlayingHandler);
         this.gameMessagesPanel.removeEventListener(GameMessagesPanelEvent.ALL_MESSAGES_ENDED_PLAYING,this.onAllMessagesEndedPlayingHandler);
         this.minimap.removeEventListener(MinimapEvent.TRY_SIZE_CHANGED,this.onMinimapTrySizeChangedHandler);
         this.minimap.removeEventListener(MinimapEvent.SIZE_CHANGED,this.onMinimapSizeChangedHandler);
         this.minimap.removeEventListener(MinimapEvent.VISIBILITY_CHANGED,this.onMinimapSizeChangedHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.battleLoading = null;
         this.prebattleTimer = null;
         this.damagePanel = null;
         this.battleTimer = null;
         this.prebattleTimer = null;
         this.ribbonsPanel = null;
         this.perksPanel = null;
         this.dualGunPanel = null;
         this.rocketAcceleratorPanel = null;
         this.calloutPanel = null;
         this.gameMessagesPanel = null;
         this.minimap = null;
         MinimapEntryController.instance.dispose();
         ControlsFactory.instance.dispose();
         if(this._messagesContainer)
         {
            this._messagesContainer = null;
         }
         this.vehicleMessageList = null;
         this.vehicleErrorMessageList = null;
         this.playerMessageList = null;
         this.battleStatisticDataController = null;
         this.piercingDebugPanel = null;
         this.deathCamHud = null;
         this.spectatorViewUI = null;
         this.postmortemPanelUI = null;
         App.utils.data.cleanupDynamicObject(this._componentsStorage);
         this._componentsStorage = null;
         this.hitTestFix = null;
         this.clearTweens();
         this._tweens = null;
         super.onDispose();
      }
      
      override protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         var _loc3_:String = null;
         for each(_loc3_ in param1)
         {
            this.showComponent(_loc3_,true);
         }
         for each(_loc3_ in param2)
         {
            this.showComponent(_loc3_,false);
         }
      }
      
      override protected function setComponentsVisibilityWithFade(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         var _loc3_:String = null;
         for each(_loc3_ in param1)
         {
            this.showComponentWithFade(_loc3_,true);
         }
         for each(_loc3_ in param2)
         {
            this.showComponentWithFade(_loc3_,false);
         }
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         if(!this.isElementVisible(param1))
         {
            DebugUtils.LOG_DEBUG("Cannot set focus on the invisible element!");
            setFocus(this);
         }
         super.onSetModalFocus(param1);
      }
      
      public function as_checkDAAPI() : void
      {
      }
      
      public function as_createRoleDescription() : void
      {
      }
      
      public function as_getComponentsVisibility() : Array
      {
         var _loc2_:* = null;
         var _loc3_:IDisplayableComponent = null;
         var _loc1_:Array = [];
         for(_loc2_ in this._componentsStorage)
         {
            _loc3_ = this._componentsStorage[_loc2_];
            if(_loc3_.isCompVisible())
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function as_isComponentVisible(param1:String) : Boolean
      {
         var _loc2_:IDisplayableComponent = null;
         _loc2_ = this._componentsStorage[param1];
         App.utils.asserter.assertNotNull(_loc2_,"can\'t find component " + param1 + " in Battle Page");
         return _loc2_.isCompVisible();
      }
      
      public function as_setArtyShotIndicatorFlag(param1:Boolean) : void
      {
      }
      
      public function as_onPostmortemActive(param1:Boolean) : void
      {
         if(this.postmortemPanelUI == null)
         {
            return;
         }
         this.postmortemPanelUI.setCompVisible(param1);
         this.isPostMortem = param1;
         this.vehicleMessageListPositionUpdate();
         if(this.isPostMortem)
         {
            this.updateBattleDamageLogPosInPostmortem();
         }
      }
      
      public function as_toggleCtrlPressFlag(param1:Boolean) : void
      {
         App.toolTipMgr.hide();
      }
      
      public function as_togglePiercingPanel() : void
      {
         if(this.piercingDebugPanel == null)
         {
            this.piercingDebugPanel = App.utils.classFactory.getComponent(Linkages.PIERCING_DEBUG_PANEL,PiercingDebugPanel);
            addChild(this.piercingDebugPanel);
            this.registerComponent(this.piercingDebugPanel,BATTLE_VIEW_ALIASES.PIERCING_DEBUG_PANEL);
            this.piercingDebugPanel.updateStage(_originalWidth,_originalHeight);
         }
         else
         {
            this.piercingDebugPanel.visible = !this.piercingDebugPanel.visible;
         }
      }
      
      protected function updatePrebattleTimerPosition(param1:int) : void
      {
         if(this.prebattleTimer)
         {
            this.prebattleTimer.x = param1;
            this.prebattleTimer.y = 0;
         }
      }
      
      protected function onPrebattleAmmunitionPanelShown() : void
      {
      }
      
      protected function onPrebattleAmmunitionPanelHidden(param1:Boolean) : void
      {
      }
      
      protected function createPostmortemPanelComponent() : void
      {
         if(this.postmortemPanelUI)
         {
            this.registerComponent(this.postmortemPanelUI,BATTLE_VIEW_ALIASES.POSTMORTEM_PANEL);
         }
         else
         {
            DebugUtils.LOG_WARNING("postmortemPanelUI component is not configured for this Battle Page");
         }
      }
      
      protected function createSpectatorViewComponent() : void
      {
         if(this.spectatorViewUI)
         {
            this.registerComponent(this.spectatorViewUI,BATTLE_VIEW_ALIASES.SPECTATOR_VIEW);
         }
         else
         {
            DebugUtils.LOG_WARNING("spectatorViewUI component doesn\'t configured for this Battle Page");
         }
      }
      
      protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
      {
      }
      
      protected function onMessagesStartedPlaying(param1:String) : void
      {
      }
      
      protected function onMessagesEndedPlaying(param1:String) : void
      {
      }
      
      protected function onAllMessagesEndedPlaying(param1:String) : void
      {
      }
      
      protected function createStatisticsController() : BattleStatisticDataController
      {
         return null;
      }
      
      protected function updateBattleDamageLogPosInPostmortem() : void
      {
      }
      
      protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
      }
      
      protected function initializeMessageLists() : void
      {
         this._messagesContainer = new Sprite();
         this._messagesContainer.name = "messageListsContainer";
         this._messagesContainer.mouseEnabled = this._messagesContainer.mouseChildren = false;
         addChild(this._messagesContainer);
         if(this.battleLoading)
         {
            swapChildren(this._messagesContainer,this.battleLoading);
         }
         this.vehicleMessageList = new VehicleMessages(this._messagesContainer);
         this.vehicleErrorMessageList = new MessageListDAAPI(this._messagesContainer);
         this.playerMessageList = new MessageListDAAPI(this._messagesContainer);
      }
      
      protected function onRegisterStatisticController() : void
      {
      }
      
      protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         return param1;
      }
      
      protected function playerMessageListPositionUpdate() : void
      {
         this.playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_originalHeight - this.minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y);
      }
      
      protected function vehicleErrorMessageListPositionUpdate() : void
      {
         this.vehicleErrorMessageList.setLocation(_originalWidth - VEHICLE_ERRORS_LIST_OFFSET.x >> 1,(_originalHeight >> 2) + VEHICLE_ERRORS_LIST_OFFSET.y);
      }
      
      protected function vehicleMessageListPositionUpdate() : void
      {
         if(this.postmortemPanelUI && this.postmortemPanelUI.visible)
         {
            this.vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,this.postmortemPanelUI.y - VEHICLE_MESSAGES_LIST_OFFSET.y - VEHICLE_MESSAGES_LIST_POSTMORTEM_Y_OFFSET | 0);
         }
         else
         {
            this.vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET.y | 0);
         }
      }
      
      protected function registerComponent(param1:IDAAPIModule, param2:String) : void
      {
         this._componentsStorage[param2] = param1;
         registerFlashComponentS(param1,param2);
      }
      
      protected function getRibbonsCenterOffset(param1:Number) : int
      {
         return RIBBONS_CENTER_SCREEN_OFFSET_Y;
      }
      
      protected function getComponent(param1:String) : IDAAPIModule
      {
         return this._componentsStorage[param1];
      }
      
      protected function updateMinimapPosition() : void
      {
         this.minimap.x = _width - this.minimap.currentWidth;
         this.minimap.y = _height - this.minimap.currentHeight;
         this.minimap.dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
      }
      
      protected function getAmmunitionPanelYShift() : int
      {
         return AMMUNITION_PANEL_Y_SHIFT;
      }
      
      protected function updateAmmunitionPanelY() : void
      {
         if(this.prebattleAmmunitionPanel)
         {
            this.prebattleAmmunitionPanel.setYPos(this.battleLoading && this.prebattleAmmunitionPanel.isInLoading ? int(this.battleLoading.getContentY() + this.getAmmunitionPanelYShift()) : int(_originalHeight - this.prebattleAmmunitionPanel.height + this.getLoadedPrebattleAmmoPanelYShift()));
         }
      }
      
      protected function anchorVictimDogTag() : void
      {
         if(this.postmortemPanelUI)
         {
            PostmortemPanel(this.postmortemPanelUI).anchorVictimDogTag(this.minimap.currentTopLeftPoint.y);
         }
      }
      
      protected function getLoadedPrebattleAmmoPanelYShift() : int
      {
         return 0;
      }
      
      private function isElementVisible(param1:InteractiveObject) : Boolean
      {
         return param1 && param1.visible && param1.parent != this && this.isElementVisible(param1.parent);
      }
      
      private function showComponent(param1:String, param2:Boolean) : void
      {
         var _loc3_:IDisplayableComponent = null;
         _loc3_ = this._componentsStorage[param1];
         App.utils.asserter.assertNotNull(_loc3_,param1 + " " + Errors.CANT_NULL);
         this.completeActiveTweens(_loc3_);
         _loc3_.setCompVisible(param2);
         this.onComponentVisibilityChanged(param1,param2);
      }
      
      private function showComponentWithFade(param1:String, param2:Boolean) : void
      {
         var component:IDisplayableComponent = null;
         var needUpdate:Boolean = false;
         var componentKey:String = param1;
         var value:Boolean = param2;
         needUpdate = true;
         component = this._componentsStorage[componentKey];
         App.utils.asserter.assertNotNull(component,componentKey + " " + Errors.CANT_NULL);
         this.completeActiveTweens(component);
         if(value == component.isCompVisible())
         {
            this.onComponentVisibilityChanged(componentKey,value);
            return;
         }
         if(value && !component.isCompVisible())
         {
            component.setCompVisible(value);
            (component as DisplayObject).alpha = 0;
            needUpdate = false;
            this.onComponentVisibilityChanged(componentKey,value);
         }
         this._tweens.push(new Tween(TWEEN_DURATION,component,{"alpha":(!!value ? 1 : 0)},{
            "ease":Linear.easeIn,
            "onComplete":function():void
            {
               component.setCompVisible(value);
               (component as DisplayObject).alpha = 1;
               if(needUpdate)
               {
                  onComponentVisibilityChanged(componentKey,value);
               }
            }
         }));
      }
      
      protected function updateMinimapSizeIndex(param1:Number) : void
      {
         this.minimap.setAllowedSizeIndex(this.getAllowedMinimapSizeIndex(param1));
      }
      
      private function updatePostmortemUIPosition() : void
      {
         this.postmortemPanelUI.x = width >> 1;
         this.postmortemPanelUI.y = height;
         this.postmortemPanelUI.updateElementsPosition();
         this.anchorVictimDogTag();
      }
      
      protected function get prebattleAmmunitionPanelShown() : Boolean
      {
         return this.prebattleAmmunitionPanelAvailable && this.prebattleAmmunitionPanel && !this.prebattleAmmunitionPanel.isHidden;
      }
      
      protected function get prebattleAmmunitionPanelAvailable() : Boolean
      {
         return false;
      }
      
      protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         this.anchorVictimDogTag();
         this.playerMessageListPositionUpdate();
      }
      
      private function onPrebattleAmmunitionPanelViewShownHandler(param1:PrbAmmunitionPanelEvent) : void
      {
         this.onPrebattleAmmunitionPanelShown();
      }
      
      private function onMessagesStartedPlayingHandler(param1:GameMessagesPanelEvent) : void
      {
         this.onMessagesStartedPlaying(param1.messageType);
      }
      
      private function onMessagesEndedPlayingHandler(param1:GameMessagesPanelEvent) : void
      {
         this.onMessagesEndedPlaying(param1.messageType);
      }
      
      private function onAllMessagesEndedPlayingHandler(param1:GameMessagesPanelEvent) : void
      {
         this.onAllMessagesEndedPlaying(param1.messageType);
      }
      
      private function onRibbonsPanelChangeHandler(param1:Event) : void
      {
         this.ribbonsPanel.x = (_originalWidth >> 1) + this.ribbonsPanel.offsetX;
      }
      
      private function onMinimapTrySizeChangedHandler(param1:MinimapEvent) : void
      {
         this.updateMinimapSizeIndex(param1.sizeIndex);
      }
      
      private function onPrebattleAmmunitionPanelViewHiddenHandler(param1:PrbAmmunitionPanelEvent) : void
      {
         this.onPrebattleAmmunitionPanelHidden(param1.useAnim);
      }
      
      private function onPrebattleAmmunitionPanelStateChangedHandler(param1:PrbAmmunitionPanelEvent) : void
      {
         if(this.prebattleAmmunitionPanel)
         {
            if(this.battleLoading)
            {
               this.battleLoading.hasAmmunitionPanel(this.prebattleAmmunitionPanel.isInLoading);
            }
            this.updateAmmunitionPanelY();
         }
      }
      
      private function completeActiveTweens(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Tween = null;
         if(this._tweens.length > 0)
         {
            _loc2_ = this._tweens.length - 1;
            while(_loc2_ >= 0)
            {
               _loc3_ = this._tweens[_loc2_];
               if(_loc3_.target == param1 && !_loc3_.paused)
               {
                  _loc3_.onComplete && _loc3_.onComplete();
                  _loc3_.dispose();
                  _loc3_ = null;
                  this._tweens.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
      }
      
      private function clearTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens.length > 0)
         {
            for each(_loc1_ in this._tweens)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._tweens.length = 0;
         }
      }
      
      private function addDeathCamHud() : void
      {
         if(!this.deathCamHud)
         {
            this.deathCamHud = new DeathCamHud();
            this.deathCamHud.setManageSize(true);
            this.deathCamHud.setSize(this.parent.width,this.parent.height);
            this.deathCamHud.x = 0;
            this.deathCamHud.y = 0;
            this.deathCamHud.visible = false;
            addChild(this.deathCamHud);
         }
      }
   }
}
