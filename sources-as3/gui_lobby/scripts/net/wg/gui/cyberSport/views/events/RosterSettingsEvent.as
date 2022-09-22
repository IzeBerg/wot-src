package net.wg.gui.cyberSport.views.events
{
   import flash.events.Event;
   
   public class RosterSettingsEvent extends Event
   {
      
      public static const RANGE_ROSTER_CHANGED:String = "rangeRosterChanged";
       
      
      public var data:Object;
      
      public function RosterSettingsEvent(param1:String, param2:Object)
      {
         super(param1,true,false);
         this.data = param2;
      }
   }
}
