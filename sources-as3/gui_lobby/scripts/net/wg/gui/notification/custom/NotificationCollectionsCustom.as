package net.wg.gui.notification.custom
{
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class NotificationCollectionsCustom extends ServiceMessageContent
   {
      
      private static const TEXTFIELD_Y_OFFSET:int = 110;
       
      
      public function NotificationCollectionsCustom()
      {
         super();
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_COLLECTIONS_MESSENGER_SYS_NOTIFICATION_COLLECTIONS_WITH_ENTRY_BG;
         textField.y = textField.height + TEXTFIELD_Y_OFFSET;
      }
   }
}
