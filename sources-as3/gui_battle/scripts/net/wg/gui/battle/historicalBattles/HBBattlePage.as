package net.wg.gui.battle.historicalBattles
{
   import flash.geom.Rectangle;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.historicalBattles.battleHints.HBBattleHint;
   import net.wg.gui.battle.historicalBattles.minimap.HBFullMap;
   import net.wg.gui.battle.historicalBattles.phaseIndicator.HBPhaseIndicator;
   import net.wg.gui.battle.historicalBattles.playerLives.HBPlayerLives;
   import net.wg.gui.battle.historicalBattles.playersPanel.HBPlayersPanel;
   import net.wg.gui.battle.historicalBattles.playersPanel.events.HBPlayerListEvent;
   import net.wg.gui.battle.historicalBattles.roleNotification.HBRoleNotification;
   import net.wg.gui.battle.historicalBattles.stats.HBStatsWidget;
   import net.wg.gui.battle.historicalBattles.timer.HBTimer;
   import net.wg.gui.battle.random.views.BattlePage;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBase;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class HBBattlePage extends BattlePage
   {
      
      protected static const MINIMAP_MARGIN_HEIGHT:int = 6;
      
      private static const TOP_DETAILS_OFFSET_Y:int = 212;
      
      private static const POINT_COUNTER_HALFWIDTH:int = 64;
      
      private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;
      
      private static const PLAYER_MESSAGES_ADAPTIVE_MAX_WIDTH:int = 1200;
      
      private static const ADAPTIVE_PLAYER_MESSAGES_RIBBON_PANEL_OFFSET:int = -20;
      
      private static const PANEL_LIVES_OFFSET_Y:int = 50;
      
      private static const DAMAGE_PANEL_SPACING:int = 28;
       
      
      public var hbPlayersPanel:HBPlayersPanel = null;
      
      public var hintMessage:HBBattleHint = null;
      
      public var hintBaseMessage:HBBattleHint = null;
      
      public var timer:HBTimer = null;
      
      public var statsWidget:HBStatsWidget = null;
      
      public var statusNotificationsPanel:StatusNotificationsPanel = null;
      
      public var phaseIndicator:HBPhaseIndicator = null;
      
      public var fullMap:HBFullMap = null;
      
      public var playerLives:HBPlayerLives = null;
      
      public var roleNotification:HBRoleNotification = null;
      
      public function HBBattlePage()
      {
         super();
         this.fullMap.visible = false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         var _loc3_:uint = param1 >> 1;
         this.hintMessage.updateStage(param1,param2);
         this.hintBaseMessage.updateStage(param1,param2);
         this.statsWidget.setSize(param1,param2);
         this.statusNotificationsPanel.updateStage(param1,param2);
         this.fullMap.updateStagePosition(param1,param2);
         this.timer.x = _loc3_;
         this.timer.updateStage(param1,param2);
         this.phaseIndicator.x = _originalWidth;
         this.playerLives.y = damagePanel.y - PANEL_LIVES_OFFSET_Y;
         this.roleNotification.x = _loc3_;
         this.playerMessageListPositionUpdate();
      }
      
      override protected function createPostmortemTipsComponent() : void
      {
         if(postmortemTips == null)
         {
            postmortemTips = App.utils.classFactory.getComponent(Linkages.HBPOSTMORTEN_PANEL,PostmortemPanel);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         endWarningPanel.visible = false;
         PrebattleTimerBase(prebattleTimer).isNeedWinChangePosition = false;
         this.hbPlayersPanel.addEventListener(HBPlayerListEvent.SIZE_CHANGE,this.onHbPlayersPanelSizeChangeHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerComponent(this.hbPlayersPanel,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_PLAYERS_PANEL);
         registerComponent(this.hintMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
         registerComponent(this.hintBaseMessage,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_BASE_HINT);
         registerComponent(this.timer,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_TIMER);
         registerComponent(this.statsWidget,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_STATS_WIDGET);
         registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
         registerComponent(this.phaseIndicator,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_PHASE_INDICATOR);
         registerComponent(this.fullMap,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_FULL_MAP);
         registerComponent(this.playerLives,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_PLAYER_LIVES);
         registerComponent(this.roleNotification,BATTLE_VIEW_ALIASES.HISTORICAL_BATTLES_ROLE_NOTIFICATION);
         setChildIndex(postmortemTips,getChildIndex(this.fullMap) - 1);
      }
      
      override protected function onDispose() : void
      {
         this.hbPlayersPanel.removeEventListener(HBPlayerListEvent.SIZE_CHANGE,this.onHbPlayersPanelSizeChangeHandler);
         this.hbPlayersPanel = null;
         this.hintBaseMessage = null;
         this.hintMessage = null;
         this.timer = null;
         this.statsWidget = null;
         this.statusNotificationsPanel = null;
         this.phaseIndicator = null;
         this.fullMap = null;
         this.playerLives = null;
         this.roleNotification = null;
         super.onDispose();
      }
      
      override protected function playerMessageListPositionUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(minimap.visible)
         {
            _loc1_ = _originalHeight - minimap.getMessageCoordinate() + PLAYER_MESSAGES_LIST_OFFSET.y;
            _loc2_ = ribbonsPanel.y + ADAPTIVE_PLAYER_MESSAGES_RIBBON_PANEL_OFFSET;
            if(_originalWidth < PLAYER_MESSAGES_ADAPTIVE_MAX_WIDTH && _loc2_ < _loc1_)
            {
               _loc1_ = _loc2_;
            }
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_loc1_);
         }
         else
         {
            playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,battleMessenger.y);
         }
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc2_:Number = App.appWidth - consumablesPanel.panelWidth;
         var _loc3_:Rectangle = null;
         while(param1 > MinimapSizeConst.MIN_SIZE_INDEX)
         {
            _loc3_ = minimap.getMinimapRectBySizeIndex(param1);
            if(this.availableMinimapMaxHeight - _loc3_.height >= 0 && _loc2_ - _loc3_.width >= 0)
            {
               break;
            }
            param1--;
         }
         return param1;
      }
      
      override protected function getPlayersPanelBottom() : int
      {
         return this.hbPlayersPanel.y + this.hbPlayersPanel.height;
      }
      
      override protected function getFullStatsTabQuestProgress() : IQuestProgressView
      {
         return null;
      }
      
      override protected function getDamagePanelSpacing() : int
      {
         return DAMAGE_PANEL_SPACING;
      }
      
      override protected function getDamageLogPanelRightSpace() : int
      {
         return App.appWidth - consumablesPanel.panelWidth - (POINT_COUNTER_HALFWIDTH << 1);
      }
      
      override protected function onRegisterStatisticController() : void
      {
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return null;
      }
      
      override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
      }
      
      override protected function vehicleMessageListPositionUpdate() : void
      {
         if(postmortemTips && postmortemTips.visible)
         {
            super.vehicleMessageListPositionUpdate();
         }
         else
         {
            vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET_Y | 0);
         }
      }
      
      override protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      protected function get availableMinimapMaxHeight() : Number
      {
         return App.appHeight - MINIMAP_MARGIN_HEIGHT;
      }
      
      override protected function onMinimapSizeChangedHandler(param1:MinimapEvent) : void
      {
         super.onMinimapSizeChangedHandler(param1);
         updateMinimapPosition();
      }
      
      protected function onHbPlayersPanelSizeChangeHandler(param1:HBPlayerListEvent) : void
      {
         updateBattleMessengerSwapArea();
         battleDamageLogPanel.setTopDetailsOffsetY(this.getPlayersPanelBottom() + TOP_DETAILS_OFFSET_Y);
         battleDamageLogPanel.updateSize(_originalWidth,_originalHeight);
      }
   }
}
