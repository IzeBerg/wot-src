package net.wg.data.constants
{
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   
   public class Currencies extends CURRENCIES_CONSTANTS
   {
      
      public static const DISABLED_COLOR:Number = 5197640;
      
      public static const ERROR_COLOR:Number = 16721687;
      
      public static const TEXT_COLORS:Object = {
         "credits":CREDITS_COLOR,
         "gold":GOLD_COLOR,
         "disabled":DISABLED_COLOR,
         "error":ERROR_COLOR,
         "crystal":CRYSTAL_COLOR
      };
      
      public static const NAME_FROM_INDEX:Array = [CREDITS,GOLD,CRYSTAL];
      
      public static const INDEX_FROM_NAME:Object = {
         "credits":CREDITS_INDEX,
         "gold":GOLD_INDEX,
         "crystal":CRYSTAL_INDEX
      };
      
      private static const ERROR_POSTFIX:String = "Error";
       
      
      public function Currencies()
      {
         super();
      }
      
      public static function getErrorState(param1:String) : String
      {
         return param1 + ERROR_POSTFIX;
      }
      
      public static function checkSeveralPrices(param1:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            if(_loc3_ > 0)
            {
               _loc2_++;
            }
         }
         return _loc2_ > 1;
      }
   }
}
