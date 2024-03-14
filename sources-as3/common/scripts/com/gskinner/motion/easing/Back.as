package com.gskinner.motion.easing
{
   public class Back
   {
      
      protected static var s:Number = 1.70158;
       
      
      public function Back()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 * param1 * ((s + 1) * param1 - s);
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return (param1 = param1 - 1) * param1 * ((s + 1) * param1 + s) + 1;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return (param1 = Number(param1 * 2)) < 1 ? Number(0.5 * (param1 * param1 * ((s * 1.525 + 1) * param1 - s * 1.525))) : Number(0.5 * ((param1 = param1 - 2) * param1 * ((s * 1.525 + 1) * param1 + s * 1.525) + 2));
      }
   }
}
