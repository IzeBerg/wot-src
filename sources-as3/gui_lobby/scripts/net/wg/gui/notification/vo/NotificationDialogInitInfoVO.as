package net.wg.gui.notification.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class NotificationDialogInitInfoVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var closeBtnTitle:String = "";
      
      public var settings:NotificationSettingsVO = null;
      
      public function NotificationDialogInitInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "settings")
         {
            this.settings = new NotificationSettingsVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
   }
}
