package net.wg.gui.battle.historicalBattles.battleHints
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class TextContainer extends BattleDisplayable
   {
       
      
      public var txt:TextField = null;
      
      public function TextContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.txt = null;
         super.onDispose();
      }
      
      public function setText(param1:String, param2:uint = 16777215, param3:String = "center") : void
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
