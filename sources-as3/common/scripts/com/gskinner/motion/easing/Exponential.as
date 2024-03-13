package com.gskinner.motion.easing
{
   public class Exponential
   {
       
      
      public function Exponential()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == 0 ? Number(0) : Number(Math.pow(2,10 * (param1 - 1)));
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 == 1 ? Number(1) : Number(1 - Math.pow(2,-10 * param1));
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0 || param1 == 1)
         {
            return param1;
         }
         if(0 > (param1 = param1 * 2 - 1))
         {
            return 0.5 * Math.pow(2,10 * param1);
         }
         return 1 - 0.5 * Math.pow(2,-10 * param1);
      }
   }
}
