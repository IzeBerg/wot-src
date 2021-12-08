package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.data.constants.KeyProps;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   import net.wg.gui.eventcomponents.NumberProgress;
   
   public class EventBattleShellButton extends BattleShellButton
   {
       
      
      public var bindKeyFieldEvent:NumberProgress = null;
      
      public function EventBattleShellButton()
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
