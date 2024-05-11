package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalMissionAwardsScreenVO extends DAAPIDataClass
   {
      
      private static const VEHICLE_DATA_LBL:String = "vehicleData";
       
      
      public var closeBtnLabel:String = "";
      
      public var header:String = "";
      
      public var headerExtra:String = "";
      
      public var campaignId:int = -1;
      
      private var _vehicleData:PersonalMissionVehicleAwardVO = null;
      
      public function PersonalMissionAwardsScreenVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VEHICLE_DATA_LBL)
         {
            this._vehicleData = new PersonalMissionVehicleAwardVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleData)
         {
            this._vehicleData.dispose();
            this._vehicleData = null;
         }
         super.onDispose();
      }
      
      public function get vehicleData() : PersonalMissionVehicleAwardVO
      {
         return this._vehicleData;
      }
   }
}
