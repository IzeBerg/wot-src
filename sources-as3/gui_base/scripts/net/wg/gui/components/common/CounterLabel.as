package net.wg.gui.components.common
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.ILabel;
   
   public class CounterLabel extends Sprite implements ILabel
   {
       
      
      public var countTF:TextField = null;
      
      public function CounterLabel()
      {
         super();
         this.countTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function dispose() : void
      {
         this.countTF = null;
      }
      
      public function get text() : String
      {
         return this.countTF.htmlText;
      }
      
      public function set text(param1:String) : void
      {
         this.countTF.htmlText = param1;
      }
   }
}
