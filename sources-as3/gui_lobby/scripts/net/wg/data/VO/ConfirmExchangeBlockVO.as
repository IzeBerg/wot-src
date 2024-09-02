package net.wg.data.VO
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.window.ExchangeHeaderVO;
   
   public class ConfirmExchangeBlockVO extends DAAPIDataClass
   {
      
      private static const EXCHANGE_HEADER_DATA:String = "exchangeHeaderData";
       
      
      public var needItemsStepperTitle:String = "";
      
      public var goldStepperTitle:String = "";
      
      public var needItemsIcon:String = "";
      
      public var goldIcon:String = "";
      
      public var defaultExchangeRate:int = -1;
      
      public var exchangeRate:int = -1;
      
      public var goldStepSize:Number = -1;
      
      public var defaultGoldValue:Number = -1;
      
      public var maxGoldValue:Number = -1;
      
      public var maxNeedItemsValue:int = -1;
      
      public var goldTextColorId:String = "";
      
      public var itemsTextColorId:String = "";
      
      public var discountLimit:int = -1;
      
      public var isDiscountLimited:Boolean = false;
      
      public var discountLimitText:String = "";
      
      public var discountLimitOverExceededText:String = "";
      
      public var discountsAmountLimitExceed:Boolean = false;
      
      public var limitRestrictionsBtnText:String = "";
      
      public var isDiscountAvailable:Boolean = false;
      
      public var maxDiscountsAppliedForMoreInfo:uint = 5;
      
      public var exchangeHeaderData:ExchangeHeaderVO = null;
      
      public function ConfirmExchangeBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == EXCHANGE_HEADER_DATA)
         {
            App.utils.asserter.assertNotNull(param2,EXCHANGE_HEADER_DATA + Errors.CANT_NULL);
            this.exchangeHeaderData = new ExchangeHeaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.exchangeHeaderData.dispose();
         this.exchangeHeaderData = null;
         super.onDispose();
      }
   }
}
