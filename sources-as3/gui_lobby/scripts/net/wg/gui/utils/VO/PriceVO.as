package net.wg.gui.utils.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PriceVO extends DAAPIDataClass
   {
      
      private static const GOLD_IDX:int = 1;
      
      private static const CREDITS_IDX:int = 0;
      
      private static const PRICE_LABEL:String = "price";
       
      
      private var _priceFull:Array = null;
      
      public var price:uint = 0;
      
      public var isGold:Boolean = false;
      
      public function PriceVO(param1:Object)
      {
         super(param1);
      }
      
      override public function fromHash(param1:Object) : void
      {
         if(param1 is Array)
         {
            this.priceFull = param1 as Array;
            App.utils.asserter.assertNotNull(this.priceFull,"Must be an Array");
         }
         else
         {
            super.fromHash(param1);
         }
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PRICE_LABEL)
         {
            this.priceFull = param2 as Array;
            App.utils.asserter.assertNotNull(this.priceFull,"Must be an Array");
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      public function get priceFull() : Array
      {
         return this._priceFull;
      }
      
      public function set priceFull(param1:Array) : void
      {
         this._priceFull = param1;
         this.isGold = this.priceFull[GOLD_IDX] > 0;
         this.price = !!this.isGold ? uint(this.priceFull[GOLD_IDX]) : uint(this.priceFull[CREDITS_IDX]);
      }
   }
}
