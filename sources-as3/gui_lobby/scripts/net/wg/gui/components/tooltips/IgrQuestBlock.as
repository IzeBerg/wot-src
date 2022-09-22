package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class IgrQuestBlock extends MovieClip
   {
       
      
      public var questText:TextField;
      
      public function IgrQuestBlock()
      {
         super();
      }
      
      public function setText(param1:String) : void
      {
         this.questText.htmlText = param1;
         this.questText.height = this.questText.textHeight + 4;
      }
   }
}
