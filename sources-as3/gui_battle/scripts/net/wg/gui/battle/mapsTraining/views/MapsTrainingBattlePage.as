package net.wg.gui.battle.mapsTraining.views
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.components.TimersPanel;
   import net.wg.gui.battle.mapsTraining.views.goals.MapsTrainingGoals;
   import net.wg.gui.battle.views.BaseBattlePage;
   import net.wg.gui.battle.views.battleEndWarning.BattleEndWarningPanel;
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
   import net.wg.utils.StageSizeBoundaries;
   
   public class MapsTrainingBattlePage extends BaseBattlePage
   {
      
      private static const BATTLE_DAMAGE_LOG_X_POSITION:int = 229;
      
      private static const BATTLE_DAMAGE_LOG_Y_PADDING:int = 3;
      
      private static const HINT_PANEL_Y_SHIFT_MULTIPLIER:Number = 1.5;
      
      private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;
      
      private static const PREBATTLE_TIMER_Y:int = -25;
      
      private static const PREBATTLE_TIMER_Y_SMALL:int = -63;
      
      private static const MINIMAP_MARGIN_WIDTH:int = 40;
       
      
      public var debugPanel:DebugPanel = null;
      
      public var battleDamageLogPanel:BattleDamageLogPanel = null;
      
      public var sixthSense:SixthSense = null;
      
      public var consumablesPanel:ConsumablesPanel = null;
      
      public var hintPanel:HintPanel = null;
      
      public var damageInfoPanel:DamageInfoPanel = null;
      
      public var battleMessenger:BattleMessenger = null;
      
      public var radialMenu:RadialMenu = null;
      
      public var endWarningPanel:BattleEndWarningPanel = null;
      
      public var destroyTimersPanel:TimersPanel = null;
      
      public var goals:MapsTrainingGoals = null;
      
      public function MapsTrainingBattlePage()
      {
         super();
         this.battleDamageLogPanel.init(ATLAS_CONSTANTS.BATTLE_ATLAS);
      }
      
      override public function as_onPostmortemActive(param1:Boolean) : void
      {
         super.as_onPostmortemActive(param1);
         if(!param1 && !this.consumablesPanel.hasEventListener(ConsumablesPanelEvent.UPDATE_POSITION))
         {
            this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         }
      }
      
      override protected function updatePrebattleTimerPosition(param1:int) : void
      {
         prebattleTimer.x = param1;
         prebattleTimer.y = App.appHeight <= StageSizeBoundaries.HEIGHT_800 ? Number(PREBATTLE_TIMER_Y_SMALL) : Number(PREBATTLE_TIMER_Y);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.battleDamageLogPanel.x = BATTLE_DAMAGE_LOG_X_POSITION;
         this.battleDamageLogPanel.y = damagePanel.y + BATTLE_DAMAGE_LOG_Y_PADDING >> 0;
         this.battleDamageLogPanel.updateSize(param1,param2);
         var _loc3_:uint = param1 >> 1;
         this.sixthSense.x = _loc3_;
         this.sixthSense.y = param2 >> 2;
         this.consumablesPanel.updateStage(param1,param2);
         this.damageInfoPanel.y = (param2 >> 1) / scaleY + DAMAGE_INFO_PANEL_CONSTS.HEIGHT * scaleY | 0;
         this.damageInfoPanel.x = param1 - DAMAGE_INFO_PANEL_CONSTS.WIDTH >> 1;
         this.radialMenu.updateStage(param1,param2);
         this.endWarningPanel.x = _loc3_;
         this.goals.x = _loc3_;
         this.goals.updateStage(param1,param2);
         this.battleMessenger.x = damagePanel.x;
         this.battleMessenger.y = damagePanel.y - this.battleMessenger.height + MESSENGER_Y_OFFSET;
         this.destroyTimersPanel.updateStage(param1,param2);
         this.updateHintPanelPosition();
      }
      
      override protected function configUI() : void
      {
         this.consumablesPanel.addEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.battleMessenger.addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.addEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.hintPanel.addEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         postmortemPanelUI.isEnabledPostmortemPanel = false;
         super.configUI();
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.debugPanel,BATTLE_VIEW_ALIASES.DEBUG_PANEL);
         registerComponent(this.battleDamageLogPanel,BATTLE_VIEW_ALIASES.BATTLE_DAMAGE_LOG_PANEL);
         registerComponent(this.sixthSense,BATTLE_VIEW_ALIASES.SIXTH_SENSE);
         registerComponent(this.battleMessenger,BATTLE_VIEW_ALIASES.BATTLE_MESSENGER);
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         registerComponent(this.hintPanel,BATTLE_VIEW_ALIASES.HINT_PANEL);
         registerComponent(this.damageInfoPanel,BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL);
         registerComponent(this.destroyTimersPanel,BATTLE_VIEW_ALIASES.TIMERS_PANEL);
         registerComponent(this.radialMenu,BATTLE_VIEW_ALIASES.RADIAL_MENU);
         registerComponent(this.endWarningPanel,BATTLE_VIEW_ALIASES.BATTLE_END_WARNING_PANEL);
         registerComponent(this.goals,BATTLE_VIEW_ALIASES.MAPS_TRAINING_GOALS);
         super.onPopulate();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.consumablesPanel.removeEventListener(ConsumablesPanelEvent.UPDATE_POSITION,this.onConsumablesPanelUpdatePositionHandler);
         this.consumablesPanel = null;
         this.battleMessenger.removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onBattleMessengerRequestFocusHandler);
         this.battleMessenger.removeEventListener(BattleMessenger.REMOVE_FOCUS,this.onBattleMessengerRemoveFocusHandler);
         this.hintPanel.removeEventListener(Event.RESIZE,this.onHintPanelResizeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.battleMessenger = null;
         this.hintPanel = null;
         this.debugPanel = null;
         this.battleDamageLogPanel = null;
         this.sixthSense = null;
         this.damageInfoPanel = null;
         this.destroyTimersPanel = null;
         this.radialMenu = null;
         this.endWarningPanel = null;
         this.goals = null;
         super.onDispose();
      }
      
      override protected function vehicleMessageListPositionUpdate() : void
      {
         if(postmortemPanelUI && postmortemPanelUI.visible)
         {
            super.vehicleMessageListPositionUpdate();
         }
         else
         {
            vehicleMessageList.setLocation(_originalWidth - VEHICLE_MESSAGES_LIST_OFFSET.x >> 1,_originalHeight - VEHICLE_MESSAGES_LIST_OFFSET_Y | 0);
         }
      }
      
      override protected function getAllowedMinimapSizeIndex(param1:Number) : Number
      {
         var _loc3_:Rectangle = null;
         var _loc2_:Number = App.appWidth - this.consumablesPanel.panelWidth - MINIMAP_MARGIN_WIDTH;
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
      
      private function onBattleMessengerRequestFocusHandler(param1:FocusRequestEvent) : void
      {
         setFocus(param1.focusContainer.getComponentForFocus());
      }
      
      private function onBattleMessengerRemoveFocusHandler(param1:Event) : void
      {
         setFocus(this);
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
      
      private function onHintPanelResizeHandler(param1:Event) : void
      {
         this.updateHintPanelPosition();
      }
   }
}
