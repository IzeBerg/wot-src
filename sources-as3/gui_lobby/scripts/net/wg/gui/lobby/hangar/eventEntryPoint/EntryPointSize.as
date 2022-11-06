package net.wg.gui.lobby.hangar.eventEntryPoint
{
   public class EntryPointSize
   {
      
      public static const WIDE_MASK:int = 1;
      
      public static const EXTRA_SMALL:int = 1 << 1;
      
      public static const SMALL:int = 1 << 2;
      
      public static const MEDIUM:int = 1 << 3;
      
      public static const BIG:int = 1 << 4;
       
      
      public function EntryPointSize()
      {
         super();
      }
      
      public static function isWide(param1:int) : Boolean
      {
         return Boolean(WIDE_MASK & param1);
      }
      
      public static function isExtraSmall(param1:int) : Boolean
      {
         return Boolean(EXTRA_SMALL & param1);
      }
      
      public static function isSmall(param1:int) : Boolean
      {
         return Boolean(SMALL & param1);
      }
      
      public static function isBig(param1:int) : Boolean
      {
         return Boolean(BIG & param1);
      }
   }
}
