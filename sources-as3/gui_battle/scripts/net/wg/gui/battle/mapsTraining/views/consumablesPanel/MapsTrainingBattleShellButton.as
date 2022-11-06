package net.wg.gui.battle.mapsTraining.views.consumablesPanel
{
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   
   public class MapsTrainingBattleShellButton extends BattleShellButton
   {
       
      
      public function MapsTrainingBattleShellButton()
      {
         super();
      }
      
      override protected function setBindKeyText() : void
      {
         glow.setBindKeyText(Values.EMPTY_STR);
      }
   }
}
