package net.wg.gui.bootcamp.messageWindow.controls
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class MessageCostContainer extends MovieClip
   {
      
      private static const COST_OFFSET1:int = 12;
      
      private static const COST_OFFSET2:int = 7;
      
      private static const ICON_BUY:int = 1;
      
      private static const ICON_RESEARCH:int = 2;
       
      
      public var costNameTF:TextField = null;
      
      public var costValueTF:TextField = null;
      
      public var costIcon:MovieClip = null;
      
      public function MessageCostContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.costNameTF = null;
         this.costValueTF = null;
         this.costIcon = null;
      }
      
      public function updateContent(param1:int, param2:Boolean) : void
      {
         this.costNameTF.text = BOOTCAMP.COST_MESSAGEVIEWBUY;
         this.costValueTF.text = App.utils.locale.integer(param1);
         var _loc3_:int = this.costNameTF.textWidth + this.costValueTF.textWidth + this.costIcon.width + COST_OFFSET1 + COST_OFFSET2;
         this.costNameTF.x = -(_loc3_ >> 1);
         this.costValueTF.x = this.costNameTF.x + this.costNameTF.textWidth + COST_OFFSET1;
         this.costIcon.x = this.costValueTF.x + this.costValueTF.textWidth + COST_OFFSET2;
         this.costIcon.gotoAndStop(!!param2 ? ICON_BUY : ICON_RESEARCH);
      }
   }
}
