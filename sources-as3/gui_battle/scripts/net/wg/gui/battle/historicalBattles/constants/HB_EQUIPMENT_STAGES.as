package net.wg.gui.battle.historicalBattles.constants
{
   import net.wg.data.constants.InteractiveStates;
   
   public class HB_EQUIPMENT_STAGES
   {
      
      private static const STATE_MAP:Object = {};
      
      public static const NOT_RUNNING:int = 0;
      
      public static const DEPLOYING:int = 1;
      
      public static const UNAVAILABLE:int = 2;
      
      public static const READY:int = 3;
      
      public static const PREPARING:int = 4;
      
      public static const ACTIVE:int = 5;
      
      public static const COOLDOWN:int = 6;
      
      public static const SHARED_COOLDOWN:int = 7;
      
      public static const EXHAUSTED:int = 255;
      
      {
         STATE_MAP[NOT_RUNNING] = InteractiveStates.DISABLED;
         STATE_MAP[UNAVAILABLE] = InteractiveStates.DISABLED;
         STATE_MAP[READY] = InteractiveStates.UP;
         STATE_MAP[ACTIVE] = InteractiveStates.UP;
         STATE_MAP[COOLDOWN] = InteractiveStates.DISABLED;
      }
      
      public function HB_EQUIPMENT_STAGES()
      {
         super();
      }
      
      public static function getState(param1:int) : String
      {
         return STATE_MAP[param1] || InteractiveStates.UP;
      }
   }
}
