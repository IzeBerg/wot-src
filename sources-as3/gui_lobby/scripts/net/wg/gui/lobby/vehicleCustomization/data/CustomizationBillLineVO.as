package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   
   public class CustomizationBillLineVO extends DAAPIDataClass
   {
      
      private static const COMPOUND_PRICE:String = "compoundPrice";
      
      private static const IS_ENOUGH_STATUSES:String = "isEnoughStatuses";
       
      
      public var label:String = "";
      
      public var icon:String = "";
      
      private var _compoundPrice:ItemPriceVO = null;
      
      private var _isEnoughStatuses:Vector.<PriceVO> = null;
      
      public function CustomizationBillLineVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         if(param1 == COMPOUND_PRICE)
         {
            if(param2)
            {
               this._compoundPrice = new ItemPriceVO(param2);
            }
            return false;
         }
         if(IS_ENOUGH_STATUSES == param1)
         {
            if(param2)
            {
               if(this._isEnoughStatuses && this._isEnoughStatuses.length > 0)
               {
                  this._isEnoughStatuses.length = 0;
               }
               else
               {
                  this._isEnoughStatuses = new Vector.<PriceVO>();
               }
               _loc3_ = param2 as Array;
               if(_loc3_ != null)
               {
                  for each(_loc4_ in _loc3_)
                  {
                     this._isEnoughStatuses.push(new PriceVO(_loc4_));
                  }
               }
               else
               {
                  App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._compoundPrice)
         {
            this._compoundPrice.dispose();
            this._compoundPrice = null;
         }
         if(this._isEnoughStatuses)
         {
            this._isEnoughStatuses.length = 0;
            this._isEnoughStatuses = null;
         }
         super.onDispose();
      }
      
      public function get isEnoughStatuses() : Vector.<PriceVO>
      {
         return this._isEnoughStatuses;
      }
      
      public function get compoundPrice() : ItemPriceVO
      {
         return this._compoundPrice;
      }
   }
}
