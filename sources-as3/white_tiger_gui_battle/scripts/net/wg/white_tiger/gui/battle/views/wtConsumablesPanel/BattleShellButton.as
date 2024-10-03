package net.wg.white_tiger.gui.battle.views.wtConsumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   
   public class BattleShellButton extends net.wg.gui.battle.views.consumablesPanel.BattleShellButton
   {
       
      
      public var hit:MovieClip = null;
      
      public function BattleShellButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         hitArea = this.hit;
      }
      
      override protected function onDispose() : void
      {
         this.hit = null;
         super.onDispose();
      }
   }
}
