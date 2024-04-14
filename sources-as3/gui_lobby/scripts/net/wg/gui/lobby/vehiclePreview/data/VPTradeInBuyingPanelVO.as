package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class VPTradeInBuyingPanelVO extends DAAPIDataClass
   {
      
      private static const CURRENT_PRICE_FIELD_NAME:String = "currentPrice";
      
      private static const SELECTED_PRICE_FIELD_NAME:String = "selectedPrice";
       
      
      public var currentPrice:ItemPriceVO = null;
      
      public var selectedPrice:ItemPriceVO = null;
      
      public var statusText:String = "";
      
      public var title:String = "";
      
      public var statusOk:Boolean = true;
      
      public var tradeOffAvailable:Boolean = true;
      
      public var isFreeExchange:Boolean = false;
      
      public function VPTradeInBuyingPanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CURRENT_PRICE_FIELD_NAME && param2 != null)
         {
            this.currentPrice = new ItemPriceVO(param2[0]);
            return false;
         }
         if(param1 == SELECTED_PRICE_FIELD_NAME && param2 != null)
         {
            this.selectedPrice = new ItemPriceVO(param2[0]);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.currentPrice != null)
         {
            this.currentPrice.dispose();
            this.currentPrice = null;
         }
         if(this.selectedPrice != null)
         {
            this.selectedPrice.dispose();
            this.selectedPrice = null;
         }
         super.onDispose();
      }
   }
}
