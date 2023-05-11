package net.wg.gui.battle.views.staticMarkers.epic.headquarter
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HeadquarterAnimation extends MovieClip implements IDisposable
   {
       
      
      public var animation:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function HeadquarterAnimation()
      {
         super();
      }
      
      public function playAnimation() : void
      {
         this.animation.play();
      }
      
      public function gotoAndPlayAnimation(param1:String) : void
      {
         this.animation.gotoAndPlay(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.animation.stop();
         this.animation = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
