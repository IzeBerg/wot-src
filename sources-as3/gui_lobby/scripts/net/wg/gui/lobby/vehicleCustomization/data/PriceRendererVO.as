package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class PriceRendererVO extends DAAPIDataClass
   {
      
      private static const SALE_PRICE_FIELD:String = "salePrice";
       
      
      public var label:String = "";
      
      public var labelPrice:String = "";
      
      public var isSale:Boolean = false;
      
      private var _salePrice:ActionPriceVO = null;
      
      public function PriceRendererVO(param1:Object)
      {
         super(param1);
         if(this.isSale)
         {
            App.utils.asserter.assertNotNull(this._salePrice,"SalePrice cannot be null!");
         }
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SALE_PRICE_FIELD)
         {
            this._salePrice = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._salePrice != null)
         {
            this._salePrice.dispose();
            this._salePrice = null;
         }
         super.onDispose();
      }
      
      public function get salePrice() : ActionPriceVO
      {
         return this._salePrice;
      }
   }
}
