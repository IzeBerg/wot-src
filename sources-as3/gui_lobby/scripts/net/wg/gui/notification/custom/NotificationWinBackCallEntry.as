package net.wg.gui.notification.custom
{
   import net.wg.data.constants.Values;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   
   public class NotificationWinBackCallEntry extends ServiceMessageContent
   {
      
      private static const BOTTOM_OFFSET:int = -6;
       
      
      public function NotificationWinBackCallEntry()
      {
         super();
         messageTopOffset = textField.y;
         contentBottomOffset = BOTTOM_OFFSET;
      }
      
      override public function set data(param1:NotificationInfoVO) : void
      {
         param1.messageVO.bgIcon = Values.EMPTY_STR;
         var _loc2_:String = "<p align=\"center\"><font face=\"$TitleFont\" size=\"15\" color=\"#E9E2BF\"\'>" + App.utils.locale.makeString(WINBACK_CALL.SERVICECHANNELMESSAGES_ENTRYPOINT_TITLE) + "</font></p>";
         var _loc3_:String = "<p align=\"center\"><font size=\"15\" color=\"#8C8C7E\"\'>" + App.utils.locale.makeString(WINBACK_CALL.SERVICECHANNELMESSAGES_ENTRYPOINT_BODY) + "</font></p>";
         param1.messageVO.message = _loc2_ + _loc3_;
         super.data = param1;
      }
   }
}
