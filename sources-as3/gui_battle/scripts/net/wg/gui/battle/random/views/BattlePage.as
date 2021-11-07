package net.wg.gui.battle.random.views
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.gui.battle.components.TimersPanel;
   import net.wg.gui.battle.interfaces.IFullStats;
   import net.wg.gui.battle.random.views.fragCorrelationBar.FragCorrelationBar;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.PlayersPanel;
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
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.gui.battle.views.siegeModePanel.SiegeModePanel;
   import net.wg.gui.battle.views.sixthSense.SixthSense;
   import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.hintPanel.HintPanel;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class BattlePage extends BattlePageQuestsProgress
   {
      
      private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;
      
      private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;
      
      private static const CONSUMABLES_POPUP_OFFSET:int = 60;
      
      private static const MINIMAP_MARGIN_HEIGHT:int = 6;
      
      private static const MINIMAP_MARGIN_WIDTH:int = 0;
      
      private static const MESSANGER_SWAP_AREA_TOP_OFFSET:Number = -27;
      
      private static const QUEST_PROGRESS_TOP_SHIFT:int = 45;
      
      private static const INVALID_PLAYERS_PANEL_STATE:String = "invalidPlayersPanelState";
      
      private static const HINT_PANEL_Y_SHIFT_MULTIPLIER:Number = 1.5;
      
      protected static const HINT_PANEL_AMMUNITION_OFFSET_Y:int = -160;
      
      private static const HIT_TEST_FIX_NAME:String = "HitTest Fix";
       
      
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
      
      public var fullStats:IFullStats = null;
      
      public var playersPanel:PlayersPanel = null;
      
      public var radialMenu:RadialMenu = null;
      
      public var endWarningPanel:BattleEndWarningPanel = null;
      
      public var siegeModePanel:SiegeModePanel = null;
      
      private var _playersPanelState:int = -1;
      
      private var _playersPanelHasInvite:Boolean = false;
      
      private var _isPlayersPanelIsEmpty:Boolean = true;
      
      public function BattlePage()
      {
         super();
         this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
         if(this.playersPanel != null)
         {
            this.playersPanel.addEventListener(Event.CHANGE,this.onPlayersPanelChangeHandler);
         }
         this.teamBasesPanelUI.addEventListener(Event.CHANGE,this.onTeamBasesPanelUIChangeHandler);
         this.endWarningPanel.addEventListener(EndWarningPanelEvent.VISIBILITY_CHANGED,this.onEndWarningPanelVisibilityChangedHandler);
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
         var _loc3_:Number = param1 >> 1;
         this.teamBasesPanelUI.x = _loc3_;
         this.sixthSense.x = _loc3_;
         this.sixthSense.y = param2 >> 2;
         var _loc4_:Number = stage.scaleY;
         this.damageInfoPanel.y = (param2 >> 1) / _loc4_ + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * _loc4_ | 0;
         this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
         if(this.fragCorrelationBar != null)
         {
            this.fragCorrelationBar.x = _loc3_;
            this.fragCorrelationBar.updateStage(param1,param2);
         }
         this.battleMessenger.x = damagePanel.x;
         this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSENGER_Y_OFFSET;
         if(this.destroyTimersPanel != null)
         {
            this.destroyTimersPanel.updateStage(param1,param2);
         }
         if(this.fullStats != null)
         {
            this.fullStats.updateStageSize(param1,param2);
         }
         if(this.playersPanel != null)
         {
            this.playersPanel.updateStageSize(param1,param2);
         }
         this.consumablesPanel.updateStage(param1,param2);
         this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
         this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING;
         this.battleDamageLogPanel.updateSize(param1,param2);
         this.radialMenu.updateStage(param1,param2);
         this.endWarningPanel.x = _loc3_;
         this.battleMessenger.updateSwapAreaHeight(damagePanel.y - this.getPlayersPanelBottom() + MESSANGER_SWAP_AREA_TOP_OFFSET);
         if(this.battleNotifier)
         {
            this.battleNotifier.updateStage(param1,param2);
            this.setChildIndex(this.battleNotifier,this.getChildIndex(this.radialMenu) - 1);
         }
         this.updateHintPanelPosition();
      }
      
      override protected function createStatisticsController() : BattleStatisticDataController
      {
         return new BattleStatisticDataController(this);
      }
      
      override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
      {
         var _loc2_:BaseBattleLoading = getBattleLoading();
         if(_loc2_)
         {
            param1.registerComponentController(_loc2_);
         }
         param1.registerComponentController(this.fragCorrelationBar);
         param1.registerComponentController(this.fullStats);
         param1.registerComponentController(this.playersPanel);
         super.initializeStatisticsController(param1);
      }
      
      override protected function configUI() : void
      {
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.SWITCH_POPUP,this.onConsumablesPanelSwitchPopupHandler);
         this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         if(this.playersPanel != null)
         {
            this.playersPanel.addEventListener(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE,this.onPlayersPanelOnItemsCountChangeHandler);
            this.playersPanel.addEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onPlayersPanelStateRequestedHandler);
         }
         this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         super.configUI();
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.teamBasesPanelUI,BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
         registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
         registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
         registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
         if(this.fullStats != null)
         {
            registerComponent(this.fullStats,BATTLE_VIEW_ALIASES.FULL_STATS);
         }
         registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
         if(this.playersPanel != null)
         {
            registerComponent(this.playersPanel,BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
         }
         registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
         if(this.fragCorrelationBar != null)
         {
            registerComponent(this.fragCorrelationBar,BATTLE_VIEW_ALIASES.FRAG_CORRELATION_BAR);
         }
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         if(this.destroyTimersPanel != null)
         {
            registerComponent(this.destroyTimersPanel,BATTLE_VIEW_ALIASES.TIMERS_PANEL);
         }
         registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
         registerComponent(this.endWarningPanel,BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL);
         registerComponent(this.siegeModePanel,BATTLE_VIEW_ALIASES.SIEGE_MODE_INDICATOR);
         registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
         if(this.battleNotifier)
         {
            registerComponent(this.battleNotifier,BATTLE_VIEW_ALIASES.BATTLE_NOTIFIER);
         }
         super.onPopulate();
      }
      
      override protected function onRegisterStatisticController() : void
      {
         registerFlashComponentS(battleStatisticDataController,BATTLE_VIEW_ALIASES.BATTLE_STATISTIC_DATA_CONTROLLER);
      }
      
      override protected function onDispose() : void
      {
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.battleMessenger.removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         if(this.playersPanel != null)
         {
            this.playersPanel.removeEventListener(Event.CHANGE,this.onPlayersPanelChangeHandler);
            this.playersPanel.removeEventListener(PlayersPanelSwitchEvent.STATE_REQUESTED,this.onPlayersPanelStateRequestedHandler);
            this.playersPanel.removeEventListener(PlayersPanelEvent.ON_ITEMS_COUNT_CHANGE,this.onPlayersPanelOnItemsCountChangeHandler);
            this.playersPanel = null;
         }
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
         this.consumablesPanel = null;
         this.destroyTimersPanel = null;
         this.radialMenu = null;
         this.endWarningPanel = null;
         this.battleDamageLogPanel = null;
         this.siegeModePanel = null;
         this.battleNotifier = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_PLAYERS_PANEL_STATE))
         {
            this.updateDamageLogPosition();
         }
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc2_:Number = App.appHeight - this.playersPanel.panelHeight - MINIMAP_MARGIN_HEIGHT;
         var _loc3_:Number = App.appWidth - this.consumablesPanel.panelWidth - MINIMAP_MARGIN_WIDTH;
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
         var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT;
         var _loc2_:int = postmortemTips.x - (postmortemTips.width >> 1);
         if(this.battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH >= _loc2_)
         {
            _loc1_ = BattleDamageLogConstants.MIN_VIEW_RENDERER_COUNT_IN_POSTMORTEM;
         }
         this.battleDamageLogPanel.setDetailActionCount(_loc1_);
      }
      
      override protected function onComponentVisibilityChanged(param1:String, param2:Boolean) : void
      {
         super.onComponentVisibilityChanged(param1,param2);
         if(param1 == BATTLE_VIEW_ALIASES.MINIMAP)
         {
            this.playerMessageListPositionUpdate();
         }
      }
      
      override protected function getFullStatsTabQuestProgress() : IQuestProgressView
      {
         return this.fullStats.getStatsProgressView();
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
      
      protected function getPlayersPanelBottom() : int
      {
         return this.playersPanel.y + this.playersPanel.height;
      }
      
      protected function consumablesPanelPositionUpdated() : void
      {
      }
      
      protected function getDamageLogPanelRightSpace() : int
      {
         return this.consumablesPanel.x;
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
         var _loc1_:int = 0;
         this.endWarningPanel.y = this.teamBasesPanelUI.y + this.teamBasesPanelUI.panelHeight;
         if(isQuestProgress)
         {
            _loc1_ = this.teamBasesPanelUI.y + QUEST_PROGRESS_TOP_SHIFT;
            _loc1_ += this.endWarningPanel.panelHeight;
            _loc1_ += this.teamBasesPanelUI.panelHeight;
            updatePositionQuestProgressTop(_loc1_);
         }
      }
      
      private function checkZIndexes(param1:DisplayObject, param2:DisplayObject) : Boolean
      {
         return this.getChildIndex(param1) > this.getChildIndex(param2);
      }
      
      private function updateBattleDamageLogPanelPosition() : void
      {
         var _loc1_:int = BattleDamageLogConstants.MAX_VIEW_RENDER_COUNT;
         if(this.battleDamageLogPanel.x + BattleDamageLogConstants.MAX_DAMAGE_LOG_VIEW_WIDTH >= this.getDamageLogPanelRightSpace())
         {
            _loc1_ = BattleDamageLogConstants.MIN_VIEW_RENDER_COUNT;
         }
         this.battleDamageLogPanel.setDetailActionCount(_loc1_);
      }
      
      private function swapElementsByMouseInteraction(param1:DisplayObject, param2:DisplayObject) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(!App.contextMenuMgr.isShown() && this.checkZIndexes(param1,param2))
         {
            this.swapChildren(param1,param2);
         }
      }
      
      private function updateDamageLogPosition() : void
      {
         var _loc1_:Number = NaN;
         if((this._playersPanelState > PLAYERS_PANEL_STATE.HIDDEN || this._playersPanelHasInvite) && this.playersPanel != null)
         {
            _loc1_ = this.playersPanel.listLeft.getRenderersVisibleWidth() + BattleDamageLogPanel.PLAYERS_PANEL_OFFSET;
            this.battleDamageLogPanel.updateTopContainerPosition(_loc1_);
         }
         else
         {
            this.battleDamageLogPanel.updateTopContainerPosition(BattleDamageLogPanel.SCREEN_BORDER_X_POS);
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
         this.consumablesPanelPositionUpdated();
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
   }
}
