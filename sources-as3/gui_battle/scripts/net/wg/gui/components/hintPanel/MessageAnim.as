package net.wg.gui.components.hintPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MessageAnim extends MovieClip implements IDisposable
   {
       
      
      public var textFieldContainer:TextFieldContainer = null;
      
      private var _disposed:Boolean = false;
      
      public function MessageAnim()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
         this.textFieldContainer.dispose();
         this.textFieldContainer = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setText(param1:String) : void
      {
         this.textFieldContainer.label = param1;
      }
      
      public function setTextFieldAlign(param1:String) : void
      {
         this.textFieldContainer.textAlign = param1;
      }
      
      public function setTextFieldWidth(param1:Number) : void
      {
         this.textFieldContainer.textField.width = param1 | 0;
      }
   }
}
