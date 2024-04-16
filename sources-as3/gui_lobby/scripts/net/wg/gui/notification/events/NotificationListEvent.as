package net.wg.gui.notification.events
{
   import flash.events.Event;
   
   public class NotificationListEvent extends Event
   {
      
      public static const UPDATE_INDEXES:String = "updateIndexes";
       
      
      public var length:int = -1;
      
      public function NotificationListEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.length = param2;
      }
      
      override public function clone() : Event
      {
         return new NotificationListEvent(type,this.length,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("NotificationListEvent","type","length","bubbles","cancelable");
      }
   }
}
