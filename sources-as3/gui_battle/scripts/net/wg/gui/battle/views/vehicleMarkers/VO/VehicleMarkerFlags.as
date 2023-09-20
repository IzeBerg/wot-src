package net.wg.gui.battle.views.vehicleMarkers.VO
{
   public class VehicleMarkerFlags
   {
      
      public static const DAMAGE_NONE:String = "none";
      
      public static const DAMAGE_SHOT:String = "shot";
      
      public static const DAMAGE_FIRE:String = "fire";
      
      public static const DAMAGE_RAMMING:String = "ramming";
      
      public static const DAMAGE_WORLD_COLLISION:String = "world_collision";
      
      public static const DAMAGE_DEATH_ZONE:String = "death_zone";
      
      public static const DAMAGE_DROWNING:String = "drowning";
      
      public static const DAMAGE_EXPLOSION:String = "explosion";
      
      public static const DAMAGE_BLOCKED:String = "blocked";
      
      public static const DAMAGE_BLOCKED_CRIT:String = "blocked_crit";
      
      public static const DAMAGE_RICOCHET:String = "ricochet";
      
      public static const DAMAGE_FROM:Array = ["FROM_UNKNOWN","FROM_ALLY","FROM_ENEMY","FROM_SQUAD","FROM_PLAYER"];
      
      public static const DAMAGE_COLOR:Object = {
         "FROM_UNKNOWN":{
            "green":"green",
            "red":"red",
            "gold":"green",
            "blue":"green",
            "yellow":"green",
            "purple":"purple",
            "hunter":"hunter"
         },
         "FROM_ALLY":{
            "green":"green",
            "red":"red",
            "gold":"green",
            "blue":"green",
            "yellow":"green",
            "purple":"purple",
            "hunter":"hunter"
         },
         "FROM_ENEMY":{
            "green":"green",
            "red":"red",
            "gold":"green",
            "blue":"green",
            "yellow":"green",
            "purple":"purple",
            "hunter":"hunter"
         },
         "FROM_SQUAD":{
            "green":"green",
            "red":"gold",
            "gold":"green",
            "blue":"green",
            "yellow":"green",
            "purple":"yellow",
            "hunter":"hunter"
         },
         "FROM_PLAYER":{
            "green":"green",
            "red":"gold",
            "gold":"green",
            "blue":"green",
            "yellow":"green",
            "purple":"yellow",
            "hunter":"hunter"
         }
      };
      
      public static const ALL_DAMAGE_TYPES:Array = [DAMAGE_SHOT,DAMAGE_FIRE,DAMAGE_RAMMING,DAMAGE_WORLD_COLLISION,DAMAGE_DEATH_ZONE,DAMAGE_DROWNING,DAMAGE_EXPLOSION];
      
      public static const ALLOWED_DAMAGE_TYPES:Array = [DAMAGE_FIRE,DAMAGE_EXPLOSION];
      
      public static const LABELED_DAMAGE_TYPES:Array = [DAMAGE_BLOCKED,DAMAGE_BLOCKED_CRIT,DAMAGE_RICOCHET];
       
      
      public function VehicleMarkerFlags()
      {
         super();
      }
      
      public static function checkLabeledDamages(param1:String) : Boolean
      {
         return param1 == "" ? Boolean(true) : Boolean(LABELED_DAMAGE_TYPES.indexOf(param1) != -1);
      }
      
      public static function checkAllowedDamages(param1:String) : Boolean
      {
         return param1 == "" ? Boolean(true) : Boolean(ALLOWED_DAMAGE_TYPES.indexOf(param1) != -1);
      }
   }
}
