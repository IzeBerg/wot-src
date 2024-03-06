package net.wg.gui.notification.custom
{
   import flash.text.TextField;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class WotPlusAttendanceSmall extends ServiceMessageContent
   {
       
      
      public var rewards:GroupEx = null;
      
      public var endTextField:TextField = null;
      
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
      
      override protected function onDispose() : void
      {
         if(this.rewards)
         {
            this.rewards.dispose();
            this.rewards = null;
         }
         this.endTextField = null;
         super.onDispose();
      }
   }
}
