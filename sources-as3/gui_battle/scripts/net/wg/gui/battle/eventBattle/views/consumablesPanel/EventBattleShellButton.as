package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   
   public class EventBattleShellButton extends BattleShellButton
   {
       
      
      public var hit:MovieClip = null;
      
      public function EventBattleShellButton()
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
