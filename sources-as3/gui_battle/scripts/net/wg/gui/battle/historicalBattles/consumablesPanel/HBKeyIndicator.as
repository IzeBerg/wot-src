package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import scaleform.gfx.TextFieldEx;
   
   public class HBKeyIndicator extends Sprite
   {
      
      private static const BACK_MIN_WIDTH:int = 25;
      
      private static const BACK_MARGIN:int = 10;
       
      
      public var textField:TextField;
      
      public var back:Sprite;
      
      public function HBKeyIndicator()
      {
         super();
         this.textField.autoSize = TextFieldAutoSize.CENTER;
         TextFieldEx.setNoTranslate(this.textField,true);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.textField = null;
         this.back = null;
      }
      
      public function setText(param1:String) : void
      {
         var _loc2_:int = 0;
         this.textField.text = param1;
         if(this.back)
         {
            _loc2_ = Math.round(this.textField.width + BACK_MARGIN);
            this.back.width = Math.max(_loc2_,BACK_MIN_WIDTH);
            this.back.x = -this.back.width >> 1;
            this.back.visible = param1 != Values.EMPTY_STR;
         }
      }
   }
}
