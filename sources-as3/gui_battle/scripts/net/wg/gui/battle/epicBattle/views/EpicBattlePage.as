package net.wg.gui.battle.epicBattle.views
{
   import fl.transitions.easing.Strong;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.epicBattle.battleloading.EpicBattleLoading;
   import net.wg.gui.battle.epicBattle.battleloading.events.EpicBattleLoadingEvent;
   import net.wg.gui.battle.epicBattle.views.stats.EpicFullStats;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
   import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
   import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
   import net.wg.gui.battle.views.debugPanel.DebugPanel;
   import net.wg.gui.battle.views.epicDeploymentMap.EpicDeploymentMap;
   import net.wg.gui.battle.views.epicInGameRank.EpicInGameRankPanel;
   import net.wg.gui.battle.views.epicMissionsPanel.EpicMissionsPanel;
   import net.wg.gui.battle.views.epicOverviewMapScreen.EpicOverviewMapScreen;
   import net.wg.gui.battle.views.epicReinforcementPanel.EpicReinforcementPanel;
   import net.wg.gui.battle.views.epicRespawnView.EpicRespawnView;
   import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
   import net.wg.gui.battle.views.epicScorePanel.EpicScorePanel;
   import net.wg.gui.battle.views.epicScorePanel.events.EpicScorePanelEvent;
   import net.wg.gui.battle.views.epicSpectatorView.EpicSpectatorView;
   import net.wg.gui.battle.views.minimap.EpicMinimap;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBg;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerEvent;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.gui.battle.views.recoveryPanel.RecoveryPanel;
   import net.wg.gui.battle.views.siegeModePanel.SiegeModePanel;
   import net.wg.gui.battle.views.sixthSense.SixthSense;
   import net.wg.gui.battle.views.superPlatoonPanel.SuperPlatoonPanel;
   import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.hintPanel.HintPanel;
   import net.wg.infrastructure.base.meta.IEpicBattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattlePageMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.EpicBattleStatisticDataController;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.motion.Tween;
   
   public class EpicBattlePage extends EpicBattlePageMeta implements IEpicBattlePageMeta
   {
      
      private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;
      
      private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;
      
      private static const MESSENGER_OFFSET_Y:int = 44;
      
      private static const MESSENGER_IN_RESPAWN_OFFSET_Y_SMALL:int = 287;
      
      private static const MESSENGER_IN_RESPAWN_OFFSET_Y_BIG:int = 205;
      
      private static const PREBATTLE_TIMER_Y_OFFSET:int = 82;
      
      private static const PREBATTLE_TIMER_FINAL_Y_OFFSET:int = 30;
      
      private static const TEAM_BASES_PANEL_OFFSETS:Vector.<int> = new <int>[62,102,102];
      
      private static const TEAM_BASES_PANEL_TOP_OFFSET:int = 12;
      
      private static const SCORE_PANEL_HIDDEN_OFFSET:int = -80;
      
      private static const MSG_PNL_OFFSET:int = 128;
      
      private static const MSG_PNL_Y_BREAKPOINT:int = 1024;
      
      private static const SCORE_PANEL_FADE_OUT_TWEEN_LENGTH:int = 400;
      
      private static const SCORE_PANEL_FADE_IN_TWEEN_LENGTH:int = 800;
      
      private static const CAPTURE_BAR_TWEEN_LENGTH:int = 600;
      
      private static const PREBATTLE_TIMER_TWEEN_LENGTH:int = 600;
      
      private static const PREBATTLE_TIMER_BACKGROUND_TWEEN_LENGTH:int = 700;
      
      private static const TOP_EPIC_BATTLE_EAR_ELEMENTS_OFFSET:int = 60;
      
      private static const SUPER_PLATOON_MAX_HEIGHT:int = 160;
      
      private static const HINT_PANEL_Y_SHIFT_MULTIPLIER:Number = 1.5;
      
      private static const HINT_PANEL_AMMUNITION_OFFSET_Y:int = -160;
      
      private static const AMMUNITION_PANEL_Y_SHIFT:int = 587;
       
      
      public var fullStats:EpicFullStats = null;
      
      public var debugPanel:DebugPanel = null;
      
      public var sixthSense:SixthSense = null;
      
      public var radialMenu:RadialMenu = null;
      
      public var teamBasesPanelUI:TeamBasesPanel = null;
      
      public var damageInfoPanel:DamageInfoPanel = null;
      
      public var battleMessenger:BattleMessenger = null;
      
      public var consumablesPanel:ConsumablesPanel = null;
      
      public var battleDamageLogPanel:BattleDamageLogPanel = null;
      
      public var siegeModePanel:SiegeModePanel = null;
      
      public var epicMissionsPanel:EpicMissionsPanel = null;
      
      public var epicScorePanelUI:EpicScorePanel = null;
      
      public var epicSpectatorViewUI:EpicSpectatorView = null;
      
      public var epicRespawnView:EpicRespawnView = null;
      
      public var epicDeploymentMap:EpicDeploymentMap = null;
      
      public var epicOverviewMapScreen:EpicOverviewMapScreen = null;
      
      public var endWarningPanel:BattleEndWarningPanel = null;
      
      public var recoveryPanel:RecoveryPanel = null;
      
      public var epicReinforcementPanel:EpicReinforcementPanel = null;
      
      public var superPlatoonPanel:SuperPlatoonPanel = null;
      
      public var epicInGameRank:EpicInGameRankPanel = null;
      
      public var hintPanel:HintPanel = null;
      
      public var prebattleTimerBackground:PrebattleTimerBg = null;
      
      public var statusNotificationsPanel:StatusNotificationsPanel = null;
      
      private var _scorePanelState:int = 0;
      
      private var _messagePlaying:Boolean = false;
      
      private var _countDownComplete:Boolean = false;
      
      private var _selectReservesAvailable:Boolean = true;
      
      private var _isVehPostProgressionEnabled:Boolean;
      
      public function EpicBattlePage()
      {
         super();
         this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
      }
      
      override public function as_setPostmortemTipsVisible(param1:Boolean) : void
      {
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:int = 0;
         super.updateStage(param1,param2);
         _loc3_ = param1 >> 1;
         _originalWidth = param1;
         _originalHeight = param2;
         if(this.prebattleTimerBackground)
         {
            this.prebattleTimerBackground.y = 0;
            this.prebattleTimerBackground.x = _loc3_;
            this.prebattleTimerBackground.updateSize(param1,param2);
         }
         gameMessagesPanel.x = param1 >> 1;
         gameMessagesPanel.y = MSG_PNL_OFFSET;
         if(param2 >= MSG_PNL_Y_BREAKPOINT)
         {
            gameMessagesPanel.y = param2 >> 3;
         }
         if(this._messagePlaying)
         {
            this.teamBasesPanelUI.y = TEAM_BASES_PANEL_TOP_OFFSET;
         }
         else
         {
            this.teamBasesPanelUI.y = TEAM_BASES_PANEL_OFFSETS[this._scorePanelState];
         }
         this.teamBasesPanelUI.x = _loc3_;
         this.sixthSense.updateStage(param1,param2);
         this.damageInfoPanel.y = (param2 >> 1) / stage.scaleY + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * stage.scaleY | 0;
         this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
         this.battleMessenger.x = damagePanel.x;
         this.epicReinforcementPanel.x = damagePanel.x;
         this.epicReinforcementPanel.y = damagePanel.y;
         this.updateChatAndReinforcementPosition();
         this.battleMessenger.updateSwapAreaHeight(damagePanel.y - (this.superPlatoonPanel.y + SUPER_PLATOON_MAX_HEIGHT));
         this.epicRespawnView.x = _loc3_;
         this.epicRespawnView.y = 0;
         this.epicOverviewMapScreen.x = _loc3_;
         this.epicOverviewMapScreen.y = 0;
         this.fullStats.updateStageSize(param1,param2);
         this.consumablesPanel.updateStage(param1,param2);
         this.radialMenu.updateStage(param1,param2);
         this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
         this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING;
         this.battleDamageLogPanel.updateSize(param1,param2);
         this.updateBattleDamageLogPanelPosition();
         if(this._messagePlaying)
         {
            this.epicScorePanelUI.x = _loc3_;
            this.epicScorePanelUI.y = SCORE_PANEL_HIDDEN_OFFSET;
         }
         else
         {
            this.epicScorePanelUI.updateStage(param1,param2);
         }
         this.epicSpectatorViewUI.updateStage(param1,param2);
         this.epicRespawnView.updateStage(param1,param2);
         this.epicRespawnView.isVehPostProgressionEnabled = this._isVehPostProgressionEnabled;
         this.epicDeploymentMap.updateStagePosition(param1,param2);
         this.epicDeploymentMap.isVehPostProgressionEnabled = this._isVehPostProgressionEnabled;
         this.epicOverviewMapScreen.updateStage(param1,param2);
         this.endWarningPanel.x = _loc3_;
         this.epicMissionsPanel.x = param1;
         this.epicMissionsPanel.y = TOP_EPIC_BATTLE_EAR_ELEMENTS_OFFSET;
         this.epicInGameRank.x = 0;
         this.epicInGameRank.y = TOP_EPIC_BATTLE_EAR_ELEMENTS_OFFSET;
         this.recoveryPanel.updateStage(param1,param2);
         this.statusNotificationsPanel.updateStage(param1,param2);
         this.updateHintPanelPosition();
      }
      
      override protected function updatePrebattleTimerPosition(param1:int) : void
      {
         prebattleTimer.x = param1;
         prebattleTimer.y = !!this._countDownComplete ? Number(PREBATTLE_TIMER_FINAL_Y_OFFSET) : Number(PREBATTLE_TIMER_Y_OFFSET);
      }
      
      override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
         var _loc2_:EpicBattleStatisticDataController = EpicBattleStatisticDataController(param1);
         _loc2_.setDisplayObjectContainer(this);
         _loc2_.registerComponentController(this.fullStats);
         _loc2_.registerComponentController(battleLoading);
         _loc2_.registerComponentController(this.superPlatoonPanel);
         _loc2_.registerEpicComponentController(this.fullStats);
         _loc2_.registerEpicComponentController(battleLoading as EpicBattleLoading);
         _loc2_.registerEpicComponentController(minimap as EpicMinimap);
         _loc2_.registerEpicComponentController(this.epicRespawnView);
         _loc2_.registerEpicComponentController(this.epicMissionsPanel);
         _loc2_.registerEpicComponentController(this.epicScorePanelUI);
         _loc2_.registerEpicComponentController(this.epicOverviewMapScreen);
         _loc2_.registerEpicComponentController(this.superPlatoonPanel);
         super.initializeStatisticsController(param1);
      }
      
      override protected function configUI() : void
      {
         this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         super.configUI();
         prebattleTimer.hideBackground();
         prebattleTimer.addEventListener(PrebattleTimerEvent.START_HIDING,this.onPrebattleTimerStartHidingHandler);
         this.epicRespawnView.mouseEnabled = false;
         this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.teamBasesPanelUI,BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
         registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
         registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
         registerComponent(this.fullStats,BATTLE_VIEW_ALIASES.FULL_STATS);
         registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
         registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
         registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
         registerComponent(this.siegeModePanel,BATTLE_VIEW_ALIASES.SIEGE_MODE_INDICATOR);
         registerComponent(this.epicScorePanelUI,BATTLE_VIEW_ALIASES.EPIC_SCORE_PANEL);
         registerComponent(this.epicRespawnView,BATTLE_VIEW_ALIASES.EPIC_RESPAWN_VIEW);
         registerComponent(this.epicDeploymentMap,BATTLE_VIEW_ALIASES.EPIC_DEPLOYMENT_MAP);
         registerComponent(this.epicOverviewMapScreen,BATTLE_VIEW_ALIASES.EPIC_OVERVIEW_MAP_SCREEN);
         registerComponent(this.epicMissionsPanel,BATTLE_VIEW_ALIASES.EPIC_MISSIONS_PANEL);
         registerComponent(this.epicSpectatorViewUI,BATTLE_VIEW_ALIASES.EPIC_SPECTATOR_VIEW);
         registerComponent(this.epicReinforcementPanel,BATTLE_VIEW_ALIASES.EPIC_REINFORCEMENT_PANEL);
         registerComponent(this.recoveryPanel,BATTLE_VIEW_ALIASES.RECOVERY_PANEL);
         registerComponent(this.superPlatoonPanel,BATTLE_VIEW_ALIASES.SUPER_PLATOON_PANEL);
         registerComponent(this.epicInGameRank,BATTLE_VIEW_ALIASES.EPIC_INGAME_RANK);
         registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
         registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
         super.onPopulate();
         this.endWarningPanel.alpha = 0;
      }
      
      override protected function onPrebattleAmmunitionPanelShown() : void
      {
         super.onPrebattleAmmunitionPanelShown();
         this.updateConsumablePanel();
         this.updateHintPanelPosition();
      }
      
      override protected function onPrebattleAmmunitionPanelHidden(param1:Boolean) : void
      {
         this.updateConsumablePanel(param1);
      }
      
      override protected function onRegisterStatisticController() : void
      {
         registerFlashComponentS(battleStatisticDataController,BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
      }
      
      override protected function onBeforeDispose() : void
      {
         prebattleTimer.removeEventListener(PrebattleTimerEvent.START_HIDING,this.onPrebattleTimerStartHidingHandler);
         this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.epicRespawnView.removeEventListener(EpicRespawnEvent.VIEW_CHANGED,this.onRespawnViewChangedHandler);
         this.epicScorePanelUI.removeEventListener(EpicScorePanelEvent.STATE_CHANGED,this.onScorePanelStateChangedHandler);
         battleLoading.removeEventListener(EpicBattleLoadingEvent.VISIBILITY_CHANGED,this.onBattleLoadingVisibilityChangedHandler);
         this.hintPanel.removeEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.hintPanel = null;
         this.sixthSense = null;
         this.debugPanel = null;
         this.fullStats = null;
         this.radialMenu = null;
         this.battleMessenger = null;
         this.damageInfoPanel = null;
         this.teamBasesPanelUI = null;
         this.consumablesPanel = null;
         this.battleDamageLogPanel = null;
         this.epicRespawnView = null;
         this.epicScorePanelUI = null;
         this.epicSpectatorViewUI = null;
         this.epicDeploymentMap = null;
         this.epicOverviewMapScreen = null;
         this.recoveryPanel = null;
         this.endWarningPanel = null;
         this.epicMissionsPanel = null;
         this.epicReinforcementPanel = null;
         this.superPlatoonPanel = null;
         this.epicInGameRank = null;
         this.siegeModePanel = null;
         this.prebattleTimerBackground.dispose();
         this.prebattleTimerBackground = null;
         this.statusNotificationsPanel = null;
         super.onDispose();
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc2_:Number = App.appWidth - this.consumablesPanel.panelWidth;
         var _loc3_:Rectangle = null;
         while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
         {
            _loc3_ = minimap.getMinimapRectBySizeIndex(param1);
            if(_loc2_ - _loc3_.width >= 0)
            {
               break;
            }
            param1--;
         }
         return param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.epicRespawnView.addEventListener(EpicRespawnEvent.VIEW_CHANGED,this.onRespawnViewChangedHandler);
         this.epicScorePanelUI.addEventListener(EpicScorePanelEvent.STATE_CHANGED,this.onScorePanelStateChangedHandler);
         battleLoading.addEventListener(EpicBattleLoadingEvent.VISIBILITY_CHANGED,this.onBattleLoadingVisibilityChangedHandler);
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new EpicBattleStatisticDataController();
      }
      
      override protected function onAllMessagesEndedPlaying(param1:String) : void
      {
         var messageType:String = param1;
         super.onAllMessagesEndedPlaying(messageType);
         if(!this._messagePlaying)
         {
            return;
         }
         this._messagePlaying = false;
         this.epicScorePanelUI.checkState();
         var scoreTween:Tween = new Tween(SCORE_PANEL_FADE_IN_TWEEN_LENGTH,this.epicScorePanelUI,{
            "alpha":1,
            "y":0
         },{
            "ease":Strong.easeInOut,
            "onComplete":function(param1:Tween):void
            {
               param1.dispose();
               param1 = null;
            }
         });
         var capBarTween:Tween = new Tween(CAPTURE_BAR_TWEEN_LENGTH,this.teamBasesPanelUI,{"y":TEAM_BASES_PANEL_OFFSETS[this._scorePanelState]},{
            "ease":Strong.easeInOut,
            "onComplete":function(param1:Tween):void
            {
               param1.dispose();
               param1 = null;
            }
         });
      }
      
      override protected function onMessagesStartedPlaying(param1:String) : void
      {
         var messageType:String = param1;
         super.onMessagesStartedPlaying(messageType);
         this._messagePlaying = true;
         var scoreTween:Tween = new Tween(SCORE_PANEL_FADE_OUT_TWEEN_LENGTH,this.epicScorePanelUI,{
            "alpha":0,
            "y":SCORE_PANEL_HIDDEN_OFFSET
         },{
            "ease":Strong.easeInOut,
            "onComplete":function(param1:Tween):void
            {
               epicScorePanelUI.checkState();
               param1.dispose();
               param1 = null;
            }
         });
         var capBarTween:Tween = new Tween(CAPTURE_BAR_TWEEN_LENGTH,this.teamBasesPanelUI,{"y":TEAM_BASES_PANEL_TOP_OFFSET},{
            "ease":Strong.easeInOut,
            "onComplete":function(param1:Tween):void
            {
               param1.dispose();
               param1 = null;
            }
         });
      }
      
      override protected function getAmmunitionPanelYShift() : int
      {
         return AMMUNITION_PANEL_Y_SHIFT;
      }
      
      public function as_setSelectReservesAvailable(param1:Boolean) : void
      {
         this._selectReservesAvailable = param1;
      }
      
      public function as_setVehPostProgressionEnabled(param1:Boolean) : void
      {
         this._isVehPostProgressionEnabled = param1;
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      private function updateConsumablePanel(param1:Boolean = false) : void
      {
         if(prebattleAmmunitionPanelShown)
         {
            this.consumablesPanel.hide(param1);
         }
         else
         {
            this.consumablesPanel.show(param1);
         }
      }
      
      private function updateChatAndReinforcementPosition() : void
      {
         this.battleMessenger.y = !!this.epicRespawnView.visible ? Number(_originalHeight - this.messangerInrespawnOffsetY) : Number(damagePanel.y - this.battleMessenger.height - MESSENGER_OFFSET_Y);
      }
      
      private function updateBattleDamageLogPanelPosition() : void
      {
         var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT;
         if(this.battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH >= this.consumablesPanel.x)
         {
            _loc1_ = BattleDamageLogConstants.MIN_VIEW_RENDER_COUNT;
         }
         this.battleDamageLogPanel.setDetailActionCount(_loc1_);
      }
      
      private function updateHintPanelPosition() : void
      {
         this.hintPanel.x = _originalWidth - this.hintPanel.width >> 1;
         this.hintPanel.y = HINT_PANEL_Y_SHIFT_MULTIPLIER * (_originalHeight - this.hintPanel.height >> 1) | 0;
         if(prebattleAmmunitionPanelShown)
         {
            this.hintPanel.y += HINT_PANEL_AMMUNITION_OFFSET_Y;
         }
      }
      
      override protected function get prebattleAmmunitionPanelAvailable() : Boolean
      {
         return true;
      }
      
      private function get messangerInrespawnOffsetY() : int
      {
         return _originalHeight < StageSizeBoundaries.HEIGHT_900 ? int(MESSENGER_IN_RESPAWN_OFFSET_Y_SMALL) : int(MESSENGER_IN_RESPAWN_OFFSET_Y_BIG);
      }
      
      override protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         super.onMinimapSizeChangedHandler(param1);
         super.updateStage(App.appWidth,App.appHeight);
      }
      
      private function onHintPanelResizeHandler(param1:Event) : void
      {
         this.updateHintPanelPosition();
      }
      
      private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
         if(getChildIndex(this.battleMessenger) < getChildIndex(this.epicRespawnView))
         {
            swapChildren(this.battleMessenger,this.epicRespawnView);
         }
      }
      
      private function onBattleMessengerRemoveFocusHandler(param1:Event) : void
      {
         setFocus(this);
         if(getChildIndex(this.battleMessenger) > getChildIndex(this.epicRespawnView))
         {
            swapChildren(this.battleMessenger,this.epicRespawnView);
         }
      }
      
      private function onConsumablesPanelUpdatePositionHandler(param1:ConsumablesPanelEvent) : void
      {
         if(isPostMortem)
         {
            this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         }
         this.updateBattleDamageLogPanelPosition();
         minimap.updateSizeIndex(false);
      }
      
      private function onRespawnViewChangedHandler(param1:EpicRespawnEvent) : void
      {
         this.epicDeploymentMap.activeInRespawn(this.epicRespawnView.visible,_originalWidth,_originalHeight);
         this.updateChatAndReinforcementPosition();
      }
      
      private function onBattleLoadingVisibilityChangedHandler(param1:EpicBattleLoadingEvent) : void
      {
         var _loc2_:EpicBattleStatisticDataController = null;
         var _loc3_:EpicBattleLoading = null;
         this.epicDeploymentMap.activeInLoadingScreen(battleLoading.visible,_originalWidth,_originalHeight);
         if(!battleLoading.visible)
         {
            battleStatisticDataController.unregisterComponentController(battleLoading);
            _loc2_ = battleStatisticDataController as EpicBattleStatisticDataController;
            if(_loc2_)
            {
               _loc3_ = battleLoading as EpicBattleLoading;
               if(_loc3_)
               {
                  _loc2_.unregisterEpicComponentController(_loc3_);
               }
            }
            this.epicInGameRank.isActive = true;
         }
      }
      
      private function onScorePanelStateChangedHandler(param1:EpicScorePanelEvent) : void
      {
         var CountDownEnd:Tween = null;
         var event:EpicScorePanelEvent = param1;
         var scorePanelState:String = event.state;
         if(scorePanelState == EpicScorePanelEvent.SINGLE_ROW_STATE)
         {
            this._scorePanelState = 0;
         }
         else if(scorePanelState == EpicScorePanelEvent.DOUBLE_ROW_STATE)
         {
            this._scorePanelState = 1;
         }
         else if(scorePanelState == EpicScorePanelEvent.PRE_BATTLE_TRANSITION_START)
         {
            this._countDownComplete = true;
            CountDownEnd = new Tween(PREBATTLE_TIMER_TWEEN_LENGTH,prebattleTimer,{"y":PREBATTLE_TIMER_FINAL_Y_OFFSET},{"onComplete":function(param1:Tween):void
            {
               param1.dispose();
               param1 = null;
            }});
         }
         if(!this._messagePlaying)
         {
            this.teamBasesPanelUI.y = TEAM_BASES_PANEL_OFFSETS[this._scorePanelState];
         }
      }
      
      private function onPrebattleTimerStartHidingHandler(param1:PrebattleTimerEvent) : void
      {
         var countDownEnding:Tween = null;
         var event:PrebattleTimerEvent = param1;
         if(this.prebattleTimerBackground)
         {
            if(event.useAnim && this.prebattleTimerBackground.visible)
            {
               countDownEnding = new Tween(PREBATTLE_TIMER_BACKGROUND_TWEEN_LENGTH,this.prebattleTimerBackground,{"alpha":0},{"onComplete":function(param1:Tween):void
               {
                  prebattleTimerBackground.visible = false;
                  param1.dispose();
                  param1 = null;
               }});
            }
            else
            {
               this.prebattleTimerBackground.visible = false;
            }
         }
      }
   }
}
