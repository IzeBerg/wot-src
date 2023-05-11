package net.wg.gui.battle.views.questProgress.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QPLockLineAnimation extends MovieClip implements IDisposable
   {
       
      
      public var lineAnimation:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function QPLockLineAnimation()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.lineAnimation.stop();
         this.lineAnimation = null;
      }
      
      public function resetShownContent() : void
      {
         this.lineAnimation.gotoAndStop(1);
      }
      
      public function showAnim() : void
      {
         this.lineAnimation.gotoAndPlay(2);
      }
      
      public function showContent() : void
      {
         this.lineAnimation.gotoAndStop(this.lineAnimation.totalFrames - 1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
