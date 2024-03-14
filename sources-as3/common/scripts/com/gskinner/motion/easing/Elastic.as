package com.gskinner.motion.easing
{
   public class Elastic
   {
      
      protected static var a:Number = 1;
      
      protected static var p:Number = 0.3;
      
      protected static var s:Number = p / 4;
       
      
      public function Elastic()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0 || param1 == 1)
         {
            return param1;
         }
         return -(a * Math.pow(2,10 * (param1 = param1 - 1)) * Math.sin((param1 - s) * (2 * Math.PI) / p));
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0 || param1 == 1)
         {
            return param1;
         }
         return a * Math.pow(2,-10 * param1) * Math.sin((param1 - s) * (2 * Math.PI) / p) + 1;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 == 0 || param1 == 1)
         {
            return param1;
         }
         param1 = param1 * 2 - 1;
         if(param1 < 0)
         {
            return -0.5 * (a * Math.pow(2,10 * param1) * Math.sin((param1 - s * 1.5) * (2 * Math.PI) / (p * 1.5)));
         }
         return 0.5 * a * Math.pow(2,-10 * param1) * Math.sin((param1 - s * 1.5) * (2 * Math.PI) / (p * 1.5)) + 1;
      }
   }
}
