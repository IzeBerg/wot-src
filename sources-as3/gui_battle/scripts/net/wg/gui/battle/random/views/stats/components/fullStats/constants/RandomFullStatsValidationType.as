package net.wg.gui.battle.random.views.stats.components.fullStats.constants
{
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   
   public class RandomFullStatsValidationType
   {
      
      public static const PLAYER_STATUS:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 1;
      
      public static const VEHICLE_ACTION:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 2;
      
      public static const VEHICLE_ICON:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 3;
      
      public static const VEHICLE_LEVEL:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 4;
      
      public static const MUTE:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 5;
      
      public static const SPEAKING:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 6;
      
      public static const DISABLE_COMMUNICATION:uint = FullStatsValidationType.SYSTEM_FLAGS_BORDER << 7;
       
      
      public function RandomFullStatsValidationType()
      {
         super();
      }
   }
}
