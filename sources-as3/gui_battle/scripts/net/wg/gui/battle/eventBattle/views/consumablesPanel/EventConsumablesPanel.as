package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   
   public class EventConsumablesPanel extends ConsumablesPanel
   {
      
      private static const EVENT_OFFSET:int = 30;
       
      
      public function EventConsumablesPanel()
      {
         super();
      }
      
      override protected function updatePosition() : void
      {
         super.updatePosition();
         y -= EVENT_OFFSET;
      }
      
      override protected function createEquipmentButton() : IConsumablesButton
      {
         return App.utils.classFactory.getComponent(Linkages.EVENT_EQUIPMENT_BUTTON,EventBattleEquipmentButton);
      }
      
      override protected function createShellButton() : IBattleShellButton
      {
         return App.utils.classFactory.getComponent(Linkages.EVENT_SHELL_BUTTON_BATTLE,EventBattleShellButton);
      }
   }
}
