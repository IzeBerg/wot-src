package net.wg.gui.lobby.vehicleInfo.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleInfoPropBlockVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var value:String = "";
      
      public var highlight:Boolean = false;
      
      public function VehicleInfoPropBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
