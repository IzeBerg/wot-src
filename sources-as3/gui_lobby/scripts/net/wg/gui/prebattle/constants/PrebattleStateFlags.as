package net.wg.gui.prebattle.constants
{
   public class PrebattleStateFlags
   {
      
      public static var UNKNOWN:uint = 0;
      
      public static var NOT_READY:uint = 1;
      
      public static var AFK:uint = 2 | PrebattleStateFlags.NOT_READY;
      
      public static var READY:uint = 4;
      
      public static var IN_BATTLE:uint = 8;
      
      public static var OFFLINE:uint = 16;
       
      
      public function PrebattleStateFlags()
      {
         super();
      }
   }
}
