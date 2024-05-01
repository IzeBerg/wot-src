package net.wg.gui.lobby.vehicleTradeWnds.buy.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleBuyTradeOffVo extends DAAPIDataClass
   {
      
      private static const VEHICLE_FIELD:String = "vehicleVo";
       
      
      public var vehicleVo:TradeOffVehicleVo = null;
      
      public var price:Number = -1;
      
      public var status:String = "";
      
      public function VehicleBuyTradeOffVo(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VEHICLE_FIELD && param2 != null)
         {
            this.vehicleVo = new TradeOffVehicleVo(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.vehicleVo.dispose();
         this.vehicleVo = null;
         super.onDispose();
      }
   }
}
