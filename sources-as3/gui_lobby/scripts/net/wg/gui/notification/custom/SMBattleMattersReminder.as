package net.wg.gui.notification.custom
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Values;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.SMBattleMattersTaskReminderVO;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   
   public class SMBattleMattersReminder extends ServiceMessageContent
   {
      
      private static const MESSAGE_TOP_OFFSET:int = 98;
      
      private static const MESSAGE_BOTTOM_OFFSET:int = 20;
      
      private static const CONTENT_TOP_OFFSET:int = -102;
      
      private static const CONTENT_BOTTOM_OFFSET:int = Values.ZERO;
      
      private static const INVISIBLE_IMG_TOP:int = 103;
       
      
      public var taskIndexTF:TextField = null;
      
      public function SMBattleMattersReminder()
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
         param1.messageVO.bgIcon = RES_ICONS.MAPS_ICONS_BATTLEMATTERS_MESSENGER_POPUP_TASK_REMINDER;
         super.data = param1;
      }
      
      override protected function get invisibleTop() : int
      {
         return INVISIBLE_IMG_TOP;
      }
   }
}
