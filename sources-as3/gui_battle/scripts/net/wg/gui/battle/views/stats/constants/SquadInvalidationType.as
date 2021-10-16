package net.wg.gui.battle.views.stats.constants
{
   import net.wg.data.constants.InvalidationType;
   
   public class SquadInvalidationType
   {
      
      public static const ACTIVE_MOUSE_OVER:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      public static const SQUAD_INDEX:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      public static const SQUAD_NO_SOUND:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
       
      
      public function SquadInvalidationType()
      {
         super();
      }
   }
}
