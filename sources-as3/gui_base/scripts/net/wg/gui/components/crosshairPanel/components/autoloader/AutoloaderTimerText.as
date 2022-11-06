package net.wg.gui.components.crosshairPanel.components.autoloader
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class AutoloaderTimerText extends MovieClip implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _text:String = "";
      
      private var _disposed:Boolean = false;
      
      public function AutoloaderTimerText()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.textField = null;
      }
      
      public function set label(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this.textField.text = param1;
      }
      
      public function set noTranslateTextfield(param1:Boolean) : void
      {
         TextFieldEx.setNoTranslate(this.textField,param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
