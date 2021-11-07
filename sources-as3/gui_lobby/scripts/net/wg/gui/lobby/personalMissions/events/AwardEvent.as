package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class AwardEvent extends Event
   {
      
      public static const VEHICLE_PREVIEW:String = "vehicle_preview";
      
      public static const VEHICLE_LOADED:String = "vehicle_loaded";
       
      
      public function AwardEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
