package net.wg.gui.notification.custom
{
   import net.wg.data.constants.Linkages;
   
   public class NYNotificationPopupContent extends NYNotificationContent
   {
       
      
      public function NYNotificationPopupContent()
      {
         super();
      }
      
      override protected function getNyBgLinkage() : String
      {
         return Linkages.NY_LB_NOTIFICATION_BG_UI;
      }
   }
}
