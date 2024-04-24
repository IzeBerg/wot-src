package net.wg.gui.notification.custom
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.SMCustomSeniorityAwardsTokensVO;
   
   public class NotificationSeniorityAwardsTokens extends ServiceMessageContent
   {
      
      private static const MESSAGE_BOTTOM_OFFSET:int = 14;
       
      
      public var countTF:TextField = null;
      
      public function NotificationSeniorityAwardsTokens()
      {
         super();
         messageTopOffset = 0;
         messageBottomOffset = MESSAGE_BOTTOM_OFFSET;
         buttonsAlign = TextFormatAlign.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.countTF = null;
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         if(!data)
         {
            return;
         }
         super.updateData();
         var _loc1_:SMCustomSeniorityAwardsTokensVO = new SMCustomSeniorityAwardsTokensVO(data.messageVO.linkageData);
         this.countTF.text = _loc1_.count;
         this.countTF.selectable = false;
         bgIcon.source = RES_ICONS.MAPS_ICONS_SENIORITYAWARDS_MESSENGER_SYS_NOTIFICATION_TOKENS_BG;
      }
      
      override public function get height() : Number
      {
         return background.y + background.height;
      }
   }
}
