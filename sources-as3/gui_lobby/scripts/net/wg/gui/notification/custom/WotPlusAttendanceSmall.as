package net.wg.gui.notification.custom
{
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class WotPlusAttendanceSmall extends ServiceMessageContent
   {
       
      
      public function WotPlusAttendanceSmall()
      {
         super();
         messageBottomOffset = 66;
      }
      
      override protected function updateLayout() : void
      {
         super.updateLayout();
         bgIcon.y = background.height - bgIcon.height;
      }
   }
}
