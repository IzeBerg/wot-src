package net.wg.gui.components.ribbon.data
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.data.constants.generated.DAMAGE_SOURCE_TYPES;
   import net.wg.gui.components.ribbon.constants.RibbonColors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RibbonSettings implements IDisposable
   {
      
      private static var _isInit:Boolean = false;
      
      private static const WITH_NAME_WITH_TANKNAME_PADDINGS:String = "withNameWithTanknamePaddings";
      
      private static const WITHOUT_NAME_WITH_TANKNAME_PADDINGS:String = "withoutNameWithTanknamePaddings";
      
      private static const WITH_NAME_WITHOUT_TANKNAME_PADDINGS:String = "withNameWithoutTanknamePaddings";
      
      private static const WITHOUT_NAME_WITHOUT_TANKNAME_PADDINGS:String = "withoutNameWithoutTanknamePaddings";
      
      protected static const BACKGROUNDS:Dictionary = new Dictionary();
      
      private static const TEXT_SETTINGS:Dictionary = new Dictionary();
      
      private static const PADDINGS_X:Dictionary = new Dictionary();
      
      protected static const RIBBON_TYPES_MAP:Dictionary = new Dictionary();
      
      protected static const DAMAGE_SOURCE_MAP:Dictionary = new Dictionary();
      
      public static const ICON_X_PADDINGS:Dictionary = new Dictionary();
      
      public static const ICON_Y_PADDINGS:Dictionary = new Dictionary();
      
      private static const DAMAGE_SOURCE_MISSING:String = "[RibbonSetting] Not all damage source icons are set!";
       
      
      private var _ribbonText:String;
      
      private var _ribbonType:String;
      
      private var _ribbonSettingsByType:RibbonSettingByType = null;
      
      private var _disposed:Boolean = false;
      
      protected const DYNAMIC_RIBBON_TYPES_MAP:Dictionary = new Dictionary();
      
      public function RibbonSettings(param1:String, param2:String)
      {
         super();
         this.init();
         this._ribbonType = param1;
         this._ribbonText = param2;
         this._ribbonSettingsByType = this.getSettingsByType();
         if(this._ribbonSettingsByType == null)
         {
            App.utils.asserter.assert(false,"No such ribbonType: " + param1);
         }
      }
      
      public static function getPaddings(param1:Boolean, param2:Boolean) : PaddingSettings
      {
         if(param1)
         {
            if(param2)
            {
               return PADDINGS_X[WITH_NAME_WITH_TANKNAME_PADDINGS];
            }
            return PADDINGS_X[WITH_NAME_WITHOUT_TANKNAME_PADDINGS];
         }
         if(param2)
         {
            return PADDINGS_X[WITHOUT_NAME_WITH_TANKNAME_PADDINGS];
         }
         return PADDINGS_X[WITHOUT_NAME_WITHOUT_TANKNAME_PADDINGS];
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._ribbonSettingsByType = null;
         var _loc1_:int = RIBBON_TYPES_MAP.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            RIBBON_TYPES_MAP[_loc2_].dispose();
            _loc2_++;
         }
         _loc1_ = this.DYNAMIC_RIBBON_TYPES_MAP.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            this.DYNAMIC_RIBBON_TYPES_MAP[_loc2_].dispose();
            _loc2_++;
         }
      }
      
      public function getAtlas() : String
      {
         return ATLAS_CONSTANTS.BATTLE_ATLAS;
      }
      
      public function getBackground() : BackgroundAtlasNames
      {
         return BACKGROUNDS[this._ribbonSettingsByType.getCurrentColor()];
      }
      
      public function getDamageSourceIcon(param1:String) : String
      {
         return DAMAGE_SOURCE_MAP[param1].getCurrentIcon(this._ribbonType);
      }
      
      public function getIcon() : String
      {
         return this._ribbonSettingsByType.getCurrentIcon();
      }
      
      public function getRibbonText() : String
      {
         return this._ribbonText;
      }
      
      public function updateRibbonProperties(param1:String, param2:String) : void
      {
         this._ribbonText = param2;
         this._ribbonSettingsByType.icon = param1;
      }
      
      public function getRibbonType() : String
      {
         return this._ribbonType;
      }
      
      public function getStartCountItemsInPool() : int
      {
         return this._ribbonSettingsByType.countItemsInPool;
      }
      
      public function getTextSettings() : RibbonTextSettings
      {
         return TEXT_SETTINGS[this._ribbonSettingsByType.getCurrentColor()];
      }
      
      public function getSettingsByType() : RibbonSettingByType
      {
         return RIBBON_TYPES_MAP[this._ribbonType] || this.DYNAMIC_RIBBON_TYPES_MAP[this._ribbonType];
      }
      
      protected function atlasInit() : void
      {
         var _loc7_:DamageSourceSetting = null;
         var _loc1_:String = RibbonColors.GREEN;
         var _loc2_:String = RibbonColors.RED;
         var _loc3_:String = RibbonColors.PURPLE;
         var _loc4_:String = RibbonColors.GREY;
         var _loc5_:String = RibbonColors.PERK;
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.ARMOR] = new RibbonSettingByType(_loc4_,BATTLEATLAS.RIBBONS_ARMOR,_loc4_,BATTLEATLAS.RIBBONS_ARMOR,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DAMAGE] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.WORLD_COLLISION] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RAM] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_RAM,_loc1_,BATTLEATLAS.RIBBONS_RAM,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DETECTION] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_SPOTTED,_loc1_,BATTLEATLAS.RIBBONS_SPOTTED,2);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.BURN] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_BURN,_loc1_,BATTLEATLAS.RIBBONS_BURN,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DESTRUCTION] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_KILL,_loc1_,BATTLEATLAS.RIBBONS_KILL,2);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.ASSIST_TRACK] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_ASSIST_TRACK,_loc1_,BATTLEATLAS.RIBBONS_ASSIST_TRACK,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.ASSIST_SPOT] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_ASSIST_SPOT,_loc1_,BATTLEATLAS.RIBBONS_ASSIST_SPOT,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.CRITS] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_CRITS,_loc1_,BATTLEATLAS.RIBBONS_CRITS,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.CAPTURE] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_CAPTURE,_loc1_,BATTLEATLAS.RIBBONS_CAPTURE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEFENCE] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DEFENCE,_loc1_,BATTLEATLAS.RIBBONS_DEFENCE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_CRITS] = new RibbonSettingByType(RibbonColors.ORANGE,BATTLEATLAS.RIBBONS_CRITS_ENEMY,RibbonColors.YELLOW,BATTLEATLAS.RIBBONS_CRITS_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_DAMAGE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BURN] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_BURN_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_BURN_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_RAM] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_RAM_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_RAM_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_WORLD_COLLISION] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.ASSIST_STUN] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_ASSIST_STUN,_loc1_,BATTLEATLAS.RIBBONS_ASSIST_STUN,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.STUN] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_STUN,_loc1_,BATTLEATLAS.RIBBONS_STUN,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.VEHICLE_RECOVERY] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.ENEMY_SECTOR_CAPTURED] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_ENEMY_SECTOR_CAPTURED,_loc1_,BATTLEATLAS.RIBBONS_ENEMY_SECTOR_CAPTURED,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DESTRUCTIBLE_DAMAGED] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DESTRUCTIBLE_DAMAGED,_loc1_,BATTLEATLAS.RIBBONS_DESTRUCTIBLE_DAMAGED,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DESTRUCTIBLE_DESTROYED] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DESTRUCTIBLE_DESTROYED,_loc1_,BATTLEATLAS.RIBBONS_DESTRUCTIBLE_DESTROYED,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DESTRUCTIBLES_DEFENDED] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DESTRUCTIBLES_DEFENDED,_loc1_,BATTLEATLAS.RIBBONS_DESTRUCTIBLES_DEFENDED,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEFENDER_BONUS] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DEFENDER_BONUS,_loc1_,BATTLEATLAS.RIBBONS_DEFENDER_BONUS,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.BASE_CAPTURE_BLOCKED] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DEFENCE,_loc1_,BATTLEATLAS.RIBBONS_DEFENCE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.ASSIST_BY_ABILITY] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_ASSIST_BY_ABILITY,_loc1_,BATTLEATLAS.RIBBONS_ASSIST_BY_ABILITY,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEATH_ZONE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.STATIC_DEATH_ZONE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_ENEMY_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.BERSERKER] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_BERSERKER,_loc3_,BATTLEATLAS.RIBBONS_BERSERKER,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.SPAWNED_BOT_DMG] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_BOT,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_BOT,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_DMG_BY_SPAWNED_BOT] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_BOT,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_BOT,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DAMAGE_BY_MINEFIELD] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_MINE_FIELD,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_MINE_FIELD,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_MINEFIELD] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_MINE_FIELD,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_MINE_FIELD_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_SMOKE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_SMOKE,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_SMOKE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEALT_DMG_BY_CORRODING_SHOT] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_CORRODING_SHOT,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_CORRODING_SHOT,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_CORRODING_SHOT] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_CORRODING_SHOT,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_CORRODING_SHOT,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEALT_DMG_BY_FIRE_CIRCLE] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_FIRE_CIRCLE,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_FIRE_CIRCLE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_FIRE_CIRCLE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_FIRE_CIRCLE,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_FIRE_CIRCLE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEALT_DMG_BY_CLING_BRANDER] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_CLING_BRANDER,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_CLING_BRANDER,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_CLING_BRANDER] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_CLING_BRANDER,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_CLING_BRANDER,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DEALT_DMG_BY_THUNDER_STRIKE] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_THUNDER_STRIKE,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_THUNDER_STRIKE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_THUNDER_STRIKE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_THUNDER_STRIKE,_loc3_,BATTLEATLAS.RIBBONS_DAMAGE_BY_THUNDER_STRIKE,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DAMAGE_BY_AIRSTRIKE] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_BY_AIR_STRIKE,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_BY_AIR_STRIKE,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_AIRSTRIKE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_RECEIVED_BY_AIR_STRIKE,_loc3_,BATTLEATLAS.RIBBONS_RECEIVED_BY_AIR_STRIKE_BLIND,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.DAMAGE_BY_ARTILLERY] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_BY_ARTILLERY,_loc1_,BATTLEATLAS.RIBBONS_DAMAGE_BY_ARTILLERY,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_ARTILLERY] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_RECEIVED_BY_ARTILLERY,_loc3_,BATTLEATLAS.RIBBONS_RECEIVED_BY_ARTILLERY_BLIND,3);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_DEATH_ZONE] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_RECEIVED_BY_DEATH_ZONE,_loc3_,BATTLEATLAS.RIBBONS_RECEIVED_BY_DEATH_ZONE_BLIND,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.VEHICLE_HEALTH_ADDED] = new RibbonSettingByType(_loc1_,BATTLEATLAS.RIBBONS_HEALTH_ADDED,_loc1_,BATTLEATLAS.RIBBONS_HEALTH_ADDED,1);
         RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.RECEIVED_BY_CIRCUIT_OVERLOAD] = new RibbonSettingByType(_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_CIRCUIT_OVERLOAD,_loc2_,BATTLEATLAS.RIBBONS_DAMAGE_BY_CIRCUIT_OVERLOAD,1);
         BACKGROUNDS[_loc1_] = new BackgroundAtlasNames(_loc1_);
         BACKGROUNDS[_loc4_] = new BackgroundAtlasNames(_loc4_);
         BACKGROUNDS[_loc2_] = new BackgroundAtlasNames(_loc2_);
         BACKGROUNDS[RibbonColors.ORANGE] = new BackgroundAtlasNames(RibbonColors.ORANGE);
         BACKGROUNDS[RibbonColors.YELLOW] = new BackgroundAtlasNames(RibbonColors.YELLOW);
         BACKGROUNDS[_loc3_] = new BackgroundAtlasNames(_loc3_);
         BACKGROUNDS[_loc5_] = new BackgroundAtlasNames(_loc5_);
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.LIGHT_TANK] = new DamageSourceSetting(BATTLEATLAS.WHITE_ICON_LIGHT_TANK16X16);
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.MEDIUM_TANK] = new DamageSourceSetting(BATTLEATLAS.WHITE_ICON_MEDIUM_TANK16X16);
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.HEAVY_TANK] = new DamageSourceSetting(BATTLEATLAS.WHITE_ICON_HEAVY_TANK16X16);
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.AT_SPG] = new DamageSourceSetting(BATTLEATLAS.WHITE_ICON_AT_SPG16X16);
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.SPG] = new DamageSourceSetting(BATTLEATLAS.WHITE_ICON_SPG16X16);
         this.setupComplexDamageSourceSettings();
         var _loc6_:int = 0;
         for each(_loc7_ in DAMAGE_SOURCE_MAP)
         {
            _loc6_++;
         }
         if(_loc6_ != DAMAGE_SOURCE_TYPES.DAMAGE_SOURCES.length)
         {
            DebugUtils.LOG_ERROR(DAMAGE_SOURCE_MISSING,_loc6_,DAMAGE_SOURCE_TYPES.DAMAGE_SOURCES.length);
         }
      }
      
      protected function setupComplexDamageSourceSettings() : void
      {
         var _loc1_:Vector.<String> = new <String>[BATTLE_EFFICIENCY_TYPES.RECEIVED_DAMAGE,BATTLE_EFFICIENCY_TYPES.RECEIVED_CRITS,BATTLE_EFFICIENCY_TYPES.RECEIVED_BURN];
         var _loc2_:Vector.<String> = new <String>[BATTLEATLAS.ARTILLERY_ENEMY,BATTLEATLAS.ARTILLERY_ENEMY_CRITS,BATTLEATLAS.ARTILLERY_ENEMY];
         var _loc3_:Vector.<String> = new <String>[BATTLEATLAS.ARTILLERY_ENEMY_BLIND,BATTLEATLAS.ARTILLERY_ENEMY_CRITS_BLIND,BATTLEATLAS.ARTILLERY_ENEMY_BLIND];
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.ARTILLERY] = new DamageSourceComplexSetting(_loc1_,_loc2_,_loc3_);
         _loc1_ = new <String>[BATTLE_EFFICIENCY_TYPES.RECEIVED_DAMAGE,BATTLE_EFFICIENCY_TYPES.RECEIVED_CRITS,BATTLE_EFFICIENCY_TYPES.RECEIVED_BURN];
         _loc2_ = new <String>[BATTLEATLAS.AIRSTRIKE_ENEMY,BATTLEATLAS.AIRSTRIKE_ENEMY_CRITS,BATTLEATLAS.AIRSTRIKE_ENEMY];
         _loc3_ = new <String>[BATTLEATLAS.AIRSTRIKE_ENEMY_BLIND,BATTLEATLAS.AIRSTRIKE_ENEMY_CRITS_BLIND,BATTLEATLAS.AIRSTRIKE_ENEMY_BLIND];
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.AIRSTRIKE] = new DamageSourceComplexSetting(_loc1_,_loc2_,_loc3_);
         _loc1_ = new <String>[BATTLE_EFFICIENCY_TYPES.RECEIVED_DAMAGE,BATTLE_EFFICIENCY_TYPES.RECEIVED_CRITS];
         _loc2_ = new <String>[BATTLEATLAS.FORT_ARTILLERY_ENEMY,BATTLEATLAS.FORT_ARTILLERY_ENEMY_CRITS];
         _loc3_ = new <String>[BATTLEATLAS.FORT_ARTILLERY_ENEMY_BLIND,BATTLEATLAS.FORT_ARTILLERY_ENEMY_CRITS_BLIND];
         DAMAGE_SOURCE_MAP[DAMAGE_SOURCE_TYPES.FORT_ARTILLERY] = new DamageSourceComplexSetting(_loc1_,_loc2_,_loc3_);
      }
      
      private function init() : void
      {
         this.initDynamicRibbons();
         if(!_isInit)
         {
            _isInit = true;
            this.atlasInit();
            TEXT_SETTINGS[RibbonColors.GREEN] = new RibbonTextSettings(RibbonColors.GREEN);
            TEXT_SETTINGS[RibbonColors.GREY] = new RibbonTextSettings(RibbonColors.GREY);
            TEXT_SETTINGS[RibbonColors.RED] = new RibbonTextSettings(RibbonColors.RED);
            TEXT_SETTINGS[RibbonColors.ORANGE] = new RibbonTextSettings(RibbonColors.ORANGE);
            TEXT_SETTINGS[RibbonColors.YELLOW] = new RibbonTextSettings(RibbonColors.YELLOW);
            TEXT_SETTINGS[RibbonColors.PURPLE] = new RibbonTextSettings(RibbonColors.PURPLE);
            TEXT_SETTINGS[RibbonColors.PERK] = new RibbonTextSettings(RibbonColors.PERK);
            PADDINGS_X[WITH_NAME_WITH_TANKNAME_PADDINGS] = new PaddingSettings(-156,10,0,7,26);
            PADDINGS_X[WITHOUT_NAME_WITH_TANKNAME_PADDINGS] = new PaddingSettings(-112,13,0,0,24);
            PADDINGS_X[WITH_NAME_WITHOUT_TANKNAME_PADDINGS] = new PaddingSettings(-135,10,0,0,0);
            PADDINGS_X[WITHOUT_NAME_WITHOUT_TANKNAME_PADDINGS] = new PaddingSettings(-94,14,0,0,0);
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.LIGHT_TANK] = -2;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.MEDIUM_TANK] = -1;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.HEAVY_TANK] = 0;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.AT_SPG] = -1;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.SPG] = -1;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.ARTILLERY] = 0;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.AIRSTRIKE] = 0;
            ICON_X_PADDINGS[DAMAGE_SOURCE_TYPES.FORT_ARTILLERY] = 0;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.LIGHT_TANK] = 11;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.MEDIUM_TANK] = 11;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.HEAVY_TANK] = 11;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.AT_SPG] = 11;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.SPG] = 11;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.ARTILLERY] = -6;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.AIRSTRIKE] = -6;
            ICON_Y_PADDINGS[DAMAGE_SOURCE_TYPES.FORT_ARTILLERY] = -6;
         }
      }
      
      protected function initDynamicRibbons() : void
      {
         var _loc1_:String = RibbonColors.PERK;
         this.DYNAMIC_RIBBON_TYPES_MAP[BATTLE_EFFICIENCY_TYPES.PERK] = new RibbonSettingByType(_loc1_,BATTLEATLAS.GUNNER_FOCUS,_loc1_,BATTLEATLAS.GUNNER_FOCUS,1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
