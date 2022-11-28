package net.wg.data.constants
{
   public class FragCorrelationBarStatus
   {
      
      public static const SHOW_TEAM_HP_VALUES:uint = 1;
      
      public static const SHOW_HP_DIFFERENCE:uint = 2;
      
      public static const SHOW_TIER_GROUPING:uint = 4;
      
      public static const HIDE_VEHICLE_ICONS:uint = 8;
      
      public static const SHOW_TEAM_HP_BAR:uint = 16;
       
      
      public function FragCorrelationBarStatus()
      {
         super();
      }
      
      public static function isShowTeamHPBar(param1:uint) : Boolean
      {
         return (param1 & FragCorrelationBarStatus.SHOW_TEAM_HP_BAR) > 0;
      }
      
      public static function isShowTeamHPValues(param1:uint) : Boolean
      {
         return (param1 & FragCorrelationBarStatus.SHOW_TEAM_HP_VALUES) > 0;
      }
      
      public static function isShowHPDifferenceValues(param1:uint) : Boolean
      {
         return (param1 & FragCorrelationBarStatus.SHOW_HP_DIFFERENCE) > 0;
      }
      
      public static function isShowTierGrouping(param1:uint) : Boolean
      {
         return (param1 & FragCorrelationBarStatus.SHOW_TIER_GROUPING) > 0;
      }
      
      public static function isHideVehicleIcons(param1:uint) : Boolean
      {
         return (param1 & FragCorrelationBarStatus.HIDE_VEHICLE_ICONS) > 0;
      }
   }
}
