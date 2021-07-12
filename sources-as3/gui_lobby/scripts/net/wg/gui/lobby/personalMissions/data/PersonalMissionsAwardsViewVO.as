package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalMissionsAwardsViewVO extends DAAPIDataClass
   {
      
      private static const MAIN_AWARDS_FIELD:String = "mainAwards";
      
      private static const ADDITIONAL_AWARDS_FIELD:String = "additionalAwards";
      
      private static const VEHICLE_AWARD_FIELD:String = "vehicleAward";
       
      
      public var vehicleAward:VehicleAwardVO = null;
      
      public var mainAwards:AdditionalAwardsVO = null;
      
      public var additionalAwards:AdditionalAwardsVO = null;
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescrLabel:String = "";
      
      public var bgIconSource:String = "";
      
      public function PersonalMissionsAwardsViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         switch(param1)
         {
            case ADDITIONAL_AWARDS_FIELD:
               this.additionalAwards = new AdditionalAwardsVO(param2);
               return false;
            case VEHICLE_AWARD_FIELD:
               this.vehicleAward = new VehicleAwardVO(param2);
               return false;
            case MAIN_AWARDS_FIELD:
               this.mainAwards = new AdditionalAwardsVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         this.additionalAwards.dispose();
         this.additionalAwards = null;
         this.mainAwards.dispose();
         this.mainAwards = null;
         this.vehicleAward.dispose();
         this.vehicleAward = null;
         super.onDispose();
      }
   }
}
