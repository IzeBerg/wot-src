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
      
      public static const RIGHT_TRACK_LBL_LENGTH:uint = RIGHT_TRACK.length;
      
      public static const LEFT_TRACK_LBL_LENGTH:uint = LEFT_TRACK.length;
      
      public static const WHEEL_LBL_LENGTH:int = WHEEL.length;
      
      public static const CHASSIS:String = "chassis";
      
      public static const TRACK_MAIN:String = "main";
      
      public static const TRACK_SECOND:String = "second";
      
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
      
      public static function checkModuleName(param1:String) : Boolean
      {
         return VehicleModules.MODULES_LIST.indexOf(param1) >= 0 || param1.indexOf(VehicleModules.WHEEL) >= 0 || isLeftTrack(param1) || isRightTrack(param1);
      }
      
      public static function getRightTrackName(param1:String) : String
      {
         return param1.slice(0,RIGHT_TRACK_LBL_LENGTH);
      }
      
      public static function getLeftTrackName(param1:String) : String
      {
         return param1.slice(0,LEFT_TRACK_LBL_LENGTH);
      }
      
      public static function isTrack(param1:String) : Boolean
      {
         return isRightTrack(param1) || isLeftTrack(param1);
      }
      
      public static function isLeftTrack(param1:String) : Boolean
      {
         return param1.indexOf(LEFT_TRACK) >= 0;
      }
      
      public static function isRightTrack(param1:String) : Boolean
      {
         return param1.indexOf(RIGHT_TRACK) >= 0;
      }
      
      public static function getRightTrackType(param1:String) : String
      {
         return getTrackTypeByInt(int(param1.substr(RIGHT_TRACK_LBL_LENGTH,1)));
      }
      
      public static function getLeftTrackType(param1:String) : String
      {
         return getTrackTypeByInt(int(param1.substr(LEFT_TRACK_LBL_LENGTH,1)));
      }
      
      public static function isWheel(param1:String) : Boolean
      {
         return param1.slice(0,WHEEL_LBL_LENGTH) == WHEEL && param1 != WHEEL;
      }
      
      private static function getTrackTypeByInt(param1:int) : String
      {
         return param1 == 1 ? TRACK_SECOND : TRACK_MAIN;
      }
   }
}
