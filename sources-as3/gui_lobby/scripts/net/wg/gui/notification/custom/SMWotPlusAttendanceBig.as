package net.wg.gui.notification.custom
{
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   
   public class SMWotPlusAttendanceBig extends WotPlusAttendanceBig
   {
       
      
      public var closeBtn:CloseButton;
      
      public function SMWotPlusAttendanceBig()
      {
         super();
      }
      
      override public function set data(param1:NotificationInfoVO) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(param1)
         {
            _loc2_ = param1.messageVO.bgIcon;
            _loc3_ = ".";
            _loc4_ = _loc2_.split(_loc3_);
            param1.messageVO.bgIcon = _loc4_[0] + "PopUp" + _loc3_ + _loc4_[1];
         }
         super.data = param1;
      }
   }
}
