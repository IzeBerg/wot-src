package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.data.constants.KeyProps;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import net.wg.gui.eventcomponents.NumberProgress;
   
   public class EventBattleEquipmentButton extends BattleEquipmentButton
   {
       
      
      public var bindKeyFieldEvent:NumberProgress = null;
      
      public function EventBattleEquipmentButton()
      {
         super();
      }
      
      override protected function setBindKeyText() : void
      {
         if(bindSfKeyCode == KeyProps.KEY_NONE)
         {
            this.bindKeyFieldEvent.setText(App.utils.locale.makeString(READABLE_KEY_NAMES.KEY_NONE_ALT));
         }
         else
         {
            this.bindKeyFieldEvent.setText(App.utils.commons.keyToString(bindSfKeyCode).keyName);
         }
      }
      
      override protected function onDispose() : void
      {
         this.bindKeyFieldEvent.dispose();
         this.bindKeyFieldEvent = null;
         super.onDispose();
      }
   }
}
