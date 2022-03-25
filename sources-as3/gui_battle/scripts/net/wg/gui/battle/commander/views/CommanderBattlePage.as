package net.wg.gui.battle.commander.views
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.gui.battle.commander.views.commanderHelp.CommanderHelp;
   import net.wg.gui.battle.commander.views.fullStats.RTSFullStats;
   import net.wg.gui.battle.commander.views.playersPanel.RTSPlayersPanel;
   import net.wg.gui.battle.commander.views.spawnMenu.SpawnMenu;
   import net.wg.gui.battle.commander.views.supplyPanel.SupplyPanel;
   import net.wg.gui.battle.commander.views.vehicleSelection.VehicleSelection;
   import net.wg.gui.battle.commander.views.vehicleSelection.events.RTSVehicleSelectionEvent;
   import net.wg.gui.battle.commander.views.vehiclesPanel.VehiclesPanel;
   import net.wg.gui.battle.components.TimersPanel;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
   import net.wg.gui.battle.random.views.fragCorrelationBar.FragCorrelationBar;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelEvent;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.events.PlayersPanelSwitchEvent;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
   import net.wg.gui.battle.views.BattlePageQuestsProgress;
   import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
   import net.wg.gui.battle.views.battleEndWarning.EndWarningPanelEvent;
   import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
   import net.wg.gui.battle.views.battleNotifier.BattleNotifier;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
   import net.wg.gui.battle.views.debugPanel.DebugPanel;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.gui.battle.views.siegeModePanel.SiegeModePanel;
   import net.wg.gui.battle.views.sixthSense.SixthSense;
   import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.hintPanel.HintPanel;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.RTSBattleStatisticDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   
   public class CommanderBattlePage extends BattlePageQuestsProgress implements IRTSBattleStatisticDataController
   {
      
      private static const COMMANDER_BATTLE_LOG_OFFSET_WIDE_SCREEN:Number = 16;
      
      private static const COMMANDER_BATTLE_LOG_OFFSET_NARROW_SCREEN:Number = -44;
      
      private static const TOP_CONTAINER_OFFSET:Number = 70;
      
      private static const MINIMAP_OFFSET:Number = 15;
      
      private static const RTS_INVALID_PLAYERS_PANEL_STATE:String = "rtsInvalidPlayersPanelState";
      
      private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;
      
      private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;
      
      private static const CONSUMABLES_POPUP_OFFSET:int = 60;
      
      private static const MINIMAP_MARGIN_HEIGHT:int = 6;
      
      private static const MINIMAP_MARGIN_WIDTH:int = 0;
      
      private static const MESSANGER_SWAP_AREA_TOP_OFFSET:Number = -27;
      
      private static const QUEST_PROGRESS_TOP_SHIFT:int = 45;
      
      private static const WARNING_PANEL_TOP_SHIFT:int = 67;
      
      private static const INVALID_PLAYERS_PANEL_STATE:String = "invalidPlayersPanelState";
      
      private static const HINT_PANEL_Y_SHIFT_MULTIPLIER:Number = 1.5;
      
      private static const HIT_TEST_FIX_NAME:String = "HitTest Fix";
      
      private static const COMMANDER_HELP_BOTTOM_OFFSET:Number = 135;
      
      private static const BATTLE_DAMAGE_LOG_WIDTH:int = 70;
      
      protected static const HINT_PANEL_AMMUNITION_OFFSET_Y:int = -160;
       
      
      public var debugPanel:DebugPanel = null;
      
      public var battleDamageLogPanel:BattleDamageLogPanel = null;
      
      public var teamBasesPanelUI:TeamBasesPanel = null;
      
      public var sixthSense:SixthSense = null;
      
      public var battleNotifier:BattleNotifier = null;
      
      public var consumablesPanel:ConsumablesPanel = null;
      
      public var destroyTimersPanel:TimersPanel = null;
      
      public var hintPanel:HintPanel = null;
      
      public var damageInfoPanel:DamageInfoPanel = null;
      
      public var battleMessenger:BattleMessenger = null;
      
      public var fragCorrelationBar:FragCorrelationBar = null;
      
      public var fullStats:RTSFullStats = null;
      
      public var playersPanel:RTSPlayersPanel = null;
      
      public var radialMenu:RadialMenu = null;
      
      public var endWarningPanel:BattleEndWarningPanel = null;
      
      public var siegeModePanel:SiegeModePanel = null;
      
      public var spawnMenu:SpawnMenu;
      
      public var supplyPanel:SupplyPanel;
      
      public var vehicleSelection:VehicleSelection;
      
      public var commanderHelp:CommanderHelp;
      
      public var vehiclesPanel:VehiclesPanel;
      
      public var eventMessage:EventBattleHint;
      
      private var _isCommanderMode:Boolean = false;
      
      private var _hitTestFix:Sprite;
      
      private var _playersPanelState:int = -1;
      
      private var _playersPanelHasInvite:Boolean = false;
      
      private var _isPlayersPanelIsEmpty:Boolean = true;
      
      public function CommanderBattlePage()
      {
         this._hitTestFix = new Sprite();
         super();
         this.playersPanel.addEventListener(Event.CHANGE,this.onPlayersPanelChangeHandler);
         this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
         this.playersPanel.addEventListener(Event.CHANGE,this.onPlayersPanelChangeHandler);
         this.endWarningPanel.addEventListener(EndWarningPanelEvent.VISIBILITY_CHANGED,this.onEndWarningPanelVisibilityChangedHandler);
         this._hitTestFix.graphics.beginFill(16777215,0);
         this._hitTestFix.graphics.drawRect(0,0,1,1);
         this._hitTestFix.graphics.endFill();
         this._hitTestFix.name = HIT_TEST_FIX_NAME;
         addChildAt(this._hitTestFix,0);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         super.updateStage(param1,param2);
         _loc3_ = param1 >> 1;
         this.teamBasesPanelUI.x = _loc3_;
         this.sixthSense.x = _loc3_;
         this.sixthSense.y = param2 >> 2;
         var _loc4_:Number = stage.scaleY;
         this.damageInfoPanel.y = (param2 >> 1) / _loc4_ + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * _loc4_ | 0;
         this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
         this.fragCorrelationBar.x = _loc3_;
         this.fragCorrelationBar.updateStage(param1,param2);
         this.battleMessenger.x = damagePanel.x;
         this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSENGER_Y_OFFSET;
         this.destroyTimersPanel.updateStage(param1,param2);
         this.fullStats.updateStageSize(param1,param2);
         this.playersPanel.updateStageSize(param1,param2);
         this.consumablesPanel.updateStage(param1,param2);
         this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
         this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING;
         this.battleDamageLogPanel.updateSize(param1,param2);
         this.radialMenu.updateStage(param1,param2);
         this.endWarningPanel.x = _loc3_;
         this.battleMessenger.updateSwapAreaHeight(damagePanel.y - (this.playersPanel.y + this.playersPanel.height) + MESSANGER_SWAP_AREA_TOP_OFFSET);
         if(this.battleNotifier)
         {
            this.battleNotifier.updateStage(param1,param2);
            this.setChildIndex(this.battleNotifier,this.getChildIndex(this.radialMenu) - 1);
         }
         if(this._hitTestFix)
         {
            this._hitTestFix.width = param1;
            this._hitTestFix.height = param2;
         }
         this.updateHintPanelPosition();
         this.vehicleSelection.updateStageSize(param1,param2);
         this.supplyPanel.x = _loc3_;
         this.supplyPanel.allySupplyDistFromScreenCenter = this.fragCorrelationBar.getAllyMarkersStartPosition() + this.fragCorrelationBar.getAllyMarkersTotalWidth();
         this.supplyPanel.enemySupplyDistFromScreenCenter = this.fragCorrelationBar.getEnemyMarkersStartPosition() + this.fragCorrelationBar.getEnemyMarkersTotalWidth();
         this.supplyPanel.updateStage(param1,param2);
         this.vehiclesPanel.setStageWidth(param1);
         this.vehiclesPanel.y = _originalHeight;
         this.vehiclesPanelUpdateLimit();
         this.eventMessage.updateStage(param1,param2);
         this.commanderHelp.y = _originalHeight - this.commanderHelp.height - COMMANDER_HELP_BOTTOM_OFFSET;
         this.updateSpawnMenuPosition();
      }
      
      override protected function configUI() : void
      {
         this.teamBasesPanelUI.addEventListener(Event.CHANGE,this.onTeamBasesPanelUIChangeHandler);
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
         this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.playersPanel.addEventListener(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE,this.onPlayersPanelOnItemsCountChangeHandler);
         this.playersPanel.addEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onPlayersPanelStateRequestedHandler);
         this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         this.vehicleSelection.addEventListener(RTSVehicleSelectionEvent.VEHICLE_SELECTION_VISIBILITY_CHANGE,this.onVehicleSelectionVisibilityChangedHandler);
         super.configUI();
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.spawnMenu,BATTLE_VIEW_ALIASES.COMMANDER_SPAWN_MENU);
         registerComponent(this.supplyPanel,BATTLE_VIEW_ALIASES.COMMANDER_SUPPLY_PANEL);
         registerComponent(this.vehicleSelection,BATTLE_VIEW_ALIASES.COMMANDER_VEHICLE_SELECTION);
         registerComponent(this.commanderHelp,BATTLE_VIEW_ALIASES.COMMANDER_HELP);
         registerComponent(this.vehiclesPanel,BATTLE_VIEW_ALIASES.COMMANDER_VEHICLES_PANEL);
         registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
         registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
         registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
         registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
         registerComponent(this.fullStats,BATTLE_VIEW_ALIASES.FULL_STATS);
         registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
         registerComponent(this.playersPanel,BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
         registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
         registerComponent(this.fragCorrelationBar,BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR);
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         registerComponent(this.destroyTimersPanel,BATTLE_VIEW_ALIASES.TIMERS_PANEL);
         registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
         registerComponent(this.endWarningPanel,BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL);
         registerComponent(this.siegeModePanel,BATTLE_VIEW_ALIASES.SIEGE_MODE_INDICATOR);
         registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
         this.registerSpecificComponents();
         if(this.battleNotifier)
         {
            registerComponent(this.battleNotifier,BATTLE_VIEW_ALIASES.BATTLE_NOTIFIER);
         }
         super.onPopulate();
         questProgressTopAnimContainer.visible = false;
         questProgressTopView.visible = false;
         this.endWarningPanel.mouseEnabled = false;
         this.endWarningPanel.mouseChildren = false;
         battleTimer.mouseEnabled = false;
         battleTimer.mouseChildren = false;
         this.spawnMenu.addEventListener(Event.RESIZE,this.onSpawnMenuResizeHandler);
      }
      
      override protected function onRegisterStatisticController() : void
      {
         registerFlashComponentS(battleStatisticDataController,BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
      }
      
      override protected function onDispose() : void
      {
         this.vehicleSelection.removeEventListener(RTSVehicleSelectionEvent.VEHICLE_SELECTION_VISIBILITY_CHANGE,this.onVehicleSelectionVisibilityChangedHandler);
         this.spawnMenu.removeEventListener(Event.RESIZE,this.onSpawnMenuResizeHandler);
         this.spawnMenu = null;
         this.supplyPanel = null;
         this.vehicleSelection = null;
         this.commanderHelp = null;
         this.vehiclesPanel = null;
         this.eventMessage = null;
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.playersPanel.removeEventListener(Event.CHANGE,this.onPlayersPanelChangeHandler);
         this.playersPanel.removeEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onPlayersPanelStateRequestedHandler);
         this.teamBasesPanelUI.removeEventListener(Event.CHANGE,this.onTeamBasesPanelUIChangeHandler);
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
         this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.battleMessenger = null;
         this.endWarningPanel.removeEventListener(EndWarningPanelEvent.VISIBILITY_CHANGED,this.onEndWarningPanelVisibilityChangedHandler);
         this.hintPanel.removeEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         this.hintPanel = null;
         this.debugPanel = null;
         this.teamBasesPanelUI = null;
         this.sixthSense = null;
         this.damageInfoPanel = null;
         this.fragCorrelationBar = null;
         this.fullStats = null;
         this._hitTestFix = null;
         this.playersPanel.removeEventListener(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE,this.onPlayersPanelOnItemsCountChangeHandler);
         this.playersPanel = null;
         this.consumablesPanel = null;
         this.destroyTimersPanel = null;
         this.radialMenu = null;
         this.endWarningPanel = null;
         this.battleDamageLogPanel = null;
         this.siegeModePanel = null;
         this.battleNotifier = null;
         super.onDispose();
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new RTSBattleStatisticDataController();
      }
      
      override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
         param1.registerComponentController(this.vehiclesPanel);
         param1.registerComponentController(battleLoading);
         param1.registerComponentController(this.fragCorrelationBar);
         param1.registerComponentController(this.fullStats);
         param1.registerComponentController(this.playersPanel);
         var _loc2_:RTSBattleStatisticDataController = RTSBattleStatisticDataController(param1);
         _loc2_.setDisplayObjectContainer(this);
         _loc2_.registerRTSComponentController(this);
         _loc2_.registerRTSComponentController(this.playersPanel);
         _loc2_.registerRTSComponentController(this.supplyPanel);
         _loc2_.registerRTSComponentController(this.vehiclesPanel);
         _loc2_.registerRTSComponentController(this.fullStats);
         super.initializeStatisticsController(param1);
      }
      
      override protected function getFullStatsTabQuestProgress() : IQuestProgressView
      {
         return null;
      }
      
      override protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
      {
         super.onComponentVisibilityChanged(param1,param2);
         if(param1 == BATTLE_VIEW_ALIASES.MINIMAP)
         {
            this.vehiclesPanelUpdateLimit();
         }
         else if(param1 == BATTLE_VIEW_ALIASES.COMMANDER_SPAWN_MENU)
         {
            this.updateSpawnMenuPosition();
            if(this.spawnMenu.isCompVisible())
            {
               prebattleTimer.hideBackground();
               prebattleTimer.hideDescription();
            }
            else
            {
               prebattleTimer.showBackground();
               prebattleTimer.showDescription();
            }
            this.updatePrebattleTimerPos();
         }
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Number = App.appWidth - this.vehiclesPanel.getVehiclesContainerWidth(false);
         if(this._isCommanderMode)
         {
            _loc2_ = this.vehiclesPanel.calcContainerX() > BATTLE_DAMAGE_LOG_WIDTH ? Number(_loc2_ - this.battleDamageLogPanel.width) : Number(_loc2_);
         }
         while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
         {
            _loc4_ = minimap.getMinimapRectBySizeIndex(param1);
            if(_loc2_ - _loc4_.width >= 0)
            {
               break;
            }
            param1--;
         }
         var _loc3_:Number = App.appHeight - this.playersPanel.panelHeight - MINIMAP_MARGIN_HEIGHT;
         _loc2_ = App.appWidth - this.consumablesPanel.panelWidth - MINIMAP_MARGIN_WIDTH;
         while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
         {
            _loc4_ = minimap.getMinimapRectBySizeIndex(param1);
            if(_loc3_ - _loc4_.height >= 0 && _loc2_ - _loc4_.width >= 0)
            {
               break;
            }
            param1--;
         }
         return param1;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_PLAYERS_PANEL_STATE))
         {
            this.updateDamageLogPosition();
         }
         if(!isInvalid(RTS_INVALID_PLAYERS_PANEL_STATE))
         {
         }
      }
      
      public function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
      }
      
      public function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
      }
      
      public function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
      }
      
      public function setRTSCommanderMode(param1:Boolean) : void
      {
         this._isCommanderMode = param1;
         this.updateStage(_width,_height);
      }
      
      public function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
      }
      
      public function setRTSIsSpotted(param1:Number, param2:Boolean) : void
      {
      }
      
      public function setRTSPlayerCommander(param1:Boolean) : void
      {
      }
      
      public function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
      }
      
      public function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
      }
      
      public function setRTSVehicleGroup(param1:int, param2:int) : void
      {
      }
      
      public function setRTSVehicleInFocus(param1:int) : void
      {
      }
      
      public function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
      }
      
      public function setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
      }
      
      override protected function playerMessageListPositionUpdate() : void
      {
         if(minimap.visible)
         {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_originalHeight - minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y);
         }
         else
         {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,this.battleMessenger.y);
         }
      }
      
      override protected function updateBattleDamageLogPosInPostmortem() : void
      {
         var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT - 1;
         var _loc2_:int = postmortemTips.x - (postmortemTips.width >> 1);
         if(this.battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH >= _loc2_)
         {
            _loc1_ = BattleDamageLogConstants.MIN_VIEW_RENDERER_COUNT_IN_POSTMORTEM;
         }
         this.battleDamageLogPanel.setDetailActionCount(_loc1_);
      }
      
      override protected function onPrebattleAmmunitionPanelShown() : void
      {
         super.onPrebattleAmmunitionPanelShown();
         this.updateConsumablePanel();
         this.updateHintPanelPosition();
      }
      
      override protected function onPrebattleAmmunitionPanelHidden(param1:Boolean) : void
      {
         super.onPrebattleAmmunitionPanelHidden(false);
         this.updateConsumablePanel(param1);
      }
      
      protected function registerSpecificComponents() : void
      {
         registerComponent(this.teamBasesPanelUI,BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
      }
      
      protected function updateHintPanelPosition() : void
      {
         this.hintPanel.x = _originalWidth - this.hintPanel.width >> 1;
         this.hintPanel.y = HINT_PANEL_Y_SHIFT_MULTIPLIER * (_originalHeight - this.hintPanel.height >> 1) ^ 0;
         if(prebattleAmmunitionPanelShown)
         {
            this.hintPanel.y += HINT_PANEL_AMMUNITION_OFFSET_Y;
         }
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
      
      private function updatePositionForQuestProgress() : void
      {
         this.endWarningPanel.y = WARNING_PANEL_TOP_SHIFT;
         if(isQuestProgress)
         {
            updatePositionQuestProgressTop(WARNING_PANEL_TOP_SHIFT + QUEST_PROGRESS_TOP_SHIFT + this.endWarningPanel.panelHeight);
         }
      }
      
      private function checkZIndexes(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         return this.getChildIndex(param1) > this.getChildIndex(param2);
      }
      
      private function updateBattleDamageLogPanelPosition() : void
      {
         var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT;
         if(this.battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH >= this.consumablesPanel.x)
         {
            _loc1_ = BattleDamageLogConstants.MIN_VIEW_RENDER_COUNT;
         }
         this.battleDamageLogPanel.setDetailActionCount(_loc1_);
         this.battleDamageLogPanel.updateTopContainerPosition(TOP_CONTAINER_OFFSET);
      }
      
      private function swapElementsByMouseInteraction(param1:DisplayObject, param2:DisplayObject) : void
      {
         if(!App.contextMenuMgr.isShown() && this.checkZIndexes(param1,param2))
         {
            this.swapChildren(param1,param2);
         }
      }
      
      override protected function get prebattleAmmunitionPanelAvailable() : Boolean
      {
         return true;
      }
      
      private function onHintPanelResizeHandler(param1:Event) : void
      {
         this.updateHintPanelPosition();
      }
      
      private function onEndWarningPanelVisibilityChangedHandler(param1:EndWarningPanelEvent) : void
      {
         this.updatePositionForQuestProgress();
      }
      
      private function onTeamBasesPanelUIChangeHandler(param1:Event) : void
      {
         this.updatePositionForQuestProgress();
      }
      
      private function onPlayersPanelStateRequestedHandler(param1:PlayersPanelSwitchEvent) : void
      {
         this._playersPanelState = param1.state;
         this._playersPanelHasInvite = this.playersPanel.isInviteReceived;
         invalidate(INVALID_PLAYERS_PANEL_STATE);
      }
      
      private function onBattleMessengerRollOutHandler(param1:MouseEvent) : void
      {
         if(!this.battleMessenger.isEnterButtonPressed)
         {
            this.swapElementsByMouseInteraction(this.battleMessenger,this.playersPanel);
         }
      }
      
      private function onBattleMessengerRollOverHandler(param1:MouseEvent) : void
      {
         this.swapElementsByMouseInteraction(this.playersPanel,this.battleMessenger);
      }
      
      private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
         if(this.battleMessenger.isEnterButtonPressed)
         {
            this.swapElementsByMouseInteraction(this.playersPanel,this.battleMessenger);
         }
         else
         {
            this.swapElementsByMouseInteraction(this.battleMessenger,this.playersPanel);
         }
      }
      
      private function onPlayersPanelChangeHandler(param1:Event) : void
      {
         this.battleMessenger.updateSwapAreaHeight(damagePanel.y - (this.playersPanel.y + this.playersPanel.height) + MESSANGER_SWAP_AREA_TOP_OFFSET);
         if(this._isPlayersPanelIsEmpty || this._playersPanelHasInvite != this.playersPanel.isInviteReceived)
         {
            this._isPlayersPanelIsEmpty = false;
            this._playersPanelState = this.playersPanel.state;
            this._playersPanelHasInvite = this.playersPanel.isInviteReceived;
            invalidate(INVALID_PLAYERS_PANEL_STATE);
         }
      }
      
      private function onBattleMessengerRemoveFocusHandler(param1:Event) : void
      {
         setFocus(this);
         this.swapElementsByMouseInteraction(this.playersPanel,this.battleMessenger);
      }
      
      private function onPlayersPanelOnItemsCountChangeHandler(param1:PlayersPanelEvent) : void
      {
         minimap.updateSizeIndex(false);
      }
      
      private function onConsumablesPanelUpdatePositionHandler(param1:ConsumablesPanelEvent) : void
      {
         if(isPostMortem)
         {
            this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
            this.updateBattleDamageLogPosInPostmortem();
         }
         else
         {
            this.updateBattleDamageLogPanelPosition();
         }
         minimap.updateSizeIndex(false);
      }
      
      private function onConsumablesPanelSwitchPopupHandler(param1:ConsumablesPanelEvent) : void
      {
         var _loc2_:int = 0;
         if(!postmortemTips || !postmortemTips.visible)
         {
            _loc2_ = !!this.consumablesPanel.isExpand ? int(CONSUMABLES_POPUP_OFFSET) : int(0);
            vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET.y - _loc2_ | 0);
         }
      }
      
      private function onVehicleSelectionVisibilityChangedHandler(param1:RTSVehicleSelectionEvent) : void
      {
         this.vehiclesPanel.setAllowVehicleSelection(!param1.isSelectionActive);
      }
      
      private function updateDamageLogPosition() : void
      {
         if(this._isCommanderMode)
         {
            this.battleDamageLogPanel.x = 0;
            if(this.vehiclesPanel.calcContainerX() < BATTLE_DAMAGE_LOG_WIDTH)
            {
               this.battleDamageLogPanel.y = this.vehiclesPanel.y - this.vehiclesPanel.height + COMMANDER_BATTLE_LOG_OFFSET_NARROW_SCREEN;
            }
            else
            {
               this.battleDamageLogPanel.y = _originalHeight - this.battleDamageLogPanel.height + COMMANDER_BATTLE_LOG_OFFSET_WIDE_SCREEN;
            }
         }
      }
      
      private function updateSpawnMenuPosition() : void
      {
         this.spawnMenu.updateStageSize(_originalWidth,_originalHeight);
         this.spawnMenu.x = _originalWidth >> 1;
      }
      
      private function updatePrebattleTimerPos() : void
      {
         prebattleTimer.y = !!this.spawnMenu.isCompVisible() ? Number(this.spawnMenu.prebattleTimerY) : Number(0);
      }
      
      private function vehiclesPanelUpdateLimit() : void
      {
         this.vehiclesPanel.setBackgroundWidth(this.getVehiclesPanelWidthLimit());
         this.commanderHelp.x = this.vehiclesPanel.calcContainerX() + (this.vehiclesPanel.getVehiclesContainerWidth() >> 1);
         this.updateDamageLogPosition();
      }
      
      private function getVehiclesPanelWidthLimit() : Number
      {
         var _loc1_:Number = _originalWidth;
         if(minimap.visible)
         {
            _loc1_ = minimap.x + minimap.currentTopLeftPoint.x - MINIMAP_OFFSET;
         }
         return _loc1_ - this.vehiclesPanel.x;
      }
      
      override protected function onMiniMapChangeHandler(param1:MinimapEvent) : void
      {
         super.onMiniMapChangeHandler(param1);
         this.vehiclesPanelUpdateLimit();
      }
      
      private function onSpawnMenuResizeHandler(param1:Event = null) : void
      {
         this.updatePrebattleTimerPos();
      }
      
      public function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSVehicleModuleDamaged(param1:int, param2:String) : void
      {
      }
      
      public function setRTSVehicleModuleRepaired(param1:int, param2:String) : void
      {
      }
      
      public function setRTSCondition(param1:Number, param2:String) : void
      {
      }
   }
}
