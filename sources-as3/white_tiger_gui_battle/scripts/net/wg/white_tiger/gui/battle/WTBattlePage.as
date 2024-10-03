package net.wg.white_tiger.gui.battle
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.StatusNotificationsPanel;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventObjectives;
   import net.wg.gui.battle.eventBattle.views.buffsPanel.BuffsPanel;
   import net.wg.gui.battle.eventBattle.views.eventPointCounter.EventPointCounter;
   import net.wg.gui.battle.eventBattle.views.eventTimer.EventTimer;
   import net.wg.gui.battle.views.BaseBattlePage;
   import net.wg.gui.battle.views.battleMessenger.BattleMessenger;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.gui.battle.views.damageInfoPanel.DamageInfoPanel;
   import net.wg.gui.battle.views.debugPanel.DebugPanel;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.gui.battle.views.sixthSense.SixthSense;
   import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.hintPanel.HintPanel;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   import net.wg.white_tiger.gui.battle.infrastructure.WTBattleStatisticDataController;
   import net.wg.white_tiger.gui.battle.views.shared.WTDeploymentMapView;
   import net.wg.white_tiger.gui.battle.views.wtBattleHints.BattleHint;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.BossWidget;
   import net.wg.white_tiger.gui.battle.views.wtFullStats.FullStats;
   import net.wg.white_tiger.gui.battle.views.wtHunterRespawn.WTHunterRespawnView;
   import net.wg.white_tiger.gui.battle.views.wtMinimap.WTMinimap;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.PlayersPanel;
   import net.wg.white_tiger.gui.battle.views.wtTeamBasePanel.TeamBasesPanel;
   import net.wg.white_tiger.gui.battle.views.wtTeleportView.WTBossTeleportView;
   
   public class WTBattlePage extends BaseBattlePage
   {
      
      private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;
      
      private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;
      
      private static const CONSUMABLES_POPUP_OFFSET:int = 60;
      
      private static const HINT_PANEL_Y_SHIFT_MULTIPLIER:Number = 1.5;
      
      private static const POINT_COUNTER_HEIGHT:int = 160;
      
      private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;
      
      private static const BUFF_PANEL_OFFSET_Y:int = 135;
      
      private static const MINIMAP_OFFSET:int = 18;
      
      private static const EVENT_PLAYER_MESSAGES_LIST_OFFSET_Y:int = -50;
      
      private static const SCREEN_SMALL_WIDTH:Number = 1920;
      
      private static const SCREEN_SMALL_HEIGHT:Number = 1080;
      
      private static const UNEXPECTED_ALIAS:String = "Unexpected deploy selection alias: ";
      
      private static const MINIMAP_SIZE_INDEX_SMALL:int = 3;
      
      private static const MINIMAP_SIZE_INDEX_BIG:int = 5;
      
      private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 200;
      
      private static const RIBBONS_STAGE_HEIGHT_SMALL:int = 900;
      
      private static const BATTLE_MSGS_SWAP_AREA_OFFSET:int = 15;
      
      private static const TEAM_BASES_SHOWN_OFFSET:int = -50;
       
      
      public var debugPanel:DebugPanel = null;
      
      public var battleDamageLogPanel:BattleDamageLogPanel = null;
      
      public var sixthSense:SixthSense = null;
      
      public var consumablesPanel:ConsumablesPanel = null;
      
      public var statusNotificationsPanel:StatusNotificationsPanel = null;
      
      public var eventMessage:BattleHint = null;
      
      public var hintPanel:HintPanel = null;
      
      public var damageInfoPanel:DamageInfoPanel = null;
      
      public var battleMessenger:BattleMessenger = null;
      
      public var fullStats:FullStats = null;
      
      public var radialMenu:RadialMenu = null;
      
      public var playersPanelEvent:PlayersPanel = null;
      
      public var eventPointCounter:EventPointCounter = null;
      
      public var eventTimer:EventTimer = null;
      
      public var buffsPanel:BuffsPanel = null;
      
      public var eventObjectives:EventObjectives = null;
      
      public var hunterRespawn:WTHunterRespawnView = null;
      
      public var bossTeleport:WTBossTeleportView = null;
      
      public var bossWidgetShadow:BattleAtlasSprite = null;
      
      public var bossWidget:BossWidget = null;
      
      public var teamBasesPanelUI:TeamBasesPanel = null;
      
      private var _eventMinimap:WTMinimap = null;
      
      public function WTBattlePage()
      {
         super();
         this._eventMinimap = WTMinimap(minimap);
         this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
         this.playersPanelEvent.addEventListener(Event.CHANGE,this.onEvPlayersPanelChangeHandler);
      }
      
      override public function as_setPostmortemTipsVisible(param1:Boolean) : void
      {
         super.as_setPostmortemTipsVisible(param1);
         if(!param1 && !this.consumablesPanel.hasEventListener(ConsumablesPanelEvent.UPDATE_POSITION))
         {
            this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         }
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
         this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING >> 0;
         this.battleDamageLogPanel.updateSize(param1,param2);
         var _loc3_:uint = param1 >> 1;
         var _loc4_:uint = param2 >> 1;
         this.sixthSense.updateStage(param1,param2);
         this.teamBasesPanelUI.x = _loc3_;
         this.consumablesPanel.updateStage(param1,param2);
         this.statusNotificationsPanel.updateStage(param1,param2);
         this.damageInfoPanel.y = _loc4_ / scaleY + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * scaleY | 0;
         this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
         this.radialMenu.updateStage(param1,param2);
         this.eventMessage.updateStage(param1,param2);
         this.playersPanelEvent.updateStageSize(param1,param2);
         this.fullStats.updateStageSize(param1,param2);
         this.eventTimer.x = _loc3_;
         this.eventObjectives.x = param1 - this.eventObjectives.width >> 0;
         this.buffsPanel.x = _loc3_;
         this.buffsPanel.y = App.appHeight - BUFF_PANEL_OFFSET_Y;
         this.hunterRespawn.updateStage(param1,param2);
         this.bossTeleport.updateStage(param1,param2);
         this.updateBattleMessengerPosition();
         this.updateHintPanelPosition();
         this.updateConsumablesPanelPosition();
         this.updateWTProgressPosition();
         this.updateBattleMsgSwapArea();
      }
      
      override protected function playerMessageListPositionUpdate() : void
      {
         playerMessageList.setLocation(_originalWidth - PLAYER_MESSAGES_LIST_OFFSET.x | 0,_originalHeight - minimap.getMessageCoordinate() + EVENT_PLAYER_MESSAGES_LIST_OFFSET_Y);
      }
      
      override protected function configUI() : void
      {
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         this.bossWidget.addEventListener(Event.RESIZE,this.updateWTProgressPosition);
         this.bossWidgetShadow.imageName = BATTLEATLAS.MESSAGE_SHADOW;
         this.teamBasesPanelUI.addEventListener(Event.CHANGE,this.onTeamBasesPanelChanged);
         super.configUI();
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
         registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
         registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
         registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         registerComponent(this.statusNotificationsPanel,BATTLE_VIEW_ALIASES.STATUS_NOTIFICATIONS_PANEL);
         registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
         registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
         registerComponent(this.fullStats,BATTLE_VIEW_ALIASES.EVENT_STATS);
         registerComponent(this.playersPanelEvent,BATTLE_VIEW_ALIASES.PLAYERS_PANEL_EVENT);
         registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
         registerComponent(this.teamBasesPanelUI,BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
         registerComponent(this.buffsPanel,BATTLE_VIEW_ALIASES.EVENT_BUFFS_PANEL);
         registerComponent(this.eventPointCounter,BATTLE_VIEW_ALIASES.EVENT_POINT_COUNTER);
         registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
         registerComponent(this.eventObjectives,BATTLE_VIEW_ALIASES.EVENT_OBJECTIVES);
         registerComponent(this.hunterRespawn,BATTLE_VIEW_ALIASES.EVENT_HUNTER_RESPAWN);
         registerComponent(this.bossTeleport,BATTLE_VIEW_ALIASES.EVENT_BOSS_TELEPORT);
         registerComponent(this.bossWidget,BATTLE_VIEW_ALIASES.EVENT_BOSS_WIDGET);
         this.updateWTProgressPosition();
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.consumablesPanel = null;
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.battleMessenger = null;
         this.hintPanel.removeEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         this.hintPanel = null;
         this.bossWidget.removeEventListener(Event.RESIZE,this.updateWTProgressPosition);
         this.bossWidget = null;
         this.bossWidgetShadow = null;
         this.debugPanel = null;
         this.battleDamageLogPanel = null;
         this.sixthSense = null;
         this.statusNotificationsPanel = null;
         this.damageInfoPanel = null;
         this.fullStats = null;
         this.radialMenu = null;
         this.playersPanelEvent.removeEventListener(Event.CHANGE,this.onEvPlayersPanelChangeHandler);
         this.playersPanelEvent = null;
         this.eventMessage = null;
         this.eventObjectives = null;
         this.eventPointCounter = null;
         this.buffsPanel = null;
         this.eventTimer = null;
         this.bossTeleport = null;
         this.hunterRespawn = null;
         this.teamBasesPanelUI.removeEventListener(Event.CHANGE,this.onTeamBasesPanelChanged);
         this.teamBasesPanelUI = null;
         this._eventMinimap = null;
         super.onDispose();
      }
      
      override protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         var _loc3_:String = null;
         super.setComponentsVisibility(param1,param2);
         for each(_loc3_ in param1)
         {
            if(_loc3_ == BATTLE_VIEW_ALIASES.EVENT_HUNTER_RESPAWN || _loc3_ == BATTLE_VIEW_ALIASES.EVENT_BOSS_TELEPORT)
            {
               this.setMinimapDeploymentMode(_loc3_,true);
               return;
            }
         }
         for each(_loc3_ in param2)
         {
            if(_loc3_ == BATTLE_VIEW_ALIASES.EVENT_HUNTER_RESPAWN || _loc3_ == BATTLE_VIEW_ALIASES.EVENT_BOSS_TELEPORT)
            {
               this.setMinimapDeploymentMode(_loc3_,false);
               return;
            }
         }
      }
      
      override protected function showComponent(param1:String, param2:Boolean) : void
      {
         if(param1 == BATTLE_VIEW_ALIASES.BATTLE_LOADING)
         {
            return;
         }
         super.showComponent(param1,param2);
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(this._eventMinimap.isDeploymentMode)
         {
            _loc5_ = _height < SCREEN_SMALL_HEIGHT || _width < SCREEN_SMALL_WIDTH;
            return int(!!_loc5_ ? int(MINIMAP_SIZE_INDEX_SMALL) : int(MINIMAP_SIZE_INDEX_BIG));
         }
         var _loc2_:Number = App.appHeight >> 1;
         var _loc3_:Number = App.appWidth - this.consumablesPanel.panelWidth - MINIMAP_OFFSET | 0;
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
         if(!this._eventMinimap.isDeploymentMode)
         {
            super.updateMinimapPosition();
         }
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new WTBattleStatisticDataController(this);
      }
      
      override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
         param1.registerComponentController(this.playersPanelEvent);
         param1.registerComponentController(this.fullStats);
         super.initializeStatisticsController(param1);
      }
      
      override protected function onRegisterStatisticController() : void
      {
         registerFlashComponentS(battleStatisticDataController,BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
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
      
      override protected function getRibbonsCenterOffset(param1:Number) : int
      {
         if(param1 <= RIBBONS_STAGE_HEIGHT_SMALL)
         {
            return RIBBONS_CENTER_SCREEN_OFFSET_Y;
         }
         return super.getRibbonsCenterOffset(param1);
      }
      
      private function updateBattleMessengerPosition() : void
      {
         this.battleMessenger.x = damagePanel.x;
         this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSENGER_Y_OFFSET;
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
         this.hintPanel.y = HINT_PANEL_Y_SHIFT_MULTIPLIER * (_originalHeight - this.hintPanel.height >> 1) ^ 0;
      }
      
      private function updateConsumablesPanelPosition() : void
      {
         this.eventPointCounter.x = App.appWidth >> 1;
         this.eventPointCounter.y = App.appHeight - POINT_COUNTER_HEIGHT;
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
      
      private function setMinimapDeploymentMode(param1:String, param2:Boolean) : void
      {
         if(this._eventMinimap.isDeploymentMode == param2)
         {
            return;
         }
         var _loc3_:WTDeploymentMapView = null;
         switch(param1)
         {
            case BATTLE_VIEW_ALIASES.EVENT_HUNTER_RESPAWN:
               _loc3_ = this.hunterRespawn;
               break;
            case BATTLE_VIEW_ALIASES.EVENT_BOSS_TELEPORT:
               _loc3_ = this.bossTeleport;
               break;
            default:
               throw new Error(UNEXPECTED_ALIAS + Values.SPACE_STR + param1);
         }
         if(param2)
         {
            _loc3_.attachMinimap(minimap);
         }
         else
         {
            _loc3_.detachMinimap();
            addChild(minimap);
         }
         this._eventMinimap.isDeploymentMode = param2;
         this.updateMinimapPosition();
      }
      
      private function updateBattleMsgSwapArea() : void
      {
         var _loc1_:int = this.playersPanelEvent.y + this.playersPanelEvent.listLeft.y + this.playersPanelEvent.listLeft.height + BATTLE_MSGS_SWAP_AREA_OFFSET;
         this.battleMessenger.updateSwapAreaHeight(damagePanel.y - _loc1_);
      }
      
      private function onEvPlayersPanelChangeHandler(param1:Event) : void
      {
         this.updateBattleMsgSwapArea();
      }
      
      private function onBattleMessengerRollOutHandler(param1:MouseEvent) : void
      {
         if(!this.battleMessenger.isEnterButtonPressed)
         {
            this.swapElementsByMouseInteraction(this.battleMessenger,this.playersPanelEvent);
         }
      }
      
      private function onBattleMessengerRollOverHandler(param1:MouseEvent) : void
      {
         this.swapElementsByMouseInteraction(this.playersPanelEvent,this.battleMessenger);
      }
      
      private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
         if(this.battleMessenger.isEnterButtonPressed)
         {
            this.swapElementsByMouseInteraction(this.playersPanelEvent,this.battleMessenger);
         }
         else
         {
            this.swapElementsByMouseInteraction(this.battleMessenger,this.playersPanelEvent);
         }
      }
      
      private function onBattleMessengerRemoveFocusHandler(param1:Event) : void
      {
         setFocus(this);
         this.swapElementsByMouseInteraction(this.playersPanelEvent,this.battleMessenger);
      }
      
      private function onConsumablesPanelUpdatePositionHandler(param1:ConsumablesPanelEvent) : void
      {
         if(isPostMortem)
         {
            this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
            updateBattleDamageLogPosInPostmortem();
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
      
      private function onHintPanelResizeHandler(param1:Event) : void
      {
         this.updateHintPanelPosition();
      }
      
      private function updateWTProgressPosition(param1:Event = null) : void
      {
         this.bossWidget.x = _width - this.bossWidget.width >> 1;
         this.bossWidget.y = 0;
         this.bossWidgetShadow.x = _width - this.bossWidgetShadow.width >> 1;
      }
      
      private function onTeamBasesPanelChanged(param1:Event) : void
      {
         var _loc2_:int = this.teamBasesPanelUI.height + TEAM_BASES_SHOWN_OFFSET;
         this.eventMessage.setOffset(_loc2_ > 0 ? int(_loc2_) : int(0));
      }
   }
}
