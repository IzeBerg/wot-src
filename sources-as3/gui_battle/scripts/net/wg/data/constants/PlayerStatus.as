package net.wg.data.constants
{
   public class PlayerStatus
   {
      
      public static const DEFAULT:uint = 0;
      
      public static const IS_TEAM_KILLER:uint = 1;
      
      public static const IS_SQUAD_MAN:uint = 2;
      
      public static const IS_SQUAD_PERSONAL:uint = 4;
      
      public static const IS_PLAYER_SELECTED:uint = 8;
      
      public static const IS_VOIP_DISABLED:uint = 16;
      
      public static const IS_ACTION_DISABLED:uint = 32;
       
      
      public function PlayerStatus()
      {
         super();
      }
      
      public static function isVoipDisabled(param1:uint) : Boolean
      {
         return (param1 & IS_VOIP_DISABLED) > 0;
      }
      
      public static function isActionDisabled(param1:uint) : Boolean
      {
         return (param1 & IS_ACTION_DISABLED) > 0;
      }
      
      public static function isSelected(param1:uint) : Boolean
      {
         return (param1 & IS_PLAYER_SELECTED) > 0;
      }
   }
}
