package net.wg.gui.notification.custom
{
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class SMCollectionsCustom extends ServiceMessageContent
   {
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public function SMCollectionsCustom()
      {
         super();
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_COLLECTIONS_MESSENGER_POPUP_NOTIFICATION_COLLECTIONS_WITH_ENTRY_BG;
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
   }
}
