package net.wg.gui.battle.views.vehicleMarkers.events
{
   import flash.events.Event;
   
   public class VehicleMarkersManagerEvent extends Event
   {
      
      public static const SHOW_EX_INFO:String = "showExInfo";
      
      public static const UPDATE_SETTINGS:String = "updateSettings";
      
      public static const UPDATE_COLORS:String = "updateColors";
       
      
      public function VehicleMarkersManagerEvent(param1:String)
      {
         super(param1,false);
      }
   }
}
