package net.wg.data.constants.generated
{
   public class DIGITS
   {
      
      public static const SIZE_220X220_DIGIT_0:String = "size_220x220_digit_0";
      
      public static const SIZE_220X220_DIGIT_1:String = "size_220x220_digit_1";
      
      public static const SIZE_220X220_DIGIT_2:String = "size_220x220_digit_2";
      
      public static const SIZE_220X220_DIGIT_3:String = "size_220x220_digit_3";
      
      public static const SIZE_220X220_DIGIT_4:String = "size_220x220_digit_4";
      
      public static const SIZE_220X220_DIGIT_5:String = "size_220x220_digit_5";
      
      public static const SIZE_220X220_DIGIT_6:String = "size_220x220_digit_6";
      
      public static const SIZE_220X220_DIGIT_7:String = "size_220x220_digit_7";
      
      public static const SIZE_220X220_DIGIT_8:String = "size_220x220_digit_8";
      
      public static const SIZE_220X220_DIGIT_9:String = "size_220x220_digit_9";
      
      public static const SIZE_24X24_DIGIT_0:String = "size_24x24_digit_0";
      
      public static const SIZE_24X24_DIGIT_1:String = "size_24x24_digit_1";
      
      public static const SIZE_24X24_DIGIT_2:String = "size_24x24_digit_2";
      
      public static const SIZE_24X24_DIGIT_3:String = "size_24x24_digit_3";
      
      public static const SIZE_24X24_DIGIT_4:String = "size_24x24_digit_4";
      
      public static const SIZE_24X24_DIGIT_5:String = "size_24x24_digit_5";
      
      public static const SIZE_24X24_DIGIT_6:String = "size_24x24_digit_6";
      
      public static const SIZE_24X24_DIGIT_7:String = "size_24x24_digit_7";
      
      public static const SIZE_24X24_DIGIT_8:String = "size_24x24_digit_8";
      
      public static const SIZE_24X24_DIGIT_9:String = "size_24x24_digit_9";
      
      public static const SIZE_48X48_DIGIT_0:String = "size_48x48_digit_0";
      
      public static const SIZE_48X48_DIGIT_1:String = "size_48x48_digit_1";
      
      public static const SIZE_48X48_DIGIT_2:String = "size_48x48_digit_2";
      
      public static const SIZE_48X48_DIGIT_3:String = "size_48x48_digit_3";
      
      public static const SIZE_48X48_DIGIT_4:String = "size_48x48_digit_4";
      
      public static const SIZE_48X48_DIGIT_5:String = "size_48x48_digit_5";
      
      public static const SIZE_48X48_DIGIT_6:String = "size_48x48_digit_6";
      
      public static const SIZE_48X48_DIGIT_7:String = "size_48x48_digit_7";
      
      public static const SIZE_48X48_DIGIT_8:String = "size_48x48_digit_8";
      
      public static const SIZE_48X48_DIGIT_9:String = "size_48x48_digit_9";
      
      public static const SIZE_80X80_DIGIT_0:String = "size_80x80_digit_0";
      
      public static const SIZE_80X80_DIGIT_1:String = "size_80x80_digit_1";
      
      public static const SIZE_80X80_DIGIT_2:String = "size_80x80_digit_2";
      
      public static const SIZE_80X80_DIGIT_3:String = "size_80x80_digit_3";
      
      public static const SIZE_80X80_DIGIT_4:String = "size_80x80_digit_4";
      
      public static const SIZE_80X80_DIGIT_5:String = "size_80x80_digit_5";
      
      public static const SIZE_80X80_DIGIT_6:String = "size_80x80_digit_6";
      
      public static const SIZE_80X80_DIGIT_7:String = "size_80x80_digit_7";
      
      public static const SIZE_80X80_DIGIT_8:String = "size_80x80_digit_8";
      
      public static const SIZE_80X80_DIGIT_9:String = "size_80x80_digit_9";
      
      public static const SIZE_ALL_DIGIT_ENUM:Array = [SIZE_220X220_DIGIT_0,SIZE_220X220_DIGIT_1,SIZE_220X220_DIGIT_2,SIZE_220X220_DIGIT_3,SIZE_220X220_DIGIT_4,SIZE_220X220_DIGIT_5,SIZE_220X220_DIGIT_6,SIZE_220X220_DIGIT_7,SIZE_220X220_DIGIT_8,SIZE_220X220_DIGIT_9,SIZE_24X24_DIGIT_0,SIZE_24X24_DIGIT_1,SIZE_24X24_DIGIT_2,SIZE_24X24_DIGIT_3,SIZE_24X24_DIGIT_4,SIZE_24X24_DIGIT_5,SIZE_24X24_DIGIT_6,SIZE_24X24_DIGIT_7,SIZE_24X24_DIGIT_8,SIZE_24X24_DIGIT_9,SIZE_48X48_DIGIT_0,SIZE_48X48_DIGIT_1,SIZE_48X48_DIGIT_2,SIZE_48X48_DIGIT_3,SIZE_48X48_DIGIT_4,SIZE_48X48_DIGIT_5,SIZE_48X48_DIGIT_6,SIZE_48X48_DIGIT_7,SIZE_48X48_DIGIT_8,SIZE_48X48_DIGIT_9,SIZE_80X80_DIGIT_0,SIZE_80X80_DIGIT_1,SIZE_80X80_DIGIT_2,SIZE_80X80_DIGIT_3,SIZE_80X80_DIGIT_4,SIZE_80X80_DIGIT_5,SIZE_80X80_DIGIT_6,SIZE_80X80_DIGIT_7,SIZE_80X80_DIGIT_8,SIZE_80X80_DIGIT_9];
       
      
      public function DIGITS()
      {
         super();
      }
      
      public static function getDigitIcon(param1:String, param2:String) : String
      {
         var _loc3_:String = "size_" + param1 + "_digit_" + param2;
         if(SIZE_ALL_DIGIT_ENUM.indexOf(_loc3_) == -1)
         {
            DebugUtils.LOG_WARNING("[getDigitIcon]:atlas key \"" + _loc3_ + "\" was not found");
            return null;
         }
         return _loc3_;
      }
   }
}
