package net.wg.gui.cyberSport.controls.events
{
   import flash.events.Event;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   
   public class VehicleSelectorItemEvent extends Event
   {
      
      public static const SELECT_VEHICLE:String = "selectVehicle";
       
      
      public var data:VehicleSelectorItemVO;
      
      public var forceSelect:Boolean = false;
      
      public function VehicleSelectorItemEvent(param1:String, param2:VehicleSelectorItemVO, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
         this.forceSelect = param5;
      }
   }
}
