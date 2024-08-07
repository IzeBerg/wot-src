package net.wg.gui.notification
{
   import flash.events.Event;
   
   public class AnniversaryMissionsMessageContent extends ServiceMessageContent
   {
      
      private static const BUTTONS_GROUP_PADDING_TOP:int = 10;
      
      private static const MESSAGE_WIDTH:uint = 288;
       
      
      public function AnniversaryMissionsMessageContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textField.selectable = false;
      }
      
      override protected function updateLayout() : void
      {
         icon.visible = false;
         if(timeComponent != null)
         {
            timeComponent.visible = false;
         }
         App.utils.commons.updateTextFieldSize(textField,false,true);
         if(buttonsGroup != null)
         {
            buttonsGroup.x = MESSAGE_WIDTH - buttonsGroup.width >> 1;
            buttonsGroup.y = textField.y + textField.height + BUTTONS_GROUP_PADDING_TOP | 0;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
   }
}
