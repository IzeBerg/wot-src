package net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleTutorialDoneAnimContainer extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      public function BattleTutorialDoneAnimContainer()
      {
         super();
         this.textField.text = BATTLE_TUTORIAL.TASKS_ANIM_DONE;
      }
      
      public function dispose() : void
      {
         this.textField = null;
      }
   }
}
