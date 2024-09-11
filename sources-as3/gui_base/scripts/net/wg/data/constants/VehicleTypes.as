package net.wg.data.constants
{
   public class VehicleTypes
   {
      
      public static const LIGHT_TANK:String = "lightTank";
      
      public static const MEDIUM_TANK:String = "mediumTank";
      
      public static const HEAVY_TANK:String = "heavyTank";
      
      public static const SPG:String = "SPG";
      
      public static const AT_SPG:String = "AT-SPG";
      
      public static const ALL:String = "None";
      
      public static const TANK:String = "Tank";
      
      public static const WHEEL:String = "Wheel";
      
      public static const TANK_YOH:String = "TankYoh";
      
      public static const TANK_MULTITRACK:String = "TankMultitrackSequent";
      
      public static const TANK_MULTITRACK_PARALLEL:String = "TankMultitrackParallel";
      
      public static const SPG_MULTITRACK:String = "SPGMultitrackSequent";
      
      public static const SPG_MULTITRACK_PARALLEL:String = "SPGMultitrackParallel";
      
      public static const AT_SPG_MULTITRACK:String = "AT-SPGMultitrackSequent";
      
      public static const AT_SPG_MULTITRACK_PARALLEL:String = "AT-SPGMultitrackParallel";
      
      public static const CAROUSEL_FILTER_ORDER:Vector.<String> = new <String>[LIGHT_TANK,MEDIUM_TANK,HEAVY_TANK,AT_SPG,SPG];
       
      
      public function VehicleTypes()
      {
         super();
      }
      
      public static function hasMultitrack(param1:String) : Boolean
      {
         return [TANK_YOH,TANK_MULTITRACK,TANK_MULTITRACK_PARALLEL,SPG_MULTITRACK,SPG_MULTITRACK_PARALLEL,AT_SPG_MULTITRACK,AT_SPG_MULTITRACK_PARALLEL].indexOf(param1) != -1;
      }
   }
}
