package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class VPShowcaseStyleBuyingVO extends DAAPIDataClass
   {
      
      private static const CURRENCY_TO_ICON_TYPES_MAP:Object = {};
      
      {
         CURRENCY_TO_ICON_TYPES_MAP[CURRENCIES_CONSTANTS.GOLD] = IconsTypes.GOLD_BIG;
         CURRENCY_TO_ICON_TYPES_MAP[CURRENCIES_CONSTANTS.CREDITS] = IconsTypes.CREDITS_BIG;
         CURRENCY_TO_ICON_TYPES_MAP[CURRENCIES_CONSTANTS.CRYSTAL] = IconsTypes.CRYSTAL;
         CURRENCY_TO_ICON_TYPES_MAP[CURRENCIES_CONSTANTS.WDR_COIN] = IconsTypes.WDR_COIN;
         CURRENCY_TO_ICON_TYPES_MAP[CURRENCIES_CONSTANTS.BPBIT] = IconsTypes.BPBIT;
      }
      
      public var originalPrice:int = 0;
      
      public var price:int = 0;
      
      public var discountPercent:int = 0;
      
      public var timeRemainingStr:String = "";
      
      public var isBought:Boolean = false;
      
      public var isNoVehicle:Boolean = false;
      
      public var actionBtnEnabled:Boolean = false;
      
      public var actionBtnTooltip:String = "";
      
      public var actionPrice:ActionPriceVO = null;
      
      public var actionBtnLabel:String = "";
      
      private var _priceType:String;
      
      public function VPShowcaseStyleBuyingVO(param1:Object)
      {
         this._priceType = IconsTypes.GOLD_BIG;
         super(param1);
         if(this.discountPercent > 0 && !this.actionPrice)
         {
            this.actionPrice = new ActionPriceVO();
            this.actionPrice.newPrice = -this.discountPercent;
            this.actionPrice.oldPrice = this.originalPrice;
            this.actionPrice.ico = this._priceType;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.actionPrice != null)
         {
            this.actionPrice.dispose();
            this.actionPrice = null;
         }
         super.onDispose();
      }
      
      public function get priceType() : String
      {
         return this._priceType;
      }
      
      public function set priceType(param1:String) : void
      {
         this._priceType = CURRENCY_TO_ICON_TYPES_MAP[param1];
      }
   }
}
