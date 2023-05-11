package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.lobby.vehicleCustomization.data.PriceRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PriceItemRenderer extends UIComponentEx
   {
      
      private static const PRICE_OFFSET:int = 5;
       
      
      public var actionPrice:ActionPrice = null;
      
      public var price:TextField = null;
      
      private var _data:PriceRendererVO = null;
      
      public function PriceItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setup();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.setup();
         }
      }
      
      override protected function onDispose() : void
      {
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.price = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:PriceRendererVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      private function setup() : void
      {
         if(this._data != null)
         {
            DebugUtils.LOG_DEBUG(this._data);
            this.actionPrice.setData(this._data.salePrice);
            this.price.htmlText = this._data.label;
            this.price.visible = !this._data.isSale;
            this.actionPrice.validateNow();
         }
      }
   }
}
