package com.gskinner.motion.easing
{
   public class Bounce
   {
       
      
      public function Bounce()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return 1 - easeOut(1 - param1,0,0,0);
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         if(param1 < 1 / 2.75)
         {
            return 7.5625 * param1 * param1;
         }
         if(param1 < 2 / 2.75)
         {
            return 7.5625 * (param1 = param1 - 1.5 / 2.75) * param1 + 0.75;
         }
         if(param1 < 2.5 / 2.75)
         {
            return 7.5625 * (param1 = param1 - 2.25 / 2.75) * param1 + 0.9375;
         }
         return 7.5625 * (param1 = param1 - 2.625 / 2.75) * param1 + 0.984375;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return (param1 = Number(param1 * 2)) < 1 ? Number(0.5 * easeIn(param1,0,0,0)) : Number(0.5 * easeOut(param1 - 1,0,0,0) + 0.5);
      }
   }
}
