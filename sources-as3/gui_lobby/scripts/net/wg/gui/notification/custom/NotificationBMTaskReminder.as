package net.wg.gui.notification.custom
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.SMBattleMattersTaskReminderVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   
   public class NotificationBMTaskReminder extends ServiceMessageContent
   {
      
      private static const MESSAGE_TOP_OFFSET:int = 167;
      
      private static const MESSAGE_BOTTOM_OFFSET:int = 25;
      
      private static const CONTENT_TOP_OFFSET:int = 0;
      
      private static const CONTENT_BOTTOM_OFFSET:int = 0;
       
      
      public var taskIndexTF:TextField = null;
      
      public function NotificationBMTaskReminder()
      {
         super();
         messageTopOffset = MESSAGE_TOP_OFFSET;
         messageBottomOffset = MESSAGE_BOTTOM_OFFSET;
         contentTopOffset = CONTENT_TOP_OFFSET;
         contentBottomOffset = CONTENT_BOTTOM_OFFSET;
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.taskIndexTF = null;
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         var _loc1_:SMBattleMattersTaskReminderVO = new SMBattleMattersTaskReminderVO(data.messageVO.linkageData);
         this.taskIndexTF.text = _loc1_.questIndexStr;
      }
      
      override public function set data(param1:NotificationInfoVO) : void
      {
         param1.messageVO.bgIcon = RES_ICONS.MAPS_ICONS_BATTLEMATTERS_MESSENGER_SYS_TASK_REMINDER;
         super.data = param1;
      }
   }
}
