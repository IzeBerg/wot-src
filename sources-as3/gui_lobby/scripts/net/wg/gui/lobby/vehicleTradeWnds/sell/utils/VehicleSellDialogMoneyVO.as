package net.wg.gui.lobby.vehicleTradeWnds.sell.utils
{
   public class VehicleSellDialogMoneyVO
   {
       
      
      public var type:String;
      
      public var color:uint;
      
      public var value:int;
      
      public var accountValue:int;
      
      public function VehicleSellDialogMoneyVO(param1:String, param2:uint)
      {
         super();
         this.type = param1;
         this.color = param2;
      }
      
      public function get hasEnough() : Boolean
      {
         return this.value >= 0 || this.value < 0 && -this.value <= this.accountValue;
      }
   }
}
