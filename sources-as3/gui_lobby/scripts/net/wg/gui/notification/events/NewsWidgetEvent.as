package net.wg.gui.notification.events
{
   import flash.events.Event;
   
   public class NewsWidgetEvent extends Event
   {
      
      public static var ON_CLICK:String = "onNewsClickEv";
       
      
      public function NewsWidgetEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
