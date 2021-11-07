package net.wg.gui.battle.views.destroyTimers.components.notifiers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.gfx.TextFieldEx;
   
   public class TextNotifier extends Sprite implements INotifier
   {
       
      
      public var textField:TextField;
      
      public function TextNotifier()
      {
         super();
         mouseEnabled = mouseChildren = false;
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      public function dispose() : void
      {
         this.textField = null;
      }
      
      public function setText(param1:String) : void
      {
         this.textField.autoSize = TextFieldAutoSize.CENTER;
         this.textField.htmlText = param1;
      }
   }
}
