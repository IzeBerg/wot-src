package net.wg.data.VO
{
   public class VehicleStatusLightVO
   {
       
      
      public var vehicleID:Number = 0;
      
      public var status:uint = 4.294967295E9;
      
      public function VehicleStatusLightVO(param1:Number, param2:uint)
      {
         super();
         this.vehicleID = param1;
         this.status = param2;
      }
   }
}
