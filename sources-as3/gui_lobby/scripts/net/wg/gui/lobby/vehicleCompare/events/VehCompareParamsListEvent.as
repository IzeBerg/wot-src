package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehCompareParamsListEvent extends Event
   {
      
      public static const RENDER_CLICK:String = "render_click";
       
      
      public function VehCompareParamsListEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
