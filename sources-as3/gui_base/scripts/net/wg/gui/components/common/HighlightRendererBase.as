package net.wg.gui.components.common
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HighlightRendererBase extends MovieClip implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      public function HighlightRendererBase()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         throw new AbstractException("setProperties" + Errors.ABSTRACT_INVOKE);
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
      }
      
      protected function onDispose() : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
