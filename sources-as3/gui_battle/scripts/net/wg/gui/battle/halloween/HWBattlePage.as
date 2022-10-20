package net.wg.gui.battle.halloween
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.eventBattle.views.battleHints.EventBattleHint;
   import net.wg.gui.battle.eventBattle.views.battleHints.event.BattleHintEvent;
   import net.wg.gui.battle.eventBattle.views.buffsPanel.BuffsPanel;
   import net.wg.gui.battle.halloween.basesPanel.HWBasesPanel;
   import net.wg.gui.battle.random.views.BattlePage;
   import net.wg.gui.battle.views.postmortemPanel.PostmortemPanel;
   
   public class HWBattlePage extends BattlePage
   {
      
      private static const BUFF_PANEL_OFFSET_Y:int = 123;
      
      private static const RIBBONS_OFFSET_Y:int = 30;
      
      private static const VEHICLE_MESSAGES_LIST_OFFSET_Y:int = 106;
       
      
      public var eventMessage:EventBattleHint = null;
      
      public var eventBuffMessage:EventBattleHint = null;
      
      public var eventPickupMessage:EventBattleHint = null;
      
      public var eventBaseMessage:EventBattleHint = null;
      
      public var buffsPanel:BuffsPanel = null;
      
      public var eventBasePanel:HWBasesPanel = null;
      
      public function HWBattlePage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.eventMessage.updateStage(param1,param2);
         this.eventBuffMessage.updateStage(param1,param2);
         this.eventPickupMessage.updateStage(param1,param2);
         this.eventBaseMessage.updateStage(param1,param2);
         this.buffsPanel.x = param1 >> 1;
         this.buffsPanel.y = param2 - BUFF_PANEL_OFFSET_Y;
         ribbonsPanel.y -= RIBBONS_OFFSET_Y;
         this.eventBasePanel.x = param1 >> 1;
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
      
      override protected function configUI() : void
      {
         super.configUI();
         teamBasesPanelUI.visible = false;
         this.eventMessage.addEventListener(BattleHintEvent.START_APPEAR,this.onEventMessageStartAppearHandler);
         this.eventBaseMessage.addEventListener(BattleHintEvent.START_APPEAR,this.onEventMessageStartAppearHandler);
         this.eventMessage.addEventListener(BattleHintEvent.HIDING_COMPLETE,this.onEventMessageHidingCompleteHandler);
         this.eventBaseMessage.addEventListener(BattleHintEvent.HIDING_COMPLETE,this.onEventMessageHidingCompleteHandler);
         this.eventMessage.mouseEnabled = this.eventBuffMessage.mouseEnabled = this.eventPickupMessage.mouseEnabled = this.eventBuffMessage.mouseEnabled = false;
         this.eventMessage.mouseChildren = this.eventBuffMessage.mouseChildren = this.eventPickupMessage.mouseChildren = this.eventBuffMessage.mouseChildren = false;
      }
      
      override protected function createPostmortemTipsComponent() : void
      {
         if(postmortemTips == null)
         {
            postmortemTips = App.utils.classFactory.getComponent(Linkages.HWPOSTMORTEM_PANEL,PostmortemPanel);
         }
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.eventMessage,BATTLE_VIEW_ALIASES.BATTLE_HINT);
         registerComponent(this.eventBuffMessage,BATTLE_VIEW_ALIASES.BATTLE_BUFF_HINT);
         registerComponent(this.eventPickupMessage,BATTLE_VIEW_ALIASES.BATTLE_PICKUP_HINT);
         registerComponent(this.eventBaseMessage,BATTLE_VIEW_ALIASES.BATTLE_BASE_HINT);
         registerComponent(this.buffsPanel,BATTLE_VIEW_ALIASES.EVENT_BUFFS_PANEL);
         registerComponent(this.eventBasePanel,BATTLE_VIEW_ALIASES.EVENT_BASE_PANEL);
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         this.eventMessage.removeEventListener(BattleHintEvent.START_APPEAR,this.onEventMessageStartAppearHandler);
         this.eventBaseMessage.removeEventListener(BattleHintEvent.START_APPEAR,this.onEventMessageStartAppearHandler);
         this.eventMessage.removeEventListener(BattleHintEvent.HIDING_COMPLETE,this.onEventMessageHidingCompleteHandler);
         this.eventBaseMessage.removeEventListener(BattleHintEvent.HIDING_COMPLETE,this.onEventMessageHidingCompleteHandler);
         this.eventMessage = null;
         this.eventBaseMessage = null;
         this.eventBuffMessage = null;
         this.eventPickupMessage = null;
         this.buffsPanel = null;
         this.eventBasePanel = null;
         super.onDispose();
      }
      
      private function onEventMessageHidingCompleteHandler(param1:BattleHintEvent) : void
      {
         fragCorrelationBar.alpha = 1;
         this.eventBasePanel.alpha = 1;
      }
      
      private function onEventMessageStartAppearHandler(param1:BattleHintEvent) : void
      {
         fragCorrelationBar.alpha = 0;
         this.eventBasePanel.alpha = 0;
         prebattleTimer.visible = false;
      }
   }
}
