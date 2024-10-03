package net.wg.white_tiger.gui.battle.views.staticMarkers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ScaleAnimation extends MovieClip implements IDisposable
   {
      
      private static const SINGLE:String = "single";
      
      private static const REPEATING:String = "repeating";
      
      private static const IDLE:String = "idle";
       
      
      public var content:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function ScaleAnimation()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.content = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function playAnimation() : void
      {
         this.content.gotoAndPlay(SINGLE);
      }
      
      public function playRepeatingAnimation() : void
      {
         this.content.gotoAndPlay(REPEATING);
      }
      
      public function setScale(param1:Number) : void
      {
         this.content.scaleX = param1;
         this.content.scaleY = param1;
      }
      
      public function stopAnimation() : void
      {
         this.content.gotoAndStop(IDLE);
      }
   }
}
