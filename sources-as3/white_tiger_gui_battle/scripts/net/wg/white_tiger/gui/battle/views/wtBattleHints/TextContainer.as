package net.wg.white_tiger.gui.battle.views.wtBattleHints
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class TextContainer extends BattleDisplayable
   {
       
      
      public var txt:TextField = null;
      
      public function TextContainer()
      {
         super();
         this.txt.wordWrap = true;
         this.txt.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.txt = null;
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         this.txt.htmlText = param1;
      }
      
      public function setWidth(param1:Number) : void
      {
         this.txt.width = param1;
         this.txt.x = -param1 >> 1;
      }
   }
}
