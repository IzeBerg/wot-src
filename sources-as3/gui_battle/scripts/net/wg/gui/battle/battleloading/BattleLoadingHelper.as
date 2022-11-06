package net.wg.gui.battle.battleloading
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.UserTags;
   import net.wg.gui.battle.battleloading.constants.VehicleStatusSchemes;
   
   public class BattleLoadingHelper
   {
      
      private static var _instance:BattleLoadingHelper = null;
      
      public static const SETTING_TEXT:String = "textTip";
      
      private static const VEHICLE_TYPE_UNKNOWN:String = "unknown";
      
      private static const DASH:String = "_";
       
      
      public function BattleLoadingHelper()
      {
         super();
      }
      
      public static function get instance() : BattleLoadingHelper
      {
         if(_instance == null)
         {
            _instance = new BattleLoadingHelper();
         }
         return _instance;
      }
      
      public function getColorSchemeName(param1:DAAPIVehicleInfoVO, param2:Boolean) : String
      {
         var _loc3_:String = this.getRandomColorSchemeName(param1,param2);
         return _loc3_ + (!UserTags.isCurrentPlayer(param1.userTags) && (!param1.isAlive() || !param1.isReady()) ? VehicleStatusSchemes.OFFLINE_POSTFIX : "");
      }
      
      public function getVehicleTypeIconId(param1:DAAPIVehicleInfoVO) : String
      {
         var _loc2_:String = App.colorSchemeMgr.getAliasColor(param1.teamColor);
         if(_loc2_ && param1.vehicleType && param1.vehicleType != VEHICLE_TYPE_UNKNOWN)
         {
            return _loc2_ + DASH + param1.vehicleType;
         }
         return null;
      }
      
      private function getFalloutColorSchemeName(param1:DAAPIVehicleInfoVO, param2:Boolean) : String
      {
         var _loc3_:String = null;
         if(param1.isTeamKiller())
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER : VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER_DEAD;
         }
         else if(UserTags.isCurrentPlayer(param1.userTags))
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_PLAYER : VehicleStatusSchemes.COLOR_SCHEME_PLAYER_DEAD;
         }
         else if(param1.isCurrentSquad)
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_SQUAD : VehicleStatusSchemes.COLOR_SCHEME_SQUAD_DEAD;
         }
         else
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_NORMAL : VehicleStatusSchemes.COLOR_SCHEME_NORMAL_DEAD;
         }
         return _loc3_;
      }
      
      private function getRandomColorSchemeName(param1:DAAPIVehicleInfoVO, param2:Boolean) : String
      {
         var _loc3_:String = null;
         if(UserTags.isCurrentPlayer(param1.userTags))
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_PLAYER : VehicleStatusSchemes.COLOR_SCHEME_PLAYER_DEAD;
         }
         else if(param1.isCurrentSquad)
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_SQUAD : VehicleStatusSchemes.COLOR_SCHEME_SQUAD_DEAD;
         }
         else if(param1.isTeamKiller())
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER : VehicleStatusSchemes.COLOR_SCHEME_TEAMKILLER_DEAD;
         }
         else
         {
            _loc3_ = !!param2 ? VehicleStatusSchemes.COLOR_SCHEME_NORMAL : VehicleStatusSchemes.COLOR_SCHEME_NORMAL_DEAD;
         }
         return _loc3_;
      }
   }
}
