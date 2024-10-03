package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_MARKER_ABILITIES_CONSTS;
   import net.wg.data.constants.generated.BATTLE_MARKER_STATES;
   import net.wg.data.constants.generated.COMP7_CONSTS;
   
   public class VehicleMarkersConstants
   {
      
      public static const ENTITY_NAME_ALLY:String = "ally";
      
      public static const ENTITY_NAME_ENEMY:String = "enemy";
      
      public static const ENTITY_NAME_SQUADMAN:String = "squadman";
      
      public static const ENTITY_TYPE_ALLY:String = "ally";
      
      public static const ENTITY_TYPE_ENEMY:String = "enemy";
      
      public static const COLOR_GREEN:String = "green";
      
      public static const COLOR_RED:String = "red";
      
      public static const COLOR_GOLD:String = "gold";
      
      public static const COLOR_BLUE:String = "blue";
      
      public static const COLOR_YELLOW:String = "yellow";
      
      public static const COLOR_WHITE:String = "white";
      
      public static const COLOR_PURPLE:String = "purple";
      
      public static const COLOR_HUNTER:String = "hunter";
      
      public static const HB_ANIMATED_PART_SPLASH:String = "splash";
      
      public static const HB_ANIMATED_PART_EXPLOSION:String = "explosion";
      
      public static const HB_ANIMATED_PART_LABEL:String = "label";
      
      public static const HB_ANIMATED_INACTIVE_STATE:String = "inactive";
      
      public static const HB_ANIMATED_IMITATION_STATE:String = "imitationDamage";
      
      public static const ATLAS_SRC_ICONS_STATUS_MARKERS:Dictionary = new Dictionary();
      
      {
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_RISKY_ATTACK_STATE] = COMP7_CONSTS.ROLE_SKILL_RISKY_ATTACK;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_SNIPER_STATE] = COMP7_CONSTS.ROLE_SKILL_SNIPER;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_ALLY_SUPPORT_STATE] = COMP7_CONSTS.ROLE_SKILL_ALLY_SUPPORT;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_AOE_INSPIRE_STATE] = COMP7_CONSTS.ROLE_SKILL_AOE_INSPIRE;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_HUNTER_STATE] = COMP7_CONSTS.ROLE_SKILL_HUNTER;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_CONCENTRATION_STATE] = COMP7_CONSTS.ROLE_SKILL_CONCENTRATION;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_JUGGERNAUT_STATE] = COMP7_CONSTS.ROLE_SKILL_JUGGERNAUT;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_RISKY_ATTACK_HEAL_STATE] = COMP7_CONSTS.ROLE_SKILL_RISKY_ATTACK_HEAL;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_BERSERK_STATE] = COMP7_CONSTS.ROLE_SKILL_BERSERK;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_FAST_RECHARGE_STATE] = COMP7_CONSTS.ROLE_SKILL_FAST_RECHARGE;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_SURE_SHOT_STATE] = COMP7_CONSTS.ROLE_SKILL_SURE_SHOT;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_ARTYLLERY_SUPPORT_STATE] = COMP7_CONSTS.ROLE_SKILL_ARTYLLERY_SUPPORT;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_MARCH_STATE] = COMP7_CONSTS.ROLE_SKILL_MARCH;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_AGGRESSIVE_DETECTION_STATE] = COMP7_CONSTS.ROLE_SKILL_AGGRESSIVE_DETECTION;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_POINT_RECON_STATE] = COMP7_CONSTS.ROLE_SKILL_POINT_RECON;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.COMP7_AOE_HEAL_STATE] = COMP7_CONSTS.ROLE_SKILL_AOE_HEAL;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.CONFIRMED_STATE] = COMP7_CONSTS.STATUS_MARKER_CONFIRMED_STATE;
         ATLAS_SRC_ICONS_STATUS_MARKERS[BATTLE_MARKER_STATES.ABILITY_STATE] = BATTLE_MARKER_ABILITIES_CONSTS.ABILITY;
      }
      
      public function VehicleMarkersConstants()
      {
         super();
      }
      
      public static function getStatusMarkerIconNameByStatusId(param1:int) : String
      {
         if(param1 in ATLAS_SRC_ICONS_STATUS_MARKERS)
         {
            return ATLAS_SRC_ICONS_STATUS_MARKERS[param1];
         }
         return Values.EMPTY_STR;
      }
   }
}
