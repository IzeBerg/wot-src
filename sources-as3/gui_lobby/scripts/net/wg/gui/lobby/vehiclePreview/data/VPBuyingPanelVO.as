package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class VPBuyingPanelVO extends DAAPIDataClass
   {
      
      private static const ITEM_PRICE_DATA_FIELD_NAME:String = "itemPrice";
      
      private static const COMPENSATION_FIELD_NAME:String = "compensation";
       
      
      public var setTitle:String = "";
      
      public var uniqueVehicleTitle:String = "";
      
      public var isReferralEnabled:Boolean = false;
      
      public var isMoneyEnough:Boolean = false;
      
      public var buyButtonEnabled:Boolean = false;
      
      public var buyButtonLabel:String = "";
      
      public var buyButtonIcon:String = "";
      
      public var buyButtonIconAlign:String = "";
      
      public var buyButtonTooltip:String = "";
      
      public var isShowSpecialTooltip:Boolean = false;
      
      public var isBuyingAvailable:Boolean = false;
      
      public var isUnlock:Boolean = false;
      
      public var showAction:Boolean = false;
      
      public var warning:String = "";
      
      public var hasCompensation:Boolean = false;
      
      public var itemPrice:ItemPriceVO = null;
      
      public var couponDiscount:int = 0;
      
      public var actionTooltip:String = "";
      
      public var compensation:VPCompensationVO = null;
      
      public var vehicleId:Number = -1;
      
      public var customOffer:String = "";
      
      public function VPBuyingPanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ITEM_PRICE_DATA_FIELD_NAME && param2 is Array)
         {
            this.itemPrice = new ItemPriceVO(param2[0]);
            return false;
         }
         if(param1 == COMPENSATION_FIELD_NAME && param2)
         {
            this.compensation = new VPCompensationVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.compensation != null)
         {
            this.compensation.dispose();
            this.compensation = null;
         }
         if(this.itemPrice)
         {
            this.itemPrice.dispose();
            this.itemPrice = null;
         }
         super.onDispose();
      }
   }
}
