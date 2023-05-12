package net.wg.data.constants
{
   public class InvalidationType
   {
      
      public static const VALID:uint = 0;
      
      public static const DATA:uint = 1;
      
      public static const SIZE:uint = 1 << 1;
      
      public static const STATE:uint = 1 << 2;
      
      public static const FI_STATE:uint = 1 << 3;
      
      public static const COLOR_SCHEME:uint = 1 << 4;
      
      public static const INVALID_TEXTFIELD_SELECTION:uint = 1 << 5;
      
      public static const POSITION:uint = 1 << 6;
      
      public static const SYSTEM_FLAGS_BORDER:uint = 1 << 16;
      
      public static const ALL:uint = uint.MAX_VALUE;
       
      
      public function InvalidationType()
      {
         super();
      }
   }
}
