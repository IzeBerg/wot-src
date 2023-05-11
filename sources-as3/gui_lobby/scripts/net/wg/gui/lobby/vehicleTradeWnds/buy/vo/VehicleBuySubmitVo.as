package net.wg.gui.lobby.vehicleTradeWnds.buy.vo
{
   public class VehicleBuySubmitVo
   {
       
      
      public var buySlot:Boolean = false;
      
      public var buyAmmo:Boolean = false;
      
      public var crewType:int = -1;
      
      public var rentId:int = -1;
      
      public var tradeOff:int = -1;
      
      public function VehicleBuySubmitVo(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:Number)
      {
         super();
         this.buySlot = param1;
         this.buyAmmo = param2;
         this.crewType = param3;
         this.rentId = param4;
         this.tradeOff = param5;
      }
   }
}
