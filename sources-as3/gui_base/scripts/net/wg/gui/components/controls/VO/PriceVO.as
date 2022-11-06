package net.wg.gui.components.controls.VO
{
   import net.wg.data.constants.Errors;
   
   public class PriceVO
   {
      
      private static const NAME_IDX:int = 0;
      
      private static const VALUE_IDX:int = 1;
      
      private static const MAX_ITEMS_COUNT:int = 2;
       
      
      public var name:String = "";
      
      public var value:Number = 0;
      
      public function PriceVO(param1:Array)
      {
         super();
         if(param1.length > MAX_ITEMS_COUNT)
         {
            App.utils.asserter.assert(false,Errors.WRONG_VALUE);
         }
         this.name = param1[NAME_IDX];
         var _loc2_:Number = param1[VALUE_IDX];
         if(!isNaN(_loc2_))
         {
            this.value = _loc2_;
         }
      }
      
      public function isEqual(param1:PriceVO) : Boolean
      {
         return param1 != null && this.name == param1.name && this.value == param1.value;
      }
      
      public function toString() : String
      {
         return "[PriceVO - " + this.name + ", value: " + this.value + "]";
      }
   }
}
