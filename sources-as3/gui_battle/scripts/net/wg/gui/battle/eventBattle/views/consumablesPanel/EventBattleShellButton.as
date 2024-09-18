package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IEventBattleShellButton;
   
   public class EventBattleShellButton extends BattleShellButton implements IEventBattleShellButton
   {
       
      
      public var hit:MovieClip = null;
      
      public var inspired:MovieClip = null;
      
      public function EventBattleShellButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         hitArea = this.hit;
         this.inspired.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.hit = null;
         this.inspired = null;
         super.onDispose();
      }
      
      public function setInspired(param1:Boolean = false) : void
      {
         this.inspired.visible = param1;
      }
   }
}
