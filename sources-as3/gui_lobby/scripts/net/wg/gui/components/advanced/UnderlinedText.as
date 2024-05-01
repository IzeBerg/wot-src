package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class UnderlinedText extends Sprite
   {
       
      
      public var textField:TextField;
      
      public var background:Sprite;
      
      private var bgOriginalWidth:Number;
      
      public function UnderlinedText()
      {
         super();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.bgOriginalWidth = this.background.width;
         this.layoutBg();
      }
      
      public function set text(param1:String) : void
      {
         this.textField.htmlText = param1;
         this.layoutBg();
      }
      
      private function layoutBg() : void
      {
         this.background.width = Math.max(this.textField.x + this.textField.width,this.bgOriginalWidth);
         dispatchEvent(new Event(Event.RESIZE,true));
      }
      
      public function set fontSize(param1:uint) : void
      {
         var _loc2_:TextFormat = this.textField.getTextFormat();
         _loc2_.size = param1;
         this.textField.setTextFormat(_loc2_);
         this.textField.defaultTextFormat = _loc2_;
      }
   }
}
