package net.wg.gui.components.hintPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MessageAnim extends MovieClip implements IDisposable
   {
       
      
      public var textFieldContainer:TextFieldContainer = null;
      
      public function MessageAnim()
      {
         super();
      }
      
      public final function dispose() : void
      {
         stop();
         this.textFieldContainer.dispose();
         this.textFieldContainer = null;
      }
      
      public function setText(param1:String) : void
      {
         this.textFieldContainer.label = param1;
      }
      
      public function setTextFieldWidth(param1:Number) : void
      {
         this.textFieldContainer.textField.width = param1 | 0;
      }
   }
}
