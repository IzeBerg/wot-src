package net.wg.gui.lobby.personalMissions.data
{
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   
   public class MapSettingsData
   {
      
      private static const MAP1_POINT_LT:int = 0;
      
      private static const MAP1_POINT_MT:int = -297;
      
      private static const MAP1_POINT_HT:int = -679;
      
      private static const MAP1_POINT_AT_SPG:int = -1001;
      
      private static const MAP1_POINT_SPG:int = -1270;
      
      private static const MAP1_VEH_ID_LT:int = 1;
      
      private static const MAP1_VEH_ID_MT:int = 3;
      
      private static const MAP1_VEH_ID_HT:int = 2;
      
      private static const MAP1_VEH_ID_AT_SPG:int = 4;
      
      private static const MAP1_VEH_ID_SPG:int = 5;
      
      private static const MAP1_X_OFFSET:int = 642;
      
      private static const MAP1_Y_OFFSET:int = 274;
      
      private static const MAP2_POINT_AL1:int = 0;
      
      private static const MAP2_POINT_AL2:int = -540;
      
      private static const MAP2_POINT_AL3:int = -1095;
      
      private static const MAP2_POINT_AL4:int = -1625;
      
      private static const MAP2_AL_ID_1:int = 1;
      
      private static const MAP2_AL_ID_2:int = 2;
      
      private static const MAP2_AL_ID_3:int = 3;
      
      private static const MAP2_AL_ID_4:int = 4;
      
      private static const MAP2_X_OFFSET:int = 630;
      
      private static const MAP2_Y_OFFSET:int = 274;
       
      
      public function MapSettingsData()
      {
         super();
      }
      
      public static function getChainOrder(param1:int) : Array
      {
         if(param1 == PERSONAL_MISSIONS_ALIASES.PERONAL_MISSIONS_PM_TYPE_REGULAR)
         {
            return [MAP1_VEH_ID_LT,MAP1_VEH_ID_MT,MAP1_VEH_ID_HT,MAP1_VEH_ID_AT_SPG,MAP1_VEH_ID_SPG];
         }
         return [MAP2_AL_ID_1,MAP2_AL_ID_2,MAP2_AL_ID_3,MAP2_AL_ID_4];
      }
      
      public static function getMapPoints(param1:int) : Object
      {
         var _loc2_:Object = {};
         if(param1 == PERSONAL_MISSIONS_ALIASES.PERONAL_MISSIONS_PM_TYPE_REGULAR)
         {
            _loc2_[MAP1_VEH_ID_LT] = MAP1_POINT_LT;
            _loc2_[MAP1_VEH_ID_MT] = MAP1_POINT_MT;
            _loc2_[MAP1_VEH_ID_HT] = MAP1_POINT_HT;
            _loc2_[MAP1_VEH_ID_AT_SPG] = MAP1_POINT_AT_SPG;
            _loc2_[MAP1_VEH_ID_SPG] = MAP1_POINT_SPG;
         }
         else
         {
            _loc2_[MAP2_AL_ID_1] = MAP2_POINT_AL1;
            _loc2_[MAP2_AL_ID_2] = MAP2_POINT_AL2;
            _loc2_[MAP2_AL_ID_3] = MAP2_POINT_AL3;
            _loc2_[MAP2_AL_ID_4] = MAP2_POINT_AL4;
         }
         return _loc2_;
      }
      
      public static function getPlanLinkage(param1:int) : Object
      {
         var _loc2_:Object = {};
         if(param1 == PERSONAL_MISSIONS_ALIASES.PERONAL_MISSIONS_PM_TYPE_REGULAR)
         {
            _loc2_[MAP1_VEH_ID_LT] = PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_LT_LINKAGE;
            _loc2_[MAP1_VEH_ID_MT] = PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_MT_LINKAGE;
            _loc2_[MAP1_VEH_ID_HT] = PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_HT_LINKAGE;
            _loc2_[MAP1_VEH_ID_AT_SPG] = PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_AT_SPG_LINKAGE;
            _loc2_[MAP1_VEH_ID_SPG] = PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_SPG_LINKAGE;
         }
         else
         {
            _loc2_[MAP2_AL_ID_1] = PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_1_LINKAGE;
            _loc2_[MAP2_AL_ID_2] = PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_2_LINKAGE;
            _loc2_[MAP2_AL_ID_3] = PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_3_LINKAGE;
            _loc2_[MAP2_AL_ID_4] = PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_4_LINKAGE;
         }
         return _loc2_;
      }
      
      public static function getPlanSwfByLinkage(param1:String) : String
      {
         switch(param1)
         {
            case PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_LT_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S1_PLAN_1_URL;
            case PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_MT_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S1_PLAN_2_URL;
            case PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_HT_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S1_PLAN_3_URL;
            case PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_AT_SPG_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S1_PLAN_4_URL;
            case PERSONAL_MISSIONS_ALIASES.PERSONAL_MISSIONS_PLAN_SPG_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S1_PLAN_5_URL;
            case PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_1_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_1_URL;
            case PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_2_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_2_URL;
            case PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_3_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_3_URL;
            case PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_4_LINKAGE:
               return PERSONAL_MISSIONS_ALIASES.PM_S2_PLAN_4_URL;
            default:
               return Values.EMPTY_STR;
         }
      }
      
      public static function getMapOffsets(param1:int) : Point
      {
         return param1 == PERSONAL_MISSIONS_ALIASES.PERONAL_MISSIONS_PM_TYPE_REGULAR ? new Point(MAP1_X_OFFSET,MAP1_Y_OFFSET) : new Point(MAP2_X_OFFSET,MAP2_Y_OFFSET);
      }
   }
}
