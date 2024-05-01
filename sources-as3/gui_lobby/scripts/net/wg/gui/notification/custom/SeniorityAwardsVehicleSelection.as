package net.wg.gui.notification.custom
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.SMCustomSeniorityAwardsTokensVO;
   
   public class SeniorityAwardsVehicleSelection extends ServiceMessageContent
   {
      
      private static const CONTENT_TOP_OFFSET:int = 0;
      
      private static const CONTENT_BOTTOM_OFFSET:int = 33;
      
      private static const MESSAGE_WIDTH:uint = 289;
       
      
      public var countTF:TextField = null;
      
      public function SeniorityAwardsVehicleSelection()
      {
         super();
         contentTopOffset = CONTENT_TOP_OFFSET;
         contentBottomOffset = CONTENT_BOTTOM_OFFSET;
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
         bgIcon.source = RES_ICONS.MAPS_ICONS_SENIORITYAWARDS_MESSENGER_SYS_NOTIFICATION_VEHICLES_BG;
         var _loc1_:SMCustomSeniorityAwardsTokensVO = new SMCustomSeniorityAwardsTokensVO(data.messageVO.linkageData);
         this.countTF.text = _loc1_.count;
         this.countTF.selectable = false;
      }
      
      override public function get width() : Number
      {
         return MESSAGE_WIDTH;
      }
   }
}
