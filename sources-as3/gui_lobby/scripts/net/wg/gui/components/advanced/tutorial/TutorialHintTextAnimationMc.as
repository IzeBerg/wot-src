package net.wg.gui.components.advanced.tutorial
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TutorialHintTextAnimationMc extends MovieClip implements IDisposable
   {
       
      
      public var hintTextMc:TutorialHintText = null;
      
      private var _disposed:Boolean = false;
      
      public function TutorialHintTextAnimationMc()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.hintTextMc.dispose();
         this.hintTextMc = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
