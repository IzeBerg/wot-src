package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class IgrPremVehQuestBlock extends MovieClip
   {
      
      private static var MARGIN:Number = 6;
       
      
      public var headerTF:TextField;
      
      public var descrTF:TextField;
      
      public function IgrPremVehQuestBlock()
      {
         super();
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.headerTF.htmlText = param1;
         this.headerTF.height = this.headerTF.textHeight + 4;
         this.descrTF.y = this.headerTF.y + this.headerTF.height + MARGIN;
         this.descrTF.multiline = true;
         this.descrTF.wordWrap = true;
         this.descrTF.autoSize = TextFieldAutoSize.LEFT;
         this.descrTF.htmlText = param2;
         this.descrTF.height = this.descrTF.textHeight + 4;
      }
   }
}
