package net.wg.data.constants
{
   public class VehicleModules
   {
      
      public static const LEFT_TRACK:String = "leftTrack";
      
      public static const RIGHT_TRACK:String = "rightTrack";
      
      public static const RADIO:String = "radio";
      
      public static const SURVEYING_DEVICE:String = "surveyingDevice";
      
      public static const GUN:String = "gun";
      
      public static const TURRET_ROTATOR:String = "turretRotator";
      
      public static const AMMO_BAY:String = "ammoBay";
      
      public static const FUEL_TANK:String = "fuelTank";
      
      public static const ENGINE:String = "engine";
      
      public static const WHEEL:String = "wheel";
      
      public static const CHASSIS:String = "chassis";
      
      public static const MODULES_LIST:Vector.<String> = new <String>[LEFT_TRACK,RIGHT_TRACK,RADIO,SURVEYING_DEVICE,GUN,TURRET_ROTATOR,AMMO_BAY,FUEL_TANK,ENGINE,CHASSIS,WHEEL];
      
      public static const MODULES_IN_TURRET:Vector.<String> = new <String>[RADIO,SURVEYING_DEVICE,GUN,AMMO_BAY,TURRET_ROTATOR];
       
      
      public function VehicleModules()
      {
         super();
      }
      
      public static function checkIsInTurret(param1:String) : Boolean
      {
         return VehicleModules.MODULES_IN_TURRET.indexOf(param1) >= 0;
      }
   }
}
