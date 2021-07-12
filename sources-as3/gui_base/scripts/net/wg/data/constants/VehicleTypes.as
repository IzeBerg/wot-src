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
      
      public static const CAROUSEL_FILTER_ORDER:Vector.<String> = new <String>[LIGHT_TANK,MEDIUM_TANK,HEAVY_TANK,AT_SPG,SPG];
       
      
      public function VehicleTypes()
      {
         super();
      }
   }
}
