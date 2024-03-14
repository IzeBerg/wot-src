package com.gskinner.motion.easing
{
   public class Circular
   {
       
      
      public function Circular()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -(Math.sqrt(1 - param1 * param1) - 1);
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.sqrt(1 - (param1 - 1) * (param1 - 1));
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return (param1 = Number(param1 * 2)) < 1 ? Number(-0.5 * (Math.sqrt(1 - param1 * param1) - 1)) : Number(0.5 * (Math.sqrt(1 - (param1 = param1 - 2) * param1) + 1));
      }
   }
}
