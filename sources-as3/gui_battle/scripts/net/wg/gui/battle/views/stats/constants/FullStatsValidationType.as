package net.wg.gui.battle.views.stats.constants
{
   import net.wg.data.constants.InvalidationType;
   
   public class FullStatsValidationType
   {
      
      public static const USER_PROPS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      public static const FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      public static const SELECTED:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      public static const COLORS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      public static const VEHICLE_NAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;
      
      public static const VEHICLE_TYPE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;
      
      public static const IS_IGR:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 7;
      
      public static const BADGE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 8;
      
      public static const SYSTEM_FLAGS_BORDER:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 9;
      
      public static const RANK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 10;
      
      public static const LANE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 11;
      
      public static const SUFFIXBAGE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 12;
       
      
      public function FullStatsValidationType()
      {
         super();
      }
   }
}
