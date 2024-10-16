package net.wg.data.constants
{
   public class VehicleStatus
   {
      
      public static const DEFAULT:uint = 0;
      
      public static const IS_ALIVE:uint = 1;
      
      public static const IS_READY:uint = 2;
      
      public static const NOT_AVAILABLE:uint = 4;
      
      public static const STOP_RESPAWN:uint = 8;
       
      
      public function VehicleStatus()
      {
         super();
      }
      
      public static function isAlive(param1:uint) : Boolean
      {
         return (param1 & VehicleStatus.IS_ALIVE) > 0;
      }
      
      public static function isReady(param1:uint) : Boolean
      {
         return (param1 & VehicleStatus.IS_READY) > 0;
      }
   }
}
