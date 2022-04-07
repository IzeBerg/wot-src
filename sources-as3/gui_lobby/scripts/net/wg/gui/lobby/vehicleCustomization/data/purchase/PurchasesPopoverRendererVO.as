package net.wg.gui.lobby.vehicleCustomization.data.purchase
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class PurchasesPopoverRendererVO extends DAAPIDataClass
   {
      
      private static const SALE_PRICE_FIELD:String = "salePrice";
       
      
      public var name:String = "";
      
      public var isTitle:Boolean = false;
      
      public var price:String = "";
      
      public var currencyIcon:String = "";
      
      public var removeItemIcon:String = "";
      
      public var idx:Number = -1;
      
      public var type:Number = -1;
      
      public var itemID:Number = -1;
      
      private var _salePrice:ActionPriceVO = null;
      
      public function PurchasesPopoverRendererVO(param1:Object)
      {
         super(param1);
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
         if(this._salePrice)
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
      
      public function set salePrice(param1:ActionPriceVO) : void
      {
         this._salePrice = param1;
      }
   }
}
