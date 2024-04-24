package net.wg.gui.lobby.battleResults.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CommonStatsVO extends DAAPIDataClass
   {
      
      private static const TIME_STATS:String = "timeStats";
      
      private static const VICTORY_SCORE:String = "victoryScore";
      
      private static const PLAYER_VEHICLES:String = "playerVehicles";
      
      private static const OVERTIME:String = "overtime";
      
      private static const RANK:String = "rank";
      
      private static const COMP7_RATING:String = "comp7Rating";
      
      public static const SHOW_SQUAD:Number = 1;
      
      public static const SHOW_RESOURCES:Number = 2;
       
      
      public var arenaCreateTimeStr:String = "";
      
      public var arenaCreateTimeOnlyStr:String = "";
      
      public var arenaIcon:String = "";
      
      public var arenaStr:String = "";
      
      public var arenaType:int = -1;
      
      public var battleResultsSharingIsAvailable:Boolean = false;
      
      public var bonusType:Number = 0;
      
      public var clans:Object = null;
      
      public var duration:String = "";
      
      public var finishReasonStr:String = "";
      
      public var finishReasonClarificationStr:String = "";
      
      public var iconType:String = "";
      
      public var playerFakeNameStr:String = "";
      
      public var playerRealNameStr:String = "";
      
      public var clanNameStr:String = "";
      
      public var playerFullNameStr:String = "";
      
      public var regionNameStr:String = "";
      
      public var playerKilled:String = "";
      
      public var playerVehicles:Vector.<VehicleStatsVO> = null;
      
      public var playerVehicleNames:Array;
      
      public var resultShortStr:String = "";
      
      public var resultStr:String = "";
      
      public var sortDirection:String = "";
      
      public var timeStats:Vector.<StatItemVO> = null;
      
      public var totalFortResourceStr:String = "";
      
      public var totalInfluenceStr:String = "";
      
      public var modificationIconPath:String = "";
      
      public var modificationStr:String = "";
      
      public var victoryScore:Vector.<VictoryPanelVO>;
      
      public var wasInBattle:Boolean = false;
      
      public var overtime:OvertimeVO;
      
      public var clientArenaIdx:Number;
      
      public var uiVisibility:Number = 0;
      
      public var rank:RankedBattleSubTaskVO = null;
      
      public var eligibleForCrystalRewards:Boolean = false;
      
      public var epicMode:Boolean = false;
      
      public var comp7Rating:Comp7SubTaskVO = null;
      
      public function CommonStatsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         switch(param1)
         {
            case TIME_STATS:
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,"Field \'timeStats\' is expected to be array");
               this.fillTimeStatValues(_loc3_);
               return false;
            case VICTORY_SCORE:
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,"Field \'victoryScore\' is expected to be array");
               this.fillVictoryScore(_loc3_);
               return false;
            case PLAYER_VEHICLES:
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,"Field \'playerVehicles\' is expected to be array");
               this.fillPlayerVehicles(_loc3_);
               return false;
            case OVERTIME:
               this.overtime = new OvertimeVO(param2);
               return false;
            case RANK:
               this.rank = Boolean(param2) ? new RankedBattleSubTaskVO(param2) : null;
               return false;
            case COMP7_RATING:
               this.comp7Rating = Boolean(param2) ? new Comp7SubTaskVO(param2) : null;
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         App.utils.data.cleanupDynamicObject(this.clans);
         this.clans = null;
         this.overtime.dispose();
         this.overtime = null;
         var _loc1_:int = this.playerVehicles.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.playerVehicles[_loc2_].dispose();
            _loc2_++;
         }
         this.playerVehicles.splice(0,_loc1_);
         this.playerVehicles = null;
         this.playerVehicleNames.splice(0,this.playerVehicleNames.length);
         this.playerVehicleNames = null;
         if(this.timeStats != null)
         {
            _loc3_ = this.timeStats.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this.timeStats[_loc2_].dispose();
               _loc2_++;
            }
            this.timeStats.splice(0,_loc3_);
            this.timeStats = null;
         }
         if(this.victoryScore != null)
         {
            _loc4_ = this.victoryScore.length;
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               this.victoryScore[_loc2_].dispose();
               _loc2_++;
            }
            this.victoryScore.splice(0,_loc4_);
            this.victoryScore = null;
         }
         if(this.rank)
         {
            this.rank.dispose();
            this.rank = null;
         }
         if(this.comp7Rating)
         {
            this.comp7Rating.dispose();
            this.comp7Rating = null;
         }
         super.onDispose();
      }
      
      private function fillPlayerVehicles(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.playerVehicles = new Vector.<VehicleStatsVO>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.playerVehicles[_loc3_] = new VehicleStatsVO(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      private function fillVictoryScore(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.victoryScore = new Vector.<VictoryPanelVO>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.victoryScore[_loc3_] = new VictoryPanelVO(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      private function fillTimeStatValues(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.length;
            this.timeStats = new Vector.<StatItemVO>(_loc2_);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this.timeStats[_loc3_] = new StatItemVO(param1[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function get isShowSquad() : Boolean
      {
         return (this.uiVisibility & SHOW_SQUAD) > 0;
      }
      
      public function get isShowResources() : Boolean
      {
         return (this.uiVisibility & SHOW_RESOURCES) > 0;
      }
   }
}
