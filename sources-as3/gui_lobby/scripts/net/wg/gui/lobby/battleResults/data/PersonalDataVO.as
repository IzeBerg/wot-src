package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IAssertable;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalDataVO extends DAAPIDataClass
   {
      
      public static const XP_DATA:String = "xpData";
      
      public static const CREDITS_DATA:String = "creditsData";
      
      public static const STAT_VALUES:String = "statValues";
      
      public static const RESOURCE_DATA:String = "resourceData";
      
      public static const NO_INCOME_ALERT_MESSAGE:String = "noIncomeAlert";
      
      public static const ACHIEVEMENTS_LEFT:String = "achievementsLeft";
      
      public static const ACHIEVEMENTS_RIGHT:String = "achievementsRight";
      
      private static const FIELD_EFFICIENCY_HEADER:String = "efficiencyHeader";
      
      private static const FIELD_STUN_DATA_ENABLED:String = "isStunDataEnabled";
      
      private static const FIELD_DETAILS:String = "details";
      
      private static const CRYSTAL_DATA:String = "crystalData";
      
      private static const PREMIUM_INFO:String = "premiumInfo";
      
      private static const PREMIUM_BONUS:String = "premiumBonus";
      
      private static const PREMIUM_EARNINGS:String = "premiumEarnings";
      
      private static const PRESTIGE_POINTS:String = "prestigePoints";
       
      
      public var achievementsLeft:DataProvider;
      
      public var achievementsRight:DataProvider;
      
      public var creditsStr:String = "";
      
      public var details:Array = null;
      
      public var fortResourceTotal:String = "";
      
      public var isLegionnaire:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var xpStr:String = "";
      
      public var crystalStr:String = "";
      
      public var resValues:Array = null;
      
      public var resPremValues:Array = null;
      
      public var showNoIncomeAlert:Boolean = false;
      
      public var noIncomeAlert:AlertMessageVO = null;
      
      public var isMultiplierInfoVisible:Boolean = false;
      
      public var multiplierTooltipStr:String = "";
      
      public var premiumMultiplierTooltipStr:String = "";
      
      public var multiplierLineIdxPos:int = -1;
      
      public var resourceData:Vector.<DetailedStatsItemVO> = null;
      
      public var crystalData:Vector.<Vector.<DetailedStatsItemVO>> = null;
      
      public var creditsData:Vector.<Vector.<DetailedStatsItemVO>> = null;
      
      public var xpData:Vector.<Vector.<DetailedStatsItemVO>> = null;
      
      public var statValues:Vector.<Vector.<StatItemVO>> = null;
      
      public var efficiencyHeader:EfficiencyHeaderVO = null;
      
      public var isStunDataEnabled:Boolean = false;
      
      public var playerRank:int = 0;
      
      public var isTeamKiller:Boolean = false;
      
      public var isPremiumPlus:Boolean = false;
      
      public var premiumInfo:PremiumInfoVO = null;
      
      public var premiumBonus:PremiumBonusVO = null;
      
      public var premiumEarnings:PremiumEarningsVO = null;
      
      public var dynamicPremiumState:int = -1;
      
      public var prestigePoints:PrestigePointsVO = null;
      
      public var deserterStr:String = "";
      
      private var _asserter:IAssertable;
      
      public function PersonalDataVO(param1:Object)
      {
         this._asserter = App.utils.asserter;
         if(param1.hasOwnProperty(FIELD_STUN_DATA_ENABLED))
         {
            this.isStunDataEnabled = param1[FIELD_STUN_DATA_ENABLED];
         }
         super(param1);
      }
      
      private static function cleanVectorOfVectors(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Vector.<IDisposable> = null;
         var _loc4_:IDisposable = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = Vector.<IDisposable>(_loc2_);
            for each(_loc4_ in _loc3_)
            {
               _loc4_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
         param1.splice(0,param1.length);
      }
      
      private static function fillAchievements(param1:Array, param2:Array) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc3_ = param2.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               param1.push(new BattleResultsMedalsListVO(param2[_loc4_]));
               _loc4_++;
            }
         }
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         switch(param1)
         {
            case XP_DATA:
            case CREDITS_DATA:
            case CRYSTAL_DATA:
               _loc3_ = param2 as Array;
               this._asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
               this.fillVectorOfDetailedStatsItems(param1,_loc3_);
               return false;
            case RESOURCE_DATA:
               _loc3_ = param2 as Array;
               this._asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
               this.fillResourceData(_loc3_);
               return false;
            case STAT_VALUES:
               _loc3_ = param2 as Array;
               this._asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
               this.fillStatValues(_loc3_);
               return false;
            case NO_INCOME_ALERT_MESSAGE:
               this.noIncomeAlert = new AlertMessageVO(param2);
               return false;
            case ACHIEVEMENTS_LEFT:
               _loc3_ = param2 as Array;
               this._asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
               this.fillAchievementsLeft(_loc3_);
               return false;
            case ACHIEVEMENTS_RIGHT:
               _loc3_ = param2 as Array;
               this._asserter.assertNotNull(_loc3_,Errors.CANT_NULL);
               this.fillAchievementsRight(_loc3_);
               return false;
            case FIELD_EFFICIENCY_HEADER:
               this.efficiencyHeader = new EfficiencyHeaderVO(param2);
               this.efficiencyHeader.isStunDataEnabled = this.isStunDataEnabled;
               return false;
            case FIELD_DETAILS:
               _loc3_ = param2 as Array;
               if(this.isStunDataEnabled && _loc3_ && _loc3_.length > 0)
               {
                  _loc5_ = _loc3_[0];
                  if(_loc5_)
                  {
                     _loc6_ = _loc5_.length;
                     _loc7_ = 0;
                     while(_loc7_ < _loc6_)
                     {
                        _loc4_ = _loc5_[_loc7_];
                        _loc4_[FIELD_STUN_DATA_ENABLED] = this.isStunDataEnabled;
                        _loc7_++;
                     }
                  }
               }
               this.details = _loc3_;
               return false;
            case PREMIUM_INFO:
               this.premiumInfo = new PremiumInfoVO(param2);
               return false;
            case PREMIUM_BONUS:
               this.premiumBonus = new PremiumBonusVO(param2);
               return false;
            case PREMIUM_EARNINGS:
               this.premiumEarnings = new PremiumEarningsVO(param2);
               return false;
            case PRESTIGE_POINTS:
               this.prestigePoints = new PrestigePointsVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         var _loc2_:DetailedStatsItemVO = null;
         if(this.achievementsLeft != null)
         {
            for each(_loc1_ in this.achievementsLeft)
            {
               _loc1_.dispose();
            }
            this.achievementsLeft.cleanUp();
            this.achievementsLeft = null;
         }
         if(this.achievementsRight != null)
         {
            for each(_loc1_ in this.achievementsRight)
            {
               _loc1_.dispose();
            }
            this.achievementsRight.cleanUp();
            this.achievementsRight = null;
         }
         if(this.details != null)
         {
            this.details.splice(0,this.details.length);
            this.details = null;
         }
         if(this.resValues != null)
         {
            this.resValues.splice(0);
            this.resValues = null;
         }
         if(this.resPremValues != null)
         {
            this.resPremValues.splice(0);
            this.resPremValues = null;
         }
         if(this.creditsData != null)
         {
            cleanVectorOfVectors(this.creditsData);
            this.creditsData = null;
         }
         if(this.crystalData != null)
         {
            cleanVectorOfVectors(this.crystalData);
            this.crystalData = null;
         }
         if(this.xpData != null)
         {
            cleanVectorOfVectors(this.xpData);
            this.xpData = null;
         }
         if(this.resourceData != null)
         {
            for each(_loc2_ in this.resourceData)
            {
               _loc2_.dispose();
            }
            this.resourceData.splice(0,this.resourceData.length);
            this.resourceData = null;
         }
         if(this.statValues != null)
         {
            cleanVectorOfVectors(this.statValues);
            this.statValues = null;
         }
         if(this.noIncomeAlert != null)
         {
            this.noIncomeAlert.dispose();
            this.noIncomeAlert = null;
         }
         if(this.efficiencyHeader)
         {
            this.efficiencyHeader.dispose();
            this.efficiencyHeader = null;
         }
         if(this.statValues != null)
         {
            cleanVectorOfVectors(this.statValues);
            this.statValues = null;
         }
         if(this.premiumInfo != null)
         {
            this.premiumInfo.dispose();
            this.premiumInfo = null;
         }
         if(this.premiumBonus != null)
         {
            this.premiumBonus.dispose();
            this.premiumBonus = null;
         }
         if(this.premiumEarnings != null)
         {
            this.premiumEarnings.dispose();
            this.premiumEarnings = null;
         }
         if(this.prestigePoints != null)
         {
            this.prestigePoints.dispose();
            this.prestigePoints = null;
         }
         this._asserter = null;
         super.onDispose();
      }
      
      private function fillVectorOfDetailedStatsItems(param1:String, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<Vector.<DetailedStatsItemVO>> = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param2)
         {
            _loc3_ = param2.length;
            _loc4_ = new Vector.<Vector.<DetailedStatsItemVO>>();
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               _loc5_ = param2[_loc7_] as Array;
               this._asserter.assertNotNull(_loc5_,Errors.CANT_NULL);
               _loc6_ = _loc5_.length;
               _loc4_.push(new Vector.<DetailedStatsItemVO>(_loc6_));
               _loc8_ = 0;
               while(_loc8_ < _loc6_)
               {
                  _loc4_[_loc7_][_loc8_] = new DetailedStatsItemVO(_loc5_[_loc8_]);
                  _loc8_++;
               }
               _loc7_++;
            }
            this[param1] = _loc4_;
         }
      }
      
      private function fillResourceData(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.resourceData = new Vector.<DetailedStatsItemVO>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.resourceData[_loc3_] = new DetailedStatsItemVO(param1[_loc3_]);
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
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc3_ = param1[_loc5_];
               _loc4_ = _loc3_.length;
               this.statValues[_loc5_] = new Vector.<StatItemVO>(_loc4_);
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  this.statValues[_loc5_][_loc6_] = new StatItemVO(_loc3_[_loc6_]);
                  _loc6_++;
               }
               _loc5_++;
            }
         }
      }
      
      private function fillAchievementsRight(param1:Array) : void
      {
         if(param1)
         {
            this.achievementsRight = new DataProvider();
            fillAchievements(this.achievementsRight,param1);
         }
      }
      
      private function fillAchievementsLeft(param1:Array) : void
      {
         if(param1)
         {
            this.achievementsLeft = new DataProvider();
            fillAchievements(this.achievementsLeft,param1);
         }
      }
   }
}
