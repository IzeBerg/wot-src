package net.wg.gui.notification.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class NotificationSettingsVO extends DAAPIDataClass
   {
       
      
      public var timeout:int = -1;
      
      public function NotificationSettingsVO(param1:Object)
      {
         super(param1);
      }
   }
}
