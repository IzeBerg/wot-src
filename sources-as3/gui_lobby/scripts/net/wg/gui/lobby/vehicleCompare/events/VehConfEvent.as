package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehConfEvent extends Event
   {
      
      public static const CLOSE_CLICK:String = "closeClick";
      
      public static const APPLY_CLICK:String = "applyClick";
      
      public static const RESET_CLICK:String = "resetClick";
      
      public static const CAMO_CLICK:String = "camoClick";
      
      public static const MODULES_CLICK:String = "modulesClick";
      
      public static const TOP_MODULES_ON:String = "topModulesOn";
      
      public static const TOP_MODULES_OFF:String = "topModulesOff";
       
      
      public function VehConfEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
