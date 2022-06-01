package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.progressiveReward.data.ProgressiveRewardVO;
   import net.wg.utils.IAssertable;
   import scaleform.clik.data.DataProvider;
   
   public class BattleResultsVO extends DAAPIDataClass
   {
      
      private static const COMMON:String = "common";
      
      private static const PERSONAL:String = "personal";
      
      private static const TEXT_DATA:String = "textData";
      
      private static const TEAM1:String = "team1";
      
      private static const TEAM2:String = "team2";
      
      private static const TAB_INFO:String = "tabInfo";
      
      private static const PROGRESSIVE_REWARD:String = "progressiveReward";
      
      private static const MANDATORY_FIELDS:Array = [COMMON,PERSONAL,TEXT_DATA,TEAM1,TEAM2,TAB_INFO];
      
      private static const ARRAY_FIELDS:Array = [TEAM1,TEAM2,TAB_INFO];
      
      private static const ERROR_STRING_DATA_WITH_KEY:String = "Data with key ";
      
      private static const ERROR_STRING_EXPECTED_TO_BE_ARRAY:String = " is expected to be array";
       
      
      public var common:CommonStatsVO = null;
      
      public var personal:PersonalDataVO = null;
      
      public var progressiveReward:ProgressiveRewardVO = null;
      
      public var dog_tags:Array = null;
      
      public var cyberSport:Object = null;
      
      public var battlePass:Array = null;
      
      public var quests:Array = null;
      
      public var unlocks:Array = null;
      
      public var vehicles:Array = null;
      
      public var textData:BattleResultsTextData;
      
      public var isFreeForAll:Boolean;
      
      public var selectedTeamMemberId:Number = -1;
      
      public var closingTeamMemberStatsEnabled:Boolean = true;
      
      public var selectedIdxInGarageDropdown:int = 0;
      
      public var team1:DataProvider;
      
      public var team2:DataProvider;
      
      public var tabInfo:DataProvider;
      
      public function BattleResultsVO(param1:Object)
      {
         super(param1);
      }
      
      private static function getTypedDataProvider(param1:*, param2:Class) : DataProvider
      {
         var _loc3_:DataProvider = new DataProvider();
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_] = new param2(param1[_loc5_]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:TeamMemberItemVO = null;
         var _loc3_:IAssertable = App.utils.asserter;
         if(MANDATORY_FIELDS.indexOf(param1) != -1)
         {
            _loc3_.assertNotNull(param2,ERROR_STRING_DATA_WITH_KEY + param1 + Errors.CANT_NULL);
         }
         if(ARRAY_FIELDS.indexOf(param1) != -1)
         {
            _loc3_.assert(param2 is Array,ERROR_STRING_DATA_WITH_KEY + param1 + ERROR_STRING_EXPECTED_TO_BE_ARRAY);
         }
         switch(param1)
         {
            case COMMON:
               this.common = new CommonStatsVO(param2);
               return false;
            case PERSONAL:
               this.personal = new PersonalDataVO(param2);
               return false;
            case TEXT_DATA:
               this.textData = new BattleResultsTextData(param2);
               return false;
            case TEAM1:
               this.team1 = getTypedDataProvider(param2,TeamMemberItemVO);
               for each(_loc4_ in this.team1)
               {
                  _loc4_.isAlly = true;
               }
               return false;
            case TEAM2:
               this.team2 = getTypedDataProvider(param2,TeamMemberItemVO);
               return false;
            case TAB_INFO:
               this.tabInfo = getTypedDataProvider(param2,TabInfoVO);
               return false;
            case PROGRESSIVE_REWARD:
               this.progressiveReward = new ProgressiveRewardVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TeamMemberItemVO = null;
         var _loc2_:TabInfoVO = null;
         this.cyberSport = App.utils.data.cleanupDynamicObject(this.cyberSport);
         if(this.battlePass != null)
         {
            this.battlePass.splice(0);
            this.battlePass = null;
         }
         if(this.quests != null)
         {
            this.quests.splice(0);
            this.quests = null;
         }
         if(this.unlocks != null)
         {
            this.unlocks.splice(0);
            this.unlocks = null;
         }
         if(this.team1 != null)
         {
            for each(_loc1_ in this.team1)
            {
               _loc1_.dispose();
            }
            this.team1.cleanUp();
            this.team1 = null;
         }
         if(this.team2 != null)
         {
            for each(_loc1_ in this.team2)
            {
               _loc1_.dispose();
            }
            this.team2.cleanUp();
            this.team2 = null;
         }
         if(this.tabInfo != null)
         {
            for each(_loc2_ in this.tabInfo)
            {
               _loc2_.dispose();
            }
            this.tabInfo.cleanUp();
            this.tabInfo = null;
         }
         if(this.vehicles != null)
         {
            this.vehicles.splice(0);
            this.vehicles = null;
         }
         if(this.textData != null)
         {
            this.textData.dispose();
            this.textData = null;
         }
         if(this.progressiveReward)
         {
            this.progressiveReward.dispose();
            this.progressiveReward = null;
         }
         this.common.dispose();
         this.common = null;
         this.personal.dispose();
         this.personal = null;
         super.onDispose();
      }
   }
}
