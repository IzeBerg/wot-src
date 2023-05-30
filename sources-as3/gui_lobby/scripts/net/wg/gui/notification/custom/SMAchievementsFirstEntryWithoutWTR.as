package net.wg.gui.notification.custom
{
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class SMAchievementsFirstEntryWithoutWTR extends ServiceMessageContent
   {
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public function SMAchievementsFirstEntryWithoutWTR()
      {
         super();
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_ACHIEVEMENTS_MESSENGER_POPUP_NOTIFICATION_ACHIEVEMENT_FIRST_ENTRY_WITHOUT_WTR_BG;
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
   }
}
