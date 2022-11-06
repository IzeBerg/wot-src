package net.wg.gui.battle.views.stats.constants
{
   public class PlayerStatusSchemeName
   {
      
      public static const NORMAL:String = "normal";
      
      public static const TEAM_KILLER:String = "teamkiller";
      
      public static const SQUAD_PERSONAL:String = "squad";
      
      public static const SELECTED:String = "selected";
      
      public static const DEAD_POSTFIX:String = "_dead";
      
      public static const OFFLINE_POSTFIX:String = "_offline";
       
      
      public function PlayerStatusSchemeName()
      {
         super();
      }
      
      public static function getSchemeNameForPlayer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : String
      {
         var _loc6_:String = !!param1 ? SELECTED : (!!param2 ? SQUAD_PERSONAL : (!!param3 ? TEAM_KILLER : NORMAL));
         if(param4)
         {
            _loc6_ += DEAD_POSTFIX;
         }
         if(param5)
         {
            _loc6_ += OFFLINE_POSTFIX;
         }
         return _loc6_;
      }
      
      public static function getSchemeNameForVehicle(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : String
      {
         var _loc6_:String = null;
         if(param3)
         {
            _loc6_ = TEAM_KILLER;
            if(param4)
            {
               _loc6_ += DEAD_POSTFIX;
            }
            return _loc6_;
         }
         return getSchemeNameForPlayer(param1,param2,param3,param4,param5);
      }
      
      public static function getSchemeForVehicleLevel(param1:Boolean) : String
      {
         return !!param1 ? NORMAL + DEAD_POSTFIX : NORMAL;
      }
   }
}
