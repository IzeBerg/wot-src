package net.wg.gui.components.controls.VO
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ItemPriceVO extends DAAPIDataClass
   {
      
      private static const PRICE_LBL:String = "price";
      
      private static const DEFPRICE_LBL:String = "defPrice";
      
      private static const ACTIONS_LBL:String = "action";
       
      
      public var price:CompoundPriceVO = null;
      
      public var defPrice:CompoundPriceVO = null;
      
      public var action:CompoundPriceVO = null;
      
      public function ItemPriceVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == PRICE_LBL || param1 == DEFPRICE_LBL || param1 == ACTIONS_LBL)
         {
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               this[param1] = new CompoundPriceVO(_loc3_);
            }
            else
            {
               App.utils.asserter.assert(false,Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function isEqual(param1:ItemPriceVO) : Boolean
      {
         return param1 != null && this.price.isEqual(param1.price) && this.defPrice.isEqual(param1.defPrice) && this.action.isEqual(param1.action);
      }
      
      override protected function onDispose() : void
      {
         if(this.price != null)
         {
            this.price.dispose();
            this.price = null;
         }
         if(this.defPrice != null)
         {
            this.defPrice.dispose();
            this.defPrice = null;
         }
         if(this.action != null)
         {
            this.action.dispose();
            this.action = null;
         }
         super.onDispose();
      }
   }
}
