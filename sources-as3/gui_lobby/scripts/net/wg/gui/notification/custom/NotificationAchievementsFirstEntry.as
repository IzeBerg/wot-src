package net.wg.gui.notification.custom
{
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class NotificationAchievementsFirstEntry extends ServiceMessageContent
   {
       
      
      public function NotificationAchievementsFirstEntry()
      {
         super();
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_ACHIEVEMENTS_MESSENGER_SYS_NOTIFICATION_ACHIEVEMENT_FIRST_ENTRY_BG;
      }
   }
}
