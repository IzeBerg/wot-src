package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TextWrapper extends MovieClip implements IDisposable
   {
       
      
      public var tf:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TextWrapper()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.tf = null;
      }
      
      public function updateTextWidth(param1:Number) : void
      {
         this.tf.width = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
