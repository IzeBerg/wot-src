package com.gskinner.motion.easing
{
   public class Sine
   {
       
      
      public function Sine()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return 1 - Math.cos(param1 * (Math.PI / 2));
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return Math.sin(param1 * (Math.PI / 2));
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return -0.5 * (Math.cos(param1 * Math.PI) - 1);
      }
   }
}
