package net.wg.gui.lobby.settings.feedback.damageLog.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLEDAMAGELOG_IMAGES;
   import net.wg.data.constants.generated.DAMAGE_LOG_SHELL_BG_TYPES;
   import net.wg.gui.components.battleDamagePanel.models.MessageRenderModel;
   
   public class SettingsDamageLogData
   {
      
      private static const M12:String = "#usa_vehicles:M12";
      
      private static const T34:String = "#usa_vehicles:T34_hvy";
      
      private static const E100:String = "#germany_vehicles:E-100";
      
      private static const IS7:String = "#ussr_vehicles:IS-7";
      
      private static const VALUE:String = "value";
      
      private static const ACTION_TYPE_IMG:String = "actionTypeImg";
      
      private static const VEHICLE_TYPE_IMGVEHICLE_TYPE_IMG:String = "vehicleTypeImg";
      
      private static const VEHICLE_NAME:String = "vehicleName";
      
      private static const SHELL_TYPE_STR:String = "shellTypeStr";
      
      private static const SHELL_TYPE_BG:String = "shellTypeBG";
       
      
      public function SettingsDamageLogData()
      {
         super();
      }
      
      public static function getTotal() : Vector.<MessageRenderModel>
      {
         return new <MessageRenderModel>[getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_TOTAL_VALUE4,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,E100,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING,DAMAGE_LOG_SHELL_BG_TYPES.WHITE),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_TOTAL_VALUE3,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_IMMOBILIZED_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,E100,Values.EMPTY_STR,DAMAGE_LOG_SHELL_BG_TYPES.EMPTY),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_TOTAL_VALUE2,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_COORDINATE_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,T34,Values.EMPTY_STR,DAMAGE_LOG_SHELL_BG_TYPES.EMPTY),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_TOTAL_VALUE1,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_REFLECT_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,T34,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING,DAMAGE_LOG_SHELL_BG_TYPES.WHITE)];
      }
      
      public static function getPositive() : Vector.<MessageRenderModel>
      {
         return new <MessageRenderModel>[getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_POSITIVE_VALUE4,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_FIRE_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,M12,Values.EMPTY_STR,DAMAGE_LOG_SHELL_BG_TYPES.EMPTY),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_POSITIVE_VALUE3,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_IMMOBILIZED_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,E100,Values.EMPTY_STR,DAMAGE_LOG_SHELL_BG_TYPES.EMPTY),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_POSITIVE_VALUE2,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_COORDINATE_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,T34,Values.EMPTY_STR,DAMAGE_LOG_SHELL_BG_TYPES.EMPTY),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_POSITIVE_VALUE1,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,T34,Values.EMPTY_STR,DAMAGE_LOG_SHELL_BG_TYPES.EMPTY)];
      }
      
      public static function getNegative() : Vector.<MessageRenderModel>
      {
         return new <MessageRenderModel>[getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_NEGATIVE_VALUE4,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_CRITICAL_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,IS7,INGAME_GUI.DAMAGELOG_SHELLTYPE_HIGH_EXPLOSIVE,DAMAGE_LOG_SHELL_BG_TYPES.WHITE),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_NEGATIVE_VALUE3,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_CRITICAL_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,E100,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING,DAMAGE_LOG_SHELL_BG_TYPES.WHITE),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_NEGATIVE_VALUE2,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_REFLECT_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,T34,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING,DAMAGE_LOG_SHELL_BG_TYPES.WHITE),getItemData(SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_NEGATIVE_VALUE1,BATTLEDAMAGELOG_IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16,BATTLEDAMAGELOG_IMAGES.WHITE_ICON_HEAVYTANK_16X16,IS7,INGAME_GUI.DAMAGELOG_SHELLTYPE_ARMOR_PIERCING_CR,DAMAGE_LOG_SHELL_BG_TYPES.GOLD)];
      }
      
      public static function getEmpty() : Vector.<MessageRenderModel>
      {
         return new Vector.<MessageRenderModel>(0);
      }
      
      private static function getDataByEventTypeSettingIdx(param1:int) : Vector.<MessageRenderModel>
      {
         var _loc2_:Vector.<MessageRenderModel> = null;
         switch(param1)
         {
            case 0:
               _loc2_ = getTotal();
               break;
            case 1:
               _loc2_ = getPositive();
               break;
            case 2:
               _loc2_ = getNegative();
         }
         return _loc2_;
      }
      
      private static function getItemData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : MessageRenderModel
      {
         var _loc7_:Object = {};
         _loc7_[VALUE] = param1;
         _loc7_[ACTION_TYPE_IMG] = param2;
         _loc7_[VEHICLE_TYPE_IMGVEHICLE_TYPE_IMG] = param3;
         _loc7_[VEHICLE_NAME] = param4;
         _loc7_[SHELL_TYPE_STR] = param5;
         _loc7_[SHELL_TYPE_BG] = param6;
         return new MessageRenderModel(_loc7_);
      }
   }
}
