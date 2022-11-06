package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintAnimationBlind extends MovieClip implements IDisposable
   {
       
      
      public var animBlind:HintBlindContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function HintAnimationBlind()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.animBlind.dispose();
         this.animBlind = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
