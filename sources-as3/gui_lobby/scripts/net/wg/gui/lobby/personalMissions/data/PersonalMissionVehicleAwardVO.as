package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalMissionVehicleAwardVO extends DAAPIDataClass
   {
       
      
      public var vehicleSrc:String = "";
      
      public var vehicleTypeIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var vehicleLevel:String = "";
      
      public var hasData:Boolean = false;
      
      public function PersonalMissionVehicleAwardVO(param1:Object = null)
      {
         super(param1);
         this.hasData = param1 != null;
      }
   }
}
