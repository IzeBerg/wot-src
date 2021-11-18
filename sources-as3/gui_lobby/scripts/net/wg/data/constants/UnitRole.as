package net.wg.data.constants
{
   public class UnitRole
   {
      
      public static const DEFAULT:uint = 0;
      
      public static const INVITED:uint = 1 << 0;
      
      public static const COMMANDER_UPDATES:uint = 1 << 1;
      
      public static const CHANGE_ROSTER:uint = 1 << 2;
      
      public static const LEGIONARY:uint = 1 << 4;
      
      public static const MANAGER:uint = 1 << 5;
      
      public static const IN_ARENA:uint = 1 << 6;
      
      public static const OFFLINE:uint = 1 << 7;
      
      public static const CAN_LEAD:uint = 1 << 8;
      
      public static const AUTO_SEARCH:uint = 1 << 9;
      
      public static const CAN_USE_EXTRA_EQUIPMENTS:uint = 1 << 10;
      
      public static const START_STOP_BATTLE:uint = CHANGE_ROSTER;
      
      public static const ADD_REMOVE_MEMBERS:uint = CHANGE_ROSTER;
      
      public static const INVITE_KICK_PLAYERS:uint = CHANGE_ROSTER;
      
      public static const CREATOR:uint = COMMANDER_UPDATES | CHANGE_ROSTER;
      
      public static const CHANGE_LEADERSHIP:uint = CREATOR | MANAGER;
      
      public static const SOCIAL_ROLES:uint = LEGIONARY | MANAGER | CAN_LEAD;
      
      public static const SELF_ONLY:uint = 1 << 16;
      
      public static const SELF_UNLOCKED:uint = 1 << 17;
      
      public static const NON_IDLE:uint = 1 << 18;
      
      public static const NO_LEGIONARY_CANDIDATES:uint = 1 << 19;
      
      public static const PRE_ARENA:uint = 1 << 20;
       
      
      public function UnitRole()
      {
         super();
      }
   }
}
