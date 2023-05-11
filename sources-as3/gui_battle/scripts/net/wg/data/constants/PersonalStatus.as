package net.wg.data.constants
{
   public class PersonalStatus
   {
      
      public static const CAN_SEND_INVITE_TO_ALLY:uint = 1;
      
      public static const CAN_SEND_INVITE_TO_ENEMY:uint = 2;
      
      public static const SQUAD_RESTRICTIONS:uint = 4;
      
      public static const IS_VEHICLE_LEVEL_SHOWN:uint = 8;
      
      public static const IS_VEHICLE_COUNTER_SHOWN:uint = 16;
      
      public static const IS_COLOR_BLIND:uint = 32;
      
      public static const SHOW_ALLY_INVITES:uint = 64;
      
      public static const SHOW_ENEMY_INVITES:uint = 128;
       
      
      public function PersonalStatus()
      {
         super();
      }
      
      public static function isCanSendInviteToAlly(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.CAN_SEND_INVITE_TO_ALLY) > 0;
      }
      
      public static function isCanSendInviteToEnemy(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.CAN_SEND_INVITE_TO_ENEMY) > 0;
      }
      
      public static function isSquadRestrictions(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.SQUAD_RESTRICTIONS) > 0;
      }
      
      public static function isVehicleLevelShown(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.IS_VEHICLE_LEVEL_SHOWN) > 0;
      }
      
      public static function isVehicleCounterShown(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.IS_VEHICLE_COUNTER_SHOWN) > 0;
      }
      
      public static function isColorBlind(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.IS_COLOR_BLIND) > 0;
      }
      
      public static function isShowAllyInvites(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.SHOW_ALLY_INVITES) > 0;
      }
      
      public static function isShowEnemyInvites(param1:uint) : Boolean
      {
         return (param1 & PersonalStatus.SHOW_ENEMY_INVITES) > 0;
      }
   }
}
