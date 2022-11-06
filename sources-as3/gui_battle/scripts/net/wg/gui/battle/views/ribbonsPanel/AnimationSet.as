package net.wg.gui.battle.views.ribbonsPanel
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimationSet extends MovieClip implements IDisposable
   {
       
      
      public var wrapper:MovieClip = null;
      
      public var glowAnim:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimationSet()
      {
         super();
         this.glowAnim.gotoAndStop(this.glowAnim.totalFrames - 1);
      }
      
      public function init(param1:MovieClip) : void
      {
         this.wrapper.addChild(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.glowAnim = null;
         this.wrapper = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
