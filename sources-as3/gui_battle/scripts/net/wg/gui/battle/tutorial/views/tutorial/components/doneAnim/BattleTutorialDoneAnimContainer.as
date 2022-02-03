package net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleTutorialDoneAnimContainer extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function BattleTutorialDoneAnimContainer()
      {
         super();
         this.textField.text = BATTLE_TUTORIAL.TASKS_ANIM_DONE;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.textField = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
