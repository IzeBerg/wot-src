package net.wg.gui.lobby.header.events
{
   import flash.events.Event;
   
   public class PersonalReservesWidgetEvent extends Event
   {
      
      public static const CREATED:String = "created";
      
      public static const RESIZED:String = "resized";
       
      
      public function PersonalReservesWidgetEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
