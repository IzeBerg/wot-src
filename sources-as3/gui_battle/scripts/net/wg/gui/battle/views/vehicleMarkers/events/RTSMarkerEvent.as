package net.wg.gui.battle.views.vehicleMarkers.events
{
   import flash.events.Event;
   
   public class RTSMarkerEvent extends Event
   {
      
      public static const MARKER_MOUSE_OVER:String = "markerMouseOver";
      
      public static const MARKER_MOUSE_OUT:String = "markerMouseOut";
       
      
      public var vehicleId:int = 0;
      
      public function RTSMarkerEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.vehicleId = param2;
      }
   }
}
