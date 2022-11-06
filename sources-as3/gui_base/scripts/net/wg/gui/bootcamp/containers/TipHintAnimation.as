package net.wg.gui.bootcamp.containers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TipHintAnimation extends MovieClip implements IDisposable
   {
       
      
      public var container:HintContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function TipHintAnimation()
      {
         super();
      }
      
      public function setLabel(param1:String) : void
      {
         this.container.setLabel(param1);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.container.dispose();
         this.container = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
