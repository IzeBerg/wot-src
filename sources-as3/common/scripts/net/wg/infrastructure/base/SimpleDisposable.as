package net.wg.infrastructure.base
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SimpleDisposable extends MovieClip implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      public function SimpleDisposable()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._disposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function onDispose() : void
      {
      }
   }
}
