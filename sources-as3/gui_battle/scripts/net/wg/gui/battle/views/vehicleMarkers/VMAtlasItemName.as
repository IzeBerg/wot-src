package net.wg.gui.battle.views.vehicleMarkers
{
   public class VMAtlasItemName
   {
      
      public static const SPEAKING_ICON:String = "dynamic";
      
      private static const SHADOW_PREFIX:String = "shadow_";
      
      private static const HUNTED_POSTFIX:String = "_hunted";
      
      private static const LEVEL_PREFIX:String = "vehicleLevel_";
      
      private static const SQUAD_ICON_PREFIX:String = "squadIcon_";
      
      private static const DAMAGE_BAR_PREFIX:String = "damageBar_";
      
      private static const PNG_EXT:String = "";
      
      private static const UNDERSCORE_STR:String = "_";
       
      
      public function VMAtlasItemName()
      {
         super();
      }
      
      public static function getShadowName(param1:int) : String
      {
         return SHADOW_PREFIX + (param1 == 1 || param1 == 3 ? 1 : 2) + PNG_EXT;
      }
      
      public static function getVehicleTypeIconName(param1:String, param2:String, param3:Boolean) : String
      {
         return param1 + UNDERSCORE_STR + param2 + (!!param3 ? HUNTED_POSTFIX : "") + PNG_EXT;
      }
      
      public static function getLevelIconName(param1:int) : String
      {
         return LEVEL_PREFIX + param1 + PNG_EXT;
      }
      
      public static function getSquadIconName(param1:String, param2:int) : String
      {
         return SQUAD_ICON_PREFIX + param1 + param2 + PNG_EXT;
      }
      
      public static function getDamageBarName(param1:String) : String
      {
         return DAMAGE_BAR_PREFIX + param1 + PNG_EXT;
      }
      
      public static function getHitAnimationName(param1:String) : String
      {
         return param1 + PNG_EXT;
      }
   }
}
