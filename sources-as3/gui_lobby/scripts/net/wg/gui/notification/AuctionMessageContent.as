package net.wg.gui.notification
{
   import flash.events.Event;
   
   public class AuctionMessageContent extends ServiceMessageContent
   {
      
      private static const BUTTONS_GROUP_PADDING_TOP:int = 10;
      
      private static const MESSAGE_PADDING_BOTTOM:int = 15;
      
      private static const WIDTH:int = 288;
       
      
      public function AuctionMessageContent()
      {
         super();
         background.alpha = 0;
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override protected function updateLayout() : void
      {
         if(timeComponent != null)
         {
            timeComponent.visible = false;
         }
         App.utils.commons.updateTextFieldSize(textField,false,true);
         icon.y = 0;
         icon.x = this.width - icon.width >> 1;
         textField.x = this.width - textField.width >> 1;
         textField.y = icon.y + icon.height | 0;
         buttonsGroup.x = this.width - buttonsGroup.width >> 1;
         buttonsGroup.y = textField.y + textField.height + BUTTONS_GROUP_PADDING_TOP ^ 0;
         var _loc1_:uint = buttonsGroup.y + buttonsGroup.height + MESSAGE_PADDING_BOTTOM;
         if(_loc1_ != background.height)
         {
            background.height = bgIcon.height = _loc1_;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
   }
}
