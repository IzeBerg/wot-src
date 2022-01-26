package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalMissionsVehicleSlotVO extends DAAPIDataClass
   {
       
      
      public var vehicleId:String = "";
      
      public var vehicleImg:String = "";
      
      public var vehicleSmallImg:String = "";
      
      public var pathImg:String = "";
      
      public var pathSmallImg:String = "";
      
      public function PersonalMissionsVehicleSlotVO(param1:Object)
      {
         super(param1);
      }
   }
}
