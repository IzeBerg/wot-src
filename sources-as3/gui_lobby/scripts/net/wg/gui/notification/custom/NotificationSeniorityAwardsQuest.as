package net.wg.gui.notification.custom
{
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class NotificationSeniorityAwardsQuest extends ServiceMessageContent
   {
      
      private static const MESSAGE_BOTTOM_OFFSET:int = 14;
       
      
      public function NotificationSeniorityAwardsQuest()
      {
         super();
         messageTopOffset = 0;
         messageBottomOffset = MESSAGE_BOTTOM_OFFSET;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_SENIORITYAWARDS_MESSENGER_SYS_NOTIFICATION_QUEST_BG;
      }
   }
}
