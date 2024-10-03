package net.wg.gui.battle.views.vehicleMarkers
{
   public class VMAtlasItemName
   {
      
      public static const SPEAKING_ICON:String = "dynamic";
      
      public static const POI_MARKER_BACK_ICON:String = "poiMarkerBack";
      
      public static const SCENARIO_MARKER_ICON:String = "scenarioMarkerIcon";
      
      private static const SHADOW_PREFIX:String = "shadow_";
      
      private static const HUNTED_POSTFIX:String = "_hunted";
      
      private static const LEVEL_PREFIX:String = "vehicleLevel_";
      
      private static const SQUAD_ICON_PREFIX:String = "squadIcon_";
      
      private static const DAMAGE_BAR_PREFIX:String = "damageBar_";
      
      private static const ROLE_SKILL_LEVEL_PREFIX:String = "roleSkillLevel_";
      
      private static const POI_MARKER_ICON_PREFIX:String = "poiMarkerIcon_";
      
      private static const POI_MARKER_ICON_SMALL_PREFIX:String = "poiMarkerIconSmall_";
      
      private static const STATUS_MARKER_PREFIX:String = "sm_";
      
      private static const STATUS_MARKER_GLOW_PREFIX:String = "sm_glow_";
      
      private static const STATUS_MARKER_WAVE_PREFIX:String = "sm_wave_";
      
      private static const EMPTY_STR:String = "";
      
      private static const UNDERSCORE_STR:String = "_";
       
      
      public function VMAtlasItemName()
      {
         super();
      }
      
      public static function getShadowName(param1:int) : String
      {
         return SHADOW_PREFIX + (param1 == 1 || param1 == 3 ? 1 : 2);
      }
      
      public static function getVehicleTypeIconName(param1:String, param2:String, param3:Boolean) : String
      {
         return param1 + UNDERSCORE_STR + param2 + (!!param3 ? HUNTED_POSTFIX : EMPTY_STR);
      }
      
      public static function getLevelIconName(param1:int) : String
      {
         return LEVEL_PREFIX + param1;
      }
      
      public static function getSquadIconName(param1:String, param2:int) : String
      {
         return SQUAD_ICON_PREFIX + param1 + param2;
      }
      
      public static function getDamageBarName(param1:String) : String
      {
         return DAMAGE_BAR_PREFIX + param1;
      }
      
      public static function getHitAnimationName(param1:String) : String
      {
         return param1;
      }
      
      public static function getRoleSkillLevelName(param1:int) : String
      {
         return ROLE_SKILL_LEVEL_PREFIX + param1;
      }
      
      public static function getPOIMarkerIconByType(param1:uint, param2:Boolean = false) : String
      {
         if(param2)
         {
            return POI_MARKER_ICON_SMALL_PREFIX + param1;
         }
         return POI_MARKER_ICON_PREFIX + param1;
      }
      
      public static function getStatusMarkerIcon(param1:String, param2:String) : String
      {
         return STATUS_MARKER_PREFIX + param1 + UNDERSCORE_STR + param2;
      }
      
      public static function getStatusMarkerGlow(param1:String) : String
      {
         return STATUS_MARKER_GLOW_PREFIX + param1;
      }
      
      public static function getStatusMarkerWave(param1:String) : String
      {
         return STATUS_MARKER_WAVE_PREFIX + param1;
      }
   }
}
