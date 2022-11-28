package net.wg.gui.notification.custom
{
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class SMSeniorityAwardsQuest extends ServiceMessageContent
   {
      
      private static const CONTENT_TOP_OFFSET:int = 0;
      
      private static const CONTENT_BOTTOM_OFFSET:int = 33;
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public function SMSeniorityAwardsQuest()
      {
         super();
         contentTopOffset = CONTENT_TOP_OFFSET;
         contentBottomOffset = CONTENT_BOTTOM_OFFSET;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         bgIcon.source = RES_ICONS.MAPS_ICONS_SENIORITYAWARDS_MESSENGER_POPUP_NOTIFICATION_QUEST_BG;
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
   }
}
