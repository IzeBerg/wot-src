package net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SecondaryTimerFXAnimation extends MovieClip implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      public function SecondaryTimerFXAnimation()
      {
         super();
         this.init();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function onDispose() : void
      {
         addFrameScript(totalFrames - 1,null);
      }
      
      public function resetAnimation() : void
      {
         visible = false;
         gotoAndStop(1);
      }
      
      private function init() : void
      {
         visible = false;
         addFrameScript(totalFrames - 1,this.resetAnimation);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
