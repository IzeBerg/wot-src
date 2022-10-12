package net.wg.gui.components.vehicleStatus.events
{
   import flash.events.Event;
   
   public class VehicleStatusEvent extends Event
   {
      
      public static const RESIZE:String = "VehicleStatusResize";
       
      
      public function VehicleStatusEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new VehicleStatusEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("VehicleStatusEvent","type","bubbles","cancelable");
      }
   }
}
