package net.wg.gui.lobby.vehicleTradeWnds.buy.popover
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.rally.vo.VehicleVO;
   
   public class TradeInRendererVO extends VehicleVO
   {
      
      private static const VEHICLE_PRICES_ACTION_FIELD:String = "actionPrice";
       
      
      public var price:Number;
      
      public var actionPrice:ActionPriceVO = null;
      
      public function TradeInRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VEHICLE_PRICES_ACTION_FIELD && param2 != null)
         {
            this.actionPrice = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.actionPrice)
         {
            this.actionPrice.dispose();
            this.actionPrice = null;
         }
         super.onDispose();
      }
   }
}
