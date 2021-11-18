package net.wg.gui.lobby.shop.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   
   public class RentalTermSlotButtonVO extends DAAPIDataClass
   {
      
      private static const PRICE:String = "price";
      
      private static const IS_ENOUGH_STATUSES:String = "isEnoughStatuses";
       
      
      public var label:String = "";
      
      public var price:ItemPriceVO;
      
      public var enabled:Boolean;
      
      public var selected:Boolean;
      
      public var itemId:int;
      
      public var isEnoughStatuses:Vector.<PriceVO>;
      
      public function RentalTermSlotButtonVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         if(PRICE == param1)
         {
            this.price = new ItemPriceVO(param2[0]);
            return false;
         }
         if(IS_ENOUGH_STATUSES == param1)
         {
            if(this.isEnoughStatuses && this.isEnoughStatuses.length > 0)
            {
               this.isEnoughStatuses.splice(0,this.isEnoughStatuses.length);
            }
            else
            {
               this.isEnoughStatuses = new Vector.<PriceVO>();
            }
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               for each(_loc4_ in _loc3_)
               {
                  this.isEnoughStatuses.push(new PriceVO(_loc4_));
               }
            }
            else
            {
               App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.price.dispose();
         this.price = null;
         super.onDispose();
      }
   }
}
