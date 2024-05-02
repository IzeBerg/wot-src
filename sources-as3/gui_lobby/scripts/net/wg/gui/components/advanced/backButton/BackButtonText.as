package net.wg.gui.components.advanced.backButton
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BackButtonText extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function BackButtonText()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.textField = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
