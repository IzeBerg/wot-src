package com.gskinner.motion.easing
{
   public class Cubic
   {
       
      
      public function Cubic()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 * param1 * param1;
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return (param1 = param1 - 1) * param1 * param1 + 1;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 < 0.5 ? Number(4 * param1 * param1 * param1) : Number(4 * (param1 = param1 - 1) * param1 * param1 + 1);
      }
   }
}
