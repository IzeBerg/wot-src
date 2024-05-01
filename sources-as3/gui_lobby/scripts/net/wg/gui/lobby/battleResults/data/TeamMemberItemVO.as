package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class TeamMemberItemVO extends DAAPIDataClass
   {
      
      private static const STAT_VALUES:String = "statValues";
      
      private static const VEHICLES:String = "vehicles";
      
      private static const USER_VO:String = "userVO";
      
      private static const ACHIEVEMENTS:String = "achievements";
      
      private static const BADGE_VO:String = "badgeVO";
       
      
      public var isSelf:Boolean;
      
      public var playerId:Number;
      
      public var isTeamKiller:Boolean;
      
      public var deathReason:int;
      
      public var isOwnSquad:Boolean;
      
      public var showTeamDivider:Boolean;
      
      public var showTeamInfo:Boolean;
      
      public var resourceCount:int = -1;
      
      public var tankIcon:String = "";
      
      public var vehicleName:String = "";
      
      public var xp:int;
      
      public var achievementXP:int;
      
      public var xpSort:int;
      
      public var damageDealt:int;
      
      public var squadID:int;
      
      public var prebattleID:int;
      
      public var vehicleSort:int;
      
      public var kills:int;
      
      public var tkills:int;
      
      public var realKills:int;
      
      public var vehicleId:int;
      
      public var medalsCount:int;
      
      public var victoryScore:int;
      
      public var teamScore:int;
      
      public var flags:int;
      
      public var falloutResourcePoints:int;
      
      public var deaths:int;
      
      public var deathsStr:String = "";
      
      public var vehicleFullName:String = "";
      
      public var vehicleStateStr:String = "";
      
      public var isPrematureLeave:Boolean;
      
      public var isKilledByTeamKiller:Boolean;
      
      public var killerID:int;
      
      public var killerFakeNameStr:String = "";
      
      public var killerRealNameStr:String = "";
      
      public var killerClanNameStr:String = "";
      
      public var killerFullNameStr:String = "";
      
      public var killerRegionNameStr:String = "";
      
      public var vehicleStatePrefixStr:String = "";
      
      public var vehicleStateSuffixStr:String = "";
      
      public var vehicleCD:Number = -1;
      
      public var rollOuts:int = -1;
      
      public var respawns:int = -1;
      
      public var playerRank:int = -1;
      
      public var userVO:UserVO = null;
      
      public var statValues:Vector.<Vector.<StatItemVO>> = null;
      
      public var vehicles:Array = null;
      
      public var achievements:DataProvider = null;
      
      public var isAlly:Boolean;
      
      public var rankIcon:String = "";
      
      public var rank:int = -1;
      
      public var hasSelectedBadge:Boolean = false;
      
      public var suffixBadgeIcon:String = "";
      
      public var suffixBadgeStripIcon:String = "";
      
      public var prestigePoints:int;
      
      public var isSuperSquad:Boolean = false;
      
      public function TeamMemberItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case STAT_VALUES:
               App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE);
               this.fillStatValues(param2 as Array);
               return false;
            case VEHICLES:
               App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE);
               this.fillVehicles(param2 as Array);
               return false;
            case USER_VO:
               this.userVO = new UserVO(param2);
               return false;
            case ACHIEVEMENTS:
               App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE);
               this.fillAchievements(param2 as Array);
               return false;
            case BADGE_VO:
               this.userVO.badgeVisualVO = new BadgeVisualVO(param2);
               return false;
            default:
               return super.onDataRead(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Vector.<StatItemVO> = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:IDisposable = null;
         if(this.statValues != null)
         {
            _loc2_ = this.statValues.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc1_ = this.statValues[_loc5_];
               _loc3_ = _loc1_.length;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc1_[_loc4_].dispose();
                  _loc4_++;
               }
               _loc1_.splice(0,_loc3_);
               _loc5_++;
            }
            this.statValues.splice(0,_loc2_);
            this.statValues = null;
         }
         if(this.vehicles != null)
         {
            App.utils.commons.releaseReferences(this.vehicles);
            this.vehicles = null;
         }
         if(this.achievements != null)
         {
            for each(_loc6_ in this.achievements)
            {
               _loc6_.dispose();
            }
            this.achievements.cleanUp();
            this.achievements = null;
         }
         if(this.userVO)
         {
            this.userVO.dispose();
            this.userVO = null;
         }
         super.onDispose();
      }
      
      private function fillVehicles(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            this.vehicles = [];
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.vehicles.push(new VehicleItemVO(param1[_loc3_]));
               _loc3_++;
            }
         }
      }
      
      private function fillStatValues(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.statValues = new Vector.<Vector.<StatItemVO>>(_loc2_);
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc3_ = param1[_loc6_];
               _loc4_ = _loc3_.length;
               this.statValues[_loc6_] = new Vector.<StatItemVO>(_loc4_);
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.statValues[_loc6_][_loc5_] = new StatItemVO(_loc3_[_loc5_]);
                  _loc5_++;
               }
               _loc6_++;
            }
         }
      }
      
      private function fillAchievements(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            this.achievements = new DataProvider();
            _loc2_ = param1.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.achievements.push(new BattleResultsMedalsListVO(param1[_loc3_]));
               _loc3_++;
            }
         }
      }
      
      public function get playerName() : String
      {
         return this.userVO.isAnonymized && !(this.isSelf || this.isOwnSquad) ? this.userVO.fakeName : this.userVO.userName;
      }
   }
}
