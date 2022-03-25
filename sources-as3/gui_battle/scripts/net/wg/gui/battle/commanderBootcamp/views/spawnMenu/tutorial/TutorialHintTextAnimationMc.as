package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialHintTextAnimationMc extends MovieClip implements IDisposable
   {
       
      
      public var hintTextMc:TutorialHintText = null;
      
      private var _isDisposed:Boolean = false;
      
      public function TutorialHintTextAnimationMc()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.hintTextMc.dispose();
         this.hintTextMc = null;
         this._isDisposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
