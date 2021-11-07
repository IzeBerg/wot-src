package net.wg.gui.lobby.components.events
{
   import flash.events.Event;
   
   public class VehicleSelectorFilterEvent extends Event
   {
      
      public static const CHANGE:String = "filtersChanged";
       
      
      public var nation:int;
      
      public var vehicleType:String;
      
      public var isMain:Boolean;
      
      public var level:int;
      
      public var compatibleOnly:Boolean;
      
      public function VehicleSelectorFilterEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
