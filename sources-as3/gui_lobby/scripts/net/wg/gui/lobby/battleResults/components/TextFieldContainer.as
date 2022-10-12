package net.wg.gui.lobby.battleResults.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TextFieldContainer extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TextFieldContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.textField = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
      }
   }
}
