package net.wg.gui.battle.battleRoyale
{
   import com.gskinner.motion.GTweener;
   import com.gskinner.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.battleRoyale.ub.UnboundContainer;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyalePostmortemPanel;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleScoreBar;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleTeamPanel;
   import net.wg.gui.battle.battleRoyale.views.BattleRoyaleWinnerCongrats;
   import net.wg.gui.battle.battleRoyale.views.components.CorrodingShotIndicator;
   import net.wg.gui.battle.battleRoyale.views.components.DamageScreen;
   import net.wg.gui.battle.battleRoyale.views.components.fullStats.BattleRoyaleFullStats;
   import net.wg.gui.battle.battleRoyale.views.components.respawnMessages.RespawnMessagePanel;
   import net.wg.gui.battle.battleRoyale.views.components.timersPanel.BattleRoyaleTimersPanel;
   import net.wg.gui.battle.battleRoyale.views.playerStats.BattleRoyalePlayerStats;
   import net.wg.gui.battle.battleRoyale.views.playersPanel.BattleRoyalePlayersPanel;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
   import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
   import net.wg.gui.battle.views.battleLevelPanel.BattleLevelPanel;
   import net.wg.gui.battle.views.battleMessenger.BattleMessage;
   import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
   import net.wg.gui.battle.views.debugPanel.DebugPanel;
   import net.wg.gui.battle.views.minimap.EpicMinimap;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBase;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.gui.battle.views.siegeModePanel.SiegeModePanel;
   import net.wg.gui.battle.views.sixthSense.SixthSense;
   import net.wg.gui.battle.views.upgradePanel.BattleUpgradePanel;
   import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.hintPanel.HintPanel;
   import net.wg.infrastructure.base.meta.IBattleRoyalePageMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyalePageMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.events.ComponentEvent;
   
   public class BattleRoyalePage extends BattleRoyalePageMeta implements IBattleRoyalePageMeta
   {
      
      private static const SCREEN_SMALL_WIDTH:int = 1480;
      
      private static const SCREEN_SMALL_HEIGHT:int = 900;
      
      private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;
      
      private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;
      
      private static const HINT_PANEL_Y_OFFSET:int = 270;
      
      private static const RADAR_BUTTON_H_GAP:int = -70;
      
      private static const RADAR_BUTTON_V_GAP:int = -13;
      
      private static const MINIMAP_TAB_MODE_BIG_OFFSET_Y:int = 85;
      
      private static const MINIMAP_TAB_MODE_SMALL_OFFSET_Y:int = 50;
      
      private static const GRID_BIG_OFFSET:Point = new Point(-24,-25);
      
      private static const GRID_SMALL_OFFSET:Point = new Point(-18,-15);
      
      private static const MESSANGER_SWAP_AREA_TOP_OFFSET:int = -27;
      
      private static const MESSENGER_RESPAWN_X_OFFSET:int = 36;
      
      private static const MESSENGER_RESPAWN_Y_OFFSET:int = 30;
      
      private static const RESPAWN_MAP_HALF_WIDTH:int = 327;
      
      private static const BATTLE_DAMAGE_LOG_MIN_RENDERER_COUNT:int = 3;
      
      private static const MAX_DAMAGE_LOG_VIEW_WIDTH:int = 240;
      
      private static const MINIMAP_SMALL_SCREEN_OFFSET_X:uint = 20;
      
      private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 200;
      
      private static const TIMER_OFFSET_Y:int = 20;
      
      private static const RIBBONS_STAGE_HEIGHT_SMALL:int = 900;
      
      private static const MESSAGE_STAGE_HEIGHT_SMALL:int = 1000;
      
      private static const UPGRADE_PANEL_MESSAGE_OFFSET:int = 230;
      
      private static const PLAYER_STATS_MIN_HEIGHT_Y:int = 155;
      
      private static const PLAYER_STATS_Y:int = 175;
      
      private static const MESSANGER_SWAP_AREA_MIN_HEIGHT:int = 220;
      
      private static const TIMERS_PANEL_Y_OFFSET:Vector.<int> = new <int>[50,50,51,51,52,52,52];
      
      private static const PLAYER_MESSAGES_LIST_OFFSET_Y:int = -46;
      
      private static const RADIAL_MENU_TWEEN_DURATION:Number = 0.25;
      
      private static const RADIAL_MENU_ALPHA_NORMAL:int = 1;
      
      private static const RADIAL_MENU_ALPHA_HIDDEN:Number = 0.15;
      
      private static const POSTMORTEM_LAYER_NAME:String = "postmortemPanelUI";
       
      
      public var fragPanel:BattleRoyaleScoreBar = null;
      
      public var levelPanel:BattleLevelPanel = null;
      
      public var radarButton:RadarButton = null;
      
      public var upgradePanel:BattleUpgradePanel = null;
      
      public var teamPanel:BattleRoyaleTeamPanel = null;
      
      public var battleMessenger:BattleMessenger = null;
      
      public var debugPanel:DebugPanel = null;
      
      public var battleDamageLogPanel:BattleDamageLogPanel = null;
      
      public var sixthSense:SixthSense = null;
      
      public var consumablesPanel:ConsumablesPanel = null;
      
      public var eventMessage:EventBattleHint = null;
      
      public var statusNotificationsPanel:StatusNotificationsPanel = null;
      
      public var hintPanel:HintPanel = null;
      
      public var damageInfoPanel:DamageInfoPanel = null;
      
      public var radialMenu:RadialMenu = null;
      
      public var endWarningPanel:BattleEndWarningPanel = null;
      
      public var siegeModePanel:SiegeModePanel = null;
      
      public var fullStats:BattleRoyaleFullStats = null;
      
      public var grid:BattleAtlasSprite = null;
      
      public var damageScreen:DamageScreen = null;
      
      public var playerStats:BattleRoyalePlayerStats = null;
      
      public var playersPanel:BattleRoyalePlayersPanel = null;
      
      public var corrodingShotIndicator:CorrodingShotIndicator = null;
      
      public var respawnMessagePanel:RespawnMessagePanel = null;
      
      public var timersPanel:BattleRoyaleTimersPanel = null;
      
      public var winnerCongrats:BattleRoyaleWinnerCongrats = null;
      
      private var _selectRespawn:UnboundContainer = null;
      
      private var _minimap:EpicMinimap = null;
      
      private var _atlasHolder:Object;
      
      private var _respawnVisible:Boolean = true;
      
      public function BattleRoyalePage()
      {
         this._atlasHolder = {};
         super();
      }
      
      public static function isSmallScreenSize(param1:Number, param2:Number) : Boolean
      {
         return param1 <= SCREEN_SMALL_WIDTH || param2 <= SCREEN_SMALL_HEIGHT;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         var _loc3_:Number = param1 >> 1;
         this.sixthSense.x = _loc3_;
         this.sixthSense.y = param2 >> 2;
         this.upgradePanel.x = _loc3_;
         this.levelPanel.x = _loc3_;
         var _loc4_:Number = stage.scaleY;
         this.damageInfoPanel.y = (param2 >> 1) / _loc4_ + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * _loc4_ | 0;
         this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
         prebattleTimer.y = TIMER_OFFSET_Y;
         PrebattleTimerBase(prebattleTimer).background.y = -TIMER_OFFSET_Y;
         this.updateBattleMessengerPosition();
         this.fragPanel.x = _loc3_;
         this.respawnMessagePanel.x = param1 - this.respawnMessagePanel.width >> 1;
         this.statusNotificationsPanel.updateStage(param1,param2);
         this.consumablesPanel.updateStage(param1,param2);
         this.eventMessage.updateStage(param1,param2);
         this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
         this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING;
         this.battleDamageLogPanel.updateSize(param1,param2);
         this.radialMenu.updateStage(param1,param2);
         this.endWarningPanel.x = _loc3_;
         this.fullStats.x = _loc3_;
         this.fullStats.updateStage(param1,param2);
         this.playerStats.x = _loc3_;
         this.playerStats.y = param2 <= StageSizeBoundaries.HEIGHT_800 ? Number(PLAYER_STATS_MIN_HEIGHT_Y) : Number(PLAYER_STATS_Y);
         this.timersPanel.x = param1 - this.timersPanel.width;
         this.winnerCongrats.updateStage(param1,param2);
         this.updateHintPanelPosition();
         this.updateRadarBtnPosition();
         if(this._respawnVisible)
         {
            this.updateFreeWidthForMessengerInRespawn();
         }
         this.damageScreen.updateStage(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.upgradePanel.addEventListener(ComponentEvent.STATE_CHANGE,this.onUpgradePanelStateChangeHandler);
         this._minimap.isTabModeCustomAlpha = true;
         this._minimap.tabModeCustomAlpha = Values.DEFAULT_ALPHA;
         this.radialMenu.setIsShadeVisible(true);
         this.radialMenu.addEventListener(Event.ACTIVATE,this.onRedialMenuActivateHandler);
         this.radialMenu.addEventListener(Event.DEACTIVATE,this.onRedialMenuDeactivateHandler);
      }
      
      override protected function createPostmortemPanelComponent() : void
      {
         if(postmortemPanelUI == null)
         {
            postmortemPanelUI = App.utils.classFactory.getComponent(Linkages.BATTLE_ROYALE_POSTMORTEM_PANEL,BattleRoyalePostmortemPanel);
         }
         postmortemPanelUI.setCompVisible(false);
         postmortemPanelUI.name = POSTMORTEM_LAYER_NAME;
         addChild(postmortemPanelUI);
         super.createPostmortemPanelComponent();
      }
      
      override protected function createSpectatorViewComponent() : void
      {
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new BattleStatisticDataController(this);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.atlasMgr.registerAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._atlasHolder);
         this.levelPanel.useAnimatedTransitions = true;
         this.levelPanel.useSmallFont();
         this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
         this.fullStats.addEventListener(Event.OPEN,this.onFullStatsOpenHandler);
         this.fullStats.addEventListener(Event.CLOSE,this.onFullStatsCloseHandler);
         this._minimap = EpicMinimap(minimap);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         this.grid.visible = false;
         this._selectRespawn = new UnboundContainer();
         addChildAt(this._selectRespawn,0);
         this.playerStats.setCompVisible(false);
      }
      
      override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
         param1.registerComponentController(battleLoading);
         param1.registerComponentController(this.teamPanel);
         super.initializeStatisticsController(param1);
      }
      
      override protected function onRegisterStatisticController() : void
      {
         registerFlashComponentS(battleStatisticDataController,BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerComponent(this._selectRespawn,BATTLE_VIEW_ALIASES.BR_SELECT_RESPAWN);
         registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
         registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
         registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
         registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
         registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
         registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
         registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
         registerComponent(this.endWarningPanel,BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL);
         registerComponent(this.siegeModePanel,BATTLE_VIEW_ALIASES.SIEGE_MODE_INDICATOR);
         registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
         registerComponent(this.levelPanel,BATTLE_VIEW_ALIASES.BATTLE_LEVEL_PANEL);
         registerComponent(this.teamPanel,BATTLE_VIEW_ALIASES.BATTLE_TEAM_PANEL);
         registerComponent(this.radarButton,BATTLE_VIEW_ALIASES.RADAR_BUTTON);
         registerComponent(this.upgradePanel,BATTLE_VIEW_ALIASES.UPGRADE_PANEL);
         registerComponent(this.fragPanel,BATTLE_VIEW_ALIASES.FRAG_PANEL);
         registerComponent(this.fullStats,BATTLE_VIEW_ALIASES.FULL_STATS);
         registerComponent(this.playerStats,BATTLE_VIEW_ALIASES.BR_PLAYER_STATS_IN_BATTLE);
         registerComponent(this.playersPanel,BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
         registerComponent(this.respawnMessagePanel,BATTLE_VIEW_ALIASES.BR_RESPAWN_MESSAGE_PANEL);
         registerComponent(this.corrodingShotIndicator,BATTLE_VIEW_ALIASES.CORRODING_SHOT_INDICATOR);
         registerComponent(this.timersPanel,BATTLE_VIEW_ALIASES.BR_TIMERS_PANEL);
         registerComponent(this.winnerCongrats,BATTLE_VIEW_ALIASES.BATTLE_ROYALE_WINNER_CONGRATS);
         setChildIndex(postmortemPanelUI,getChildIndex(this.consumablesPanel) - 1);
         this._minimap.mapShortcutLabel.visible = false;
      }
      
      override protected function onBeforeDispose() : void
      {
         GTweener.removeTweens(this.respawnMessagePanel);
         GTweener.removeTweens(this.upgradePanel);
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.upgradePanel.removeEventListener(ComponentEvent.STATE_CHANGE,this.onUpgradePanelStateChangeHandler);
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.hintPanel.removeEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         this.fullStats.removeEventListener(Event.OPEN,this.onFullStatsOpenHandler);
         this.fullStats.removeEventListener(Event.CLOSE,this.onFullStatsCloseHandler);
         this.radialMenu.removeEventListener(Event.ACTIVATE,this.onRedialMenuActivateHandler);
         this.radialMenu.removeEventListener(Event.DEACTIVATE,this.onRedialMenuDeactivateHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         App.atlasMgr.unregisterAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._atlasHolder);
         this._atlasHolder = null;
         this.damageScreen.dispose();
         this.damageScreen = null;
         this.fragPanel = null;
         this.levelPanel = null;
         this.teamPanel = null;
         this.battleMessenger = null;
         this.debugPanel = null;
         this.battleDamageLogPanel = null;
         this.sixthSense = null;
         this.consumablesPanel = null;
         this.statusNotificationsPanel = null;
         this.damageInfoPanel = null;
         this.radialMenu = null;
         this.endWarningPanel = null;
         this.siegeModePanel = null;
         this.respawnMessagePanel = null;
         this._selectRespawn = null;
         this.playerStats = null;
         this.playersPanel = null;
         this.corrodingShotIndicator = null;
         this.timersPanel = null;
         this.winnerCongrats = null;
         this.hintPanel = null;
         this.fullStats = null;
         this._minimap = null;
         this.radarButton = null;
         this.upgradePanel = null;
         this.grid = null;
         super.onDispose();
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(this._minimap.isTabMode)
         {
            _loc5_ = isSmallScreenSize(_width,_height);
            return int(!!_loc5_ ? int(EpicMinimap.TAB_MODE_502_IDX) : int(EpicMinimap.TAB_MODE_700_IDX));
         }
         var _loc2_:Number = App.appHeight >> 1;
         var _loc3_:Number = App.appWidth - this.consumablesPanel.panelWidth | 0;
         var _loc4_:Rectangle = null;
         while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
         {
            _loc4_ = minimap.getMinimapRectBySizeIndex(param1);
            if(_loc2_ - _loc4_.height >= 0 && _loc3_ - _loc4_.width >= 0)
            {
               break;
            }
            param1--;
         }
         return param1;
      }
      
      override protected function updateMinimapPosition() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc3_:Rectangle = null;
         var _loc4_:Point = null;
         if(this._minimap.isTabMode)
         {
            _loc1_ = isSmallScreenSize(_width,_height);
            _loc2_ = !!_loc1_ ? Number(MINIMAP_TAB_MODE_SMALL_OFFSET_Y) : Number(MINIMAP_TAB_MODE_BIG_OFFSET_Y);
            _loc3_ = this._minimap.getMinimapRectBySizeIndex(this._minimap.currentSizeIndex);
            this._minimap.x = (_width >> 1) - _loc3_.width;
            this._minimap.y = _loc2_ + (_height - _loc3_.height >> 1);
            this._minimap.dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
            this.fullStats.setMinimapBounds(_loc3_);
            if(_loc1_)
            {
               this._minimap.x += MINIMAP_SMALL_SCREEN_OFFSET_X;
               this.grid.imageName = BATTLEATLAS.MINIMAP_GRID_MINI;
               _loc4_ = GRID_SMALL_OFFSET;
            }
            else
            {
               this.grid.imageName = BATTLEATLAS.MINIMAP_GRID;
               _loc4_ = GRID_BIG_OFFSET;
            }
            this.grid.x = minimap.x + _loc4_.x;
            this.grid.y = minimap.y + _loc4_.y;
         }
         else
         {
            super.updateMinimapPosition();
            this.timersPanel.y = minimap.y - TIMERS_PANEL_Y_OFFSET[minimap.currentSizeIndex];
         }
      }
      
      override protected function initializeMessageLists() : void
      {
         super.initializeMessageLists();
         addChild(this.upgradePanel);
         swapChildren(battleLoading,this.upgradePanel);
         addChildAt(this.radialMenu,getChildIndex(this.upgradePanel));
      }
      
      override protected function playerMessageListPositionUpdate() : void
      {
         playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_originalHeight - minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET_Y);
      }
      
      override protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
      {
         super.onComponentVisibilityChanged(param1,param2);
         if(param1 == BATTLE_VIEW_ALIASES.BR_SELECT_RESPAWN)
         {
            this._respawnVisible = param2;
            this.updateBattleMessengerPosition();
            this.updateFreeWidthForMessengerInRespawn();
         }
      }
      
      override protected function getRibbonsCenterOffset(param1:Number) : int
      {
         if(param1 <= RIBBONS_STAGE_HEIGHT_SMALL)
         {
            return RIBBONS_CENTER_SCREEN_OFFSET_Y;
         }
         return super.getRibbonsCenterOffset(param1);
      }
      
      override protected function vehicleErrorMessageListPositionUpdate() : void
      {
         var _loc1_:Boolean = true;
         if(this.upgradePanel.isActive)
         {
            if(_originalHeight < MESSAGE_STAGE_HEIGHT_SMALL)
            {
               _loc1_ = false;
            }
            else
            {
               vehicleErrorMessageList.setLocation(_originalWidth - VEHICLE_ERRORS_LIST_OFFSET.x >> 1,this.upgradePanel.y + UPGRADE_PANEL_MESSAGE_OFFSET);
            }
         }
         else
         {
            super.vehicleErrorMessageListPositionUpdate();
         }
         this.updateVehicleErrorMessageListVisible(_loc1_);
      }
      
      override protected function anchorVictimDogTag() : void
      {
      }
      
      public function as_updateDamageScreen(param1:Boolean) : void
      {
         this.damageScreen.visible = param1;
         this.damageScreen.showSingleShineAnim();
         this.statusNotificationsPanel.notifyZoneDamage();
      }
      
      private function updateVehicleErrorMessageListVisible(param1:Boolean) : void
      {
         if(vehicleErrorMessageList.visible != param1)
         {
            vehicleErrorMessageList.visible = param1;
         }
      }
      
      private function updateBattleMessengerPosition() : void
      {
         var _loc1_:int = this.teamPanel.y + this.teamPanel.height;
         if(this._respawnVisible)
         {
            this.battleMessenger.x = damagePanel.x + MESSENGER_RESPAWN_X_OFFSET;
            this.battleMessenger.y = _originalHeight - this.battleMessenger.height - MESSENGER_RESPAWN_Y_OFFSET;
            this.battleMessenger.isSmallState = true;
            this.battleMessenger.updateSwapAreaHeight(MESSANGER_SWAP_AREA_MIN_HEIGHT);
         }
         else
         {
            this.battleMessenger.x = damagePanel.x;
            this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSENGER_Y_OFFSET;
            this.battleMessenger.isSmallState = false;
            this.battleMessenger.updateSwapAreaHeight(damagePanel.y - _loc1_ + MESSANGER_SWAP_AREA_TOP_OFFSET);
         }
      }
      
      private function updateHintPanelPosition() : void
      {
         this.hintPanel.x = _width - this.hintPanel.width >> 1;
         this.hintPanel.y = _height - HINT_PANEL_Y_OFFSET;
      }
      
      private function updateRadarBtnPosition() : void
      {
         this.radarButton.x = _width - this._minimap.currentWidth + RADAR_BUTTON_H_GAP;
         this.radarButton.y = _height - this._minimap.currentHeight + RADAR_BUTTON_V_GAP;
      }
      
      private function swapElementsByMouseInteraction(param1:DisplayObject, param2:DisplayObject) : void
      {
         if(!App.contextMenuMgr.isShown() && this.checkZIndexes(param1,param2))
         {
            this.swapChildren(param1,param2);
         }
      }
      
      private function checkZIndexes(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         return this.getChildIndex(param1) > this.getChildIndex(param2);
      }
      
      private function updateBattleDamageLogPanelPosition() : void
      {
         var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT;
         var _loc2_:int = Math.max(MAX_DAMAGE_LOG_VIEW_WIDTH,this.battleDamageLogPanel.actualWidth);
         if(this.battleDamageLogPanel.x + _loc2_ >= this.consumablesPanel.x)
         {
            _loc1_ = BATTLE_DAMAGE_LOG_MIN_RENDERER_COUNT;
         }
         this.battleDamageLogPanel.setDetailActionCount(_loc1_);
      }
      
      private function updateFreeWidthForMessengerInRespawn() : void
      {
         var _loc1_:int = !!this._respawnVisible ? int((width >> 1) - RESPAWN_MAP_HALF_WIDTH) : int(BattleMessage.DEFAULT_TEXT_WIDTH);
         this.battleMessenger.setAvailableWidthForMessages(_loc1_);
      }
      
      override protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         this.updateMinimapPosition();
         if(!this._minimap.isTabMode)
         {
            this.playerMessageListPositionUpdate();
            this.updateRadarBtnPosition();
         }
      }
      
      private function onRedialMenuDeactivateHandler(param1:Event) : void
      {
         GTweener.removeTweens(this.respawnMessagePanel);
         GTweener.removeTweens(this.upgradePanel);
         GTweener.to(this.respawnMessagePanel,RADIAL_MENU_TWEEN_DURATION,{"alpha":RADIAL_MENU_ALPHA_NORMAL},{"ease":Cubic.easeOut});
         GTweener.to(this.upgradePanel,RADIAL_MENU_TWEEN_DURATION,{"alpha":RADIAL_MENU_ALPHA_NORMAL},{"ease":Cubic.easeOut});
         this.upgradePanel.setMouseEnabled(true);
         this.upgradePanel.setNotificationAnimationEnabled(true);
      }
      
      private function onRedialMenuActivateHandler(param1:Event) : void
      {
         GTweener.removeTweens(this.respawnMessagePanel);
         GTweener.removeTweens(this.upgradePanel);
         this.respawnMessagePanel.alpha = RADIAL_MENU_ALPHA_HIDDEN;
         this.upgradePanel.alpha = RADIAL_MENU_ALPHA_HIDDEN;
         this.upgradePanel.setMouseEnabled(false);
         this.upgradePanel.setNotificationAnimationEnabled(false);
      }
      
      private function onHintPanelResizeHandler(param1:Event) : void
      {
         this.updateHintPanelPosition();
      }
      
      private function onFullStatsCloseHandler(param1:Event) : void
      {
         this._minimap.restoreZoomMode();
         this._minimap.toggleTabMode(false);
         this.grid.visible = false;
      }
      
      private function onFullStatsOpenHandler(param1:Event) : void
      {
         this._minimap.toggleTabMode(true);
         this._minimap.setTabZoomMode();
         this.grid.visible = true;
      }
      
      private function onConsumablesPanelUpdatePositionHandler(param1:ConsumablesPanelEvent) : void
      {
         if(isPostMortem)
         {
            this.updateBattleDamageLogPanelPosition();
         }
         minimap.updateSizeIndex(false);
      }
      
      private function onBattleMessengerRollOutHandler(param1:MouseEvent) : void
      {
         if(!this.battleMessenger.isEnterButtonPressed)
         {
            this.swapElementsByMouseInteraction(this.battleMessenger,this.teamPanel);
         }
      }
      
      private function onBattleMessengerRollOverHandler(param1:MouseEvent) : void
      {
         this.swapElementsByMouseInteraction(this.teamPanel,this.battleMessenger);
      }
      
      private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
         if(this.battleMessenger.isEnterButtonPressed)
         {
            this.swapElementsByMouseInteraction(this.teamPanel,this.battleMessenger);
         }
         else
         {
            this.swapElementsByMouseInteraction(this.battleMessenger,this.teamPanel);
         }
      }
      
      private function onBattleMessengerRemoveFocusHandler(param1:Event) : void
      {
         setFocus(this);
         this.swapElementsByMouseInteraction(this.teamPanel,this.battleMessenger);
      }
      
      private function onUpgradePanelStateChangeHandler(param1:ComponentEvent) : void
      {
         this.vehicleErrorMessageListPositionUpdate();
      }
   }
}
