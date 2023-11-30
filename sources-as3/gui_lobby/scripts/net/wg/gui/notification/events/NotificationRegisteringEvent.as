package net.wg.gui.notification.events
{
   import flash.events.Event;
   import net.wg.gui.notification.custom.GFNotificationInject;
   
   public class NotificationRegisteringEvent extends Event
   {
      
      public static const REGISTER_SM:String = "notificationRegister";
      
      public static const UNREGISTER_SM:String = "notificationUnregister";
      
      public static const REGISTER_POP_UP:String = "notificationRegisterPopUp";
      
      public static const UNREGISTER_POP_UP:String = "notificationUnregisterPopUp";
       
      
      public var injectInstance:GFNotificationInject;
      
      public var alias:String;
      
      public var gfViewName:String;
      
      public var linkageData:Object;
      
      public function NotificationRegisteringEvent(param1:String, param2:String, param3:String, param4:GFNotificationInject = null, param5:Object = null, param6:Boolean = true, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.alias = param2;
         this.gfViewName = param3;
         this.injectInstance = param4;
         this.linkageData = param5;
      }
      
      override public function clone() : Event
      {
         return new NotificationRegisteringEvent(type,this.alias,this.gfViewName,this.injectInstance,this.linkageData,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("NotificationRegisteringEvent","type","alias","gfViewName","injectInstance","linkageData","bubbles","cancelable");
      }
   }
}
