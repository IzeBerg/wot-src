package net.wg.gui.battle.eventBattle.views
{
   import fl.motion.easing.Cubic;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.battleRoyale.views.components.DamageScreen;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
   import net.wg.gui.battle.eventBattle.views.battleHints.event.BattleHintEvent;
   import net.wg.gui.battle.eventBattle.views.bossHP.BossHPBar;
   import net.wg.gui.battle.eventBattle.views.bossIndicatorProgress.BossIndicatorEvent;
   import net.wg.gui.battle.eventBattle.views.bossIndicatorProgress.BossIndicatorProgress;
   import net.wg.gui.battle.eventBattle.views.buffsPanel.BuffsPanel;
   import net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem.EventBuffNotificationSystem;
   import net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem.ResizableBuffNotificationSystemEvent;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.EventPlayersPanel;
   import net.wg.gui.battle.eventBattle.views.eventPointCounter.EventPointCounter;
   import net.wg.gui.battle.eventBattle.views.eventStats.EventStats;
   import net.wg.gui.battle.eventBattle.views.eventTimer.EventTimer;
   import net.wg.gui.battle.eventBattle.views.eventTimer.EventTimerEvent;
   import net.wg.gui.battle.eventBattle.views.phaseIndicator.PhaseIndicator;
   import net.wg.gui.battle.views.destroyTimers.EventDestroyTimersPanel;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.minimap.events.MinimapEvent;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonCtrl;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.ribbon.data.PaddingSettings;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   import net.wg.infrastructure.base.meta.IEventBattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.EventBattlePageMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import scaleform.clik.motion.Tween;
   
   public class EventBattlePage extends EventBattlePageMeta implements IEventBattlePageMeta
   {
      
      private static const TOP_DETAILS_OFFSET_Y:Number = 510;
      
      private static const POINT_COUNTER_HALFWIDTH:int = 64;
      
      private static const POINT_COUNTER_HEIGHT:int = 60;
      
      private static const POINT_COUNTER_ADAPTIVE_OFFSET:int = 30;
      
      private static const MINIMAP_BORDER:int = 15;
      
      private static const BOSS_INDICATOR_PROGRESS_WIDTH:int = 406;
      
      private static const BOSS_INDICATOR_PROGRESS_HEIGHT:int = 34;
      
      private static const BOSS_INDICATOR_PROGRESS_HEIGHT_ALL:int = 45;
      
      private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;
      
      private static const PLAYER_MESSAGES_ADAPTIVE_MAX_WIDTH:int = 1200;
      
      private static const ADAPTIVE_PLAYER_MESSAGES_RIBBON_PANEL_OFFSET:int = -20;
      
      private static const BUFF_PANEL_OFFSET_Y:int = 240;
      
      private static const BOSS_HP_OFFSET_Y_SMALL:int = 74;
      
      private static const BOSS_HP_OFFSET_Y_BIG:int = 108;
      
      private static const HEIGHT_MIN:int = 810;
      
      private static const MIN_COUNT_RIBBONS:int = 2;
      
      private static const MAX_COUNT_RIBBONS:int = 3;
      
      private static const RIBBONS_PANEL_OFFSET_Y:int = 15;
      
      private static const PHASE_INDICATOR_TOP:int = 15;
      
      private static const PHASE_INDICATOR_RIGHT:int = 18;
      
      private static const BUFF_NOTIFICATION_SYSTEM_OFFSET:int = 20;
      
      private static const BUFF_TWEEN_TIME:int = 300;
       
      
      public var playersPanelEvent:EventPlayersPanel = null;
      
      public var eventMessage:EventBattleHint = null;
      
      public var eventPointCounter:EventPointCounter = null;
      
      public var bossIndicatorProgress:BossIndicatorProgress = null;
      
      public var bossHPBar:BossHPBar = null;
      
      public var eventTimer:EventTimer = null;
      
      public var eventStats:EventStats = null;
      
      public var eventDestroyTimersPanel:EventDestroyTimersPanel = null;
      
      public var buffsPanel:BuffsPanel = null;
      
      public var phaseIndicator:PhaseIndicator = null;
      
      public var eventBuffNotificationSystem:EventBuffNotificationSystem = null;
      
      public var damageScreen:DamageScreen = null;
      
      private var _buffTween:Tween = null;
      
      public function EventBattlePage()
      {
         super();
         this.bossIndicatorProgress.visible = false;
         battleTimer.visible = false;
         this.bossHPBar.visible = false;
         endWarningPanel.visible = false;
         this.bossIndicatorProgress.addEventListener(BossIndicatorEvent.INDICATOR_ENABLED,this.onBossProgressIndicatorEnabledHandler);
         this.eventTimer.addEventListener(EventTimerEvent.SIZE_CHANGED,this.onEventTimerSizeChangedHandler);
         battleDamageLogPanel.setTopDetailsOffsetY(TOP_DETAILS_OFFSET_Y);
         this.eventBuffNotificationSystem.addEventListener(ResizableBuffNotificationSystemEvent.CHANGED_WIDTH_EVENT,this.onChangedWidthBuffNotificationSystemHandler);
         this.eventTimer.addEventListener(ResizableBuffNotificationSystemEvent.CHANGED_TOP_EVENT,this.onChangedTopBuffNotificationSystemHandler);
         this.eventMessage.addEventListener(BattleHintEvent.HINT_CHANGED,this.hintChangedEventHandler);
      }
      
      public function as_updateDamageScreen(param1:Boolean) : void
      {
         this.damageScreen.visible = param1;
         if(param1)
         {
            this.damageScreen.showSingleShineAnim();
         }
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc4_:uint = 0;
         super.updateStage(param1,param2);
         var _loc3_:uint = param1 >> 1;
         _loc4_ = param2 >> 1;
         this.eventMessage.updateStage(param1,param2);
         this.eventStats.updateStageSize(param1,param2);
         this.eventDestroyTimersPanel.updateStage(param1,param2);
         this.eventStats.x = _loc3_;
         this.eventStats.y = _loc4_;
         this.eventTimer.x = _loc3_;
         this.bossHPBar.x = _loc3_;
         this.buffsPanel.x = _loc3_;
         this.buffsPanel.y = App.appHeight - BUFF_PANEL_OFFSET_Y;
         var _loc5_:int = param2 < HEIGHT_MIN ? int(MIN_COUNT_RIBBONS) : int(MAX_COUNT_RIBBONS);
         var _loc6_:int = this.buffsPanel.y - RibbonCtrl.ITEM_HEIGHT * _loc5_ - RIBBONS_PANEL_OFFSET_Y;
         if(ribbonsPanel.y > _loc6_)
         {
            ribbonsPanel.y = _loc6_;
         }
         ribbonsPanel.setFreeWorkingHeight(this.buffsPanel.y - ribbonsPanel.y);
         this.phaseIndicator.x = _originalWidth - PHASE_INDICATOR_RIGHT;
         this.phaseIndicator.y = PHASE_INDICATOR_TOP;
         this.setBossIndicatorProgressPosition();
         this.consumablesPanelPositionUpdated();
         this.playerMessageListPositionUpdate();
         this.setBuffNotificationSystemPositionX();
         this.setBuffNotificationSystemPositionY();
         this.damageScreen.updateStage(param1,param2);
      }
      
      override protected function setRibbonsPanelX() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PaddingSettings = RibbonSettings.getBuffsPaddings();
         if(_loc2_)
         {
            _loc1_ = _loc2_.ribbonOffset;
         }
         ribbonsPanel.x = (_originalWidth >> 1) + _loc1_;
      }
      
      override protected function consumablesPanelPositionUpdated() : void
      {
         this.eventPointCounter.x = App.appWidth - consumablesPanel.panelWidth - POINT_COUNTER_HALFWIDTH;
         this.eventPointCounter.y = App.appHeight - POINT_COUNTER_HEIGHT;
         if(battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH > this.eventPointCounter.x - POINT_COUNTER_HALFWIDTH)
         {
            this.eventPointCounter.y += POINT_COUNTER_ADAPTIVE_OFFSET;
         }
      }
      
      override protected function getDamageLogPanelRightSpace() : int
      {
         return App.appWidth - consumablesPanel.panelWidth - (POINT_COUNTER_HALFWIDTH << 1);
      }
      
      override protected function getPlayersPanelBottom() : int
      {
         return this.playersPanelEvent.y + this.playersPanelEvent.height;
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
      
      override protected function getBattleLoading() : BaseBattleLoading
      {
         return null;
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.playersPanelEvent,BATTLE_VIEW_ALIASES.PLAYERS_PANEL_EVENT);
         registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
         registerComponent(this.eventPointCounter,BATTLE_VIEW_ALIASES.EVENT_POINT_COUNTER);
         registerComponent(this.bossIndicatorProgress,BATTLE_VIEW_ALIASES.BOSS_INDICATOR_PROGRESS);
         registerComponent(this.bossHPBar,BATTLE_VIEW_ALIASES.BOSS_HPBAR);
         registerComponent(this.eventTimer,BATTLE_VIEW_ALIASES.EVENT_TIMER);
         registerComponent(this.eventStats,BATTLE_VIEW_ALIASES.EVENT_STATS);
         registerComponent(this.eventDestroyTimersPanel,BATTLE_VIEW_ALIASES.EVENT_DESTROY_TIMERS_PANEL);
         registerComponent(this.buffsPanel,BATTLE_VIEW_ALIASES.EVENT_BUFFS_PANEL);
         registerComponent(this.phaseIndicator,BATTLE_VIEW_ALIASES.EVENT_PHASE_INDICATOR);
         registerComponent(this.eventBuffNotificationSystem,BATTLE_VIEW_ALIASES.EVENT_BUFF_NOTIFICATION_SYSTEM);
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         this.eventBuffNotificationSystem.removeEventListener(ResizableBuffNotificationSystemEvent.CHANGED_WIDTH_EVENT,this.onChangedWidthBuffNotificationSystemHandler);
         this.eventTimer.removeEventListener(ResizableBuffNotificationSystemEvent.CHANGED_TOP_EVENT,this.onChangedTopBuffNotificationSystemHandler);
         this.bossIndicatorProgress.removeEventListener(BossIndicatorEvent.INDICATOR_ENABLED,this.onBossProgressIndicatorEnabledHandler);
         this.eventTimer.removeEventListener(EventTimerEvent.SIZE_CHANGED,this.onEventTimerSizeChangedHandler);
         this.eventMessage.removeEventListener(BattleHintEvent.HINT_CHANGED,this.hintChangedEventHandler);
         this.clearBuffTween();
         this.playersPanelEvent = null;
         this.eventMessage = null;
         this.eventPointCounter = null;
         this.bossIndicatorProgress = null;
         this.bossHPBar = null;
         this.eventTimer = null;
         this.eventStats = null;
         this.eventDestroyTimersPanel = null;
         this.buffsPanel = null;
         this.phaseIndicator = null;
         this.eventBuffNotificationSystem = null;
         this.damageScreen.dispose();
         this.damageScreen = null;
         super.onDispose();
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc2_:Number = App.appWidth - consumablesPanel.panelWidth;
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
      
      private function setBossIndicatorProgressPosition() : void
      {
         if(!this.bossIndicatorProgress.isEnabled)
         {
            return;
         }
         this.bossIndicatorProgress.x = minimap.x + minimap.currentTopLeftPoint.x - MINIMAP_BORDER;
         this.bossIndicatorProgress.width = App.appWidth - this.bossIndicatorProgress.x;
         var _loc1_:Number = (App.appWidth - this.bossIndicatorProgress.x) / BOSS_INDICATOR_PROGRESS_WIDTH;
         var _loc2_:Number = BOSS_INDICATOR_PROGRESS_HEIGHT * _loc1_;
         this.bossIndicatorProgress.y = minimap.y + minimap.currentTopLeftPoint.y - MINIMAP_BORDER - _loc2_;
         this.bossIndicatorProgress.height = BOSS_INDICATOR_PROGRESS_HEIGHT_ALL * _loc1_;
         minimap.messageCoordinateOffset = _loc2_;
         this.playerMessageListPositionUpdate();
      }
      
      private function setBuffNotificationSystemPositionX() : void
      {
         this.eventBuffNotificationSystem.x = App.appWidth - this.eventBuffNotificationSystem.width >> 1;
      }
      
      private function setBuffNotificationSystemPositionY() : void
      {
         var _loc1_:int = 0;
         if(this.eventMessage.isShown)
         {
            _loc1_ = this.eventMessage.y + this.eventMessage.getMessageBottom() + BUFF_NOTIFICATION_SYSTEM_OFFSET;
         }
         else if(this.bossHPBar.visible)
         {
            _loc1_ = this.bossHPBar.y + this.bossHPBar.height + BUFF_NOTIFICATION_SYSTEM_OFFSET;
         }
         else
         {
            _loc1_ = this.eventTimer.y + this.eventTimer.getTitleBottom() + BUFF_NOTIFICATION_SYSTEM_OFFSET;
         }
         this.clearBuffTween();
         if(this.eventBuffNotificationSystem.isShown())
         {
            this._buffTween = new Tween(BUFF_TWEEN_TIME,this.eventBuffNotificationSystem,{"y":_loc1_},{
               "ease":Cubic.easeInOut,
               "fastTransform":false
            });
         }
         else
         {
            this.eventBuffNotificationSystem.y = _loc1_;
         }
      }
      
      override protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      override protected function onMiniMapChangeHandler(param1:MinimapEvent) : void
      {
         this.setBossIndicatorProgressPosition();
         super.onMiniMapChangeHandler(param1);
      }
      
      private function onBossProgressIndicatorEnabledHandler(param1:BossIndicatorEvent) : void
      {
         this.setBossIndicatorProgressPosition();
      }
      
      private function onChangedWidthBuffNotificationSystemHandler(param1:ResizableBuffNotificationSystemEvent) : void
      {
         this.setBuffNotificationSystemPositionX();
      }
      
      private function onChangedTopBuffNotificationSystemHandler(param1:ResizableBuffNotificationSystemEvent) : void
      {
         this.setBuffNotificationSystemPositionY();
      }
      
      private function hintChangedEventHandler(param1:BattleHintEvent) : void
      {
         this.setBuffNotificationSystemPositionY();
      }
      
      private function onEventTimerSizeChangedHandler(param1:EventTimerEvent) : void
      {
         this.bossHPBar.y = param1.state == 0 ? Number(BOSS_HP_OFFSET_Y_SMALL) : Number(BOSS_HP_OFFSET_Y_BIG);
         if(this.bossHPBar.visible)
         {
            this.setBuffNotificationSystemPositionY();
         }
      }
      
      private function clearBuffTween() : void
      {
         if(this._buffTween)
         {
            this._buffTween.dispose();
            this._buffTween = null;
         }
      }
      
      override protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         super.setComponentsVisibility(param1,param2);
         if(param1.indexOf(BATTLE_VIEW_ALIASES.BOSS_HPBAR) != -1)
         {
            this.setBuffNotificationSystemPositionY();
         }
      }
   }
}
