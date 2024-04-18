package net.wg.gui.bootcamp.battleResult.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class BCBattleViewVO extends DAAPIDataClass
   {
      
      private static const STATS_FIELD:String = "stats";
      
      private static const REWARDS:String = "rewards";
      
      private static const UNLOCKS:String = "unlocks";
      
      private static const RIBBONS:String = "ribbons";
      
      private static const MEDALS:String = "medals";
      
      private static const XP_STATS_FIELD:String = "xp";
      
      private static const CREDITS_STATS_FIELD:String = "credits";
      
      private static const VIDEO_BUTTONS_FIELD:String = "videoButtons";
       
      
      public var stats:DataProvider;
      
      public var unlocks:DataProvider;
      
      public var ribbons:DataProvider;
      
      public var medals:DataProvider;
      
      public var showRewards:Boolean = true;
      
      public var credits:RewardDataVO = null;
      
      public var xp:RewardDataVO = null;
      
      public var videoButtons:DataProvider = null;
      
      public var hasUnlocks:Boolean = false;
      
      public var alternativeLayout:Boolean = false;
      
      public var finishReason:String = "";
      
      public var playerName:String = "";
      
      public var playerResult:String = "";
      
      public var finishReasonStr:String = "";
      
      public var background:String = "";
      
      public var resultTypeStr:String = "";
      
      public function BCBattleViewVO(param1:Object)
      {
         super(param1);
      }
      
      override public function fromHash(param1:Object) : void
      {
         var _loc2_:BattleItemRendererVO = null;
         super.fromHash(param1);
         for each(_loc2_ in this.stats)
         {
            _loc2_.finishReason = this.finishReason;
         }
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:BattleItemRendererVO = null;
         var _loc5_:Array = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:RewardVideoDataVO = null;
         if(param1 == STATS_FIELD)
         {
            this.stats = new DataProvider();
            _loc5_ = param2 as Array;
            for each(_loc3_ in _loc5_)
            {
               _loc4_ = new BattleItemRendererVO(_loc3_);
               this.stats.push(_loc4_);
            }
            return false;
         }
         if(param1 == REWARDS)
         {
            for(_loc6_ in param2)
            {
               this.onDataWrite(_loc6_,param2[_loc6_]);
            }
            return false;
         }
         if(param1 == UNLOCKS)
         {
            this.unlocks = new DataProvider();
            _loc5_ = param2 as Array;
            for each(_loc3_ in _loc5_)
            {
               _loc4_ = new BattleItemRendererVO(_loc3_);
               this.unlocks.push(_loc4_);
            }
            return false;
         }
         if(param1 == RIBBONS)
         {
            this.ribbons = new DataProvider();
            _loc5_ = param2 as Array;
            for each(_loc3_ in _loc5_)
            {
               _loc4_ = new BattleItemRendererVO(_loc3_);
               this.ribbons.push(_loc4_);
            }
            return false;
         }
         if(param1 == MEDALS)
         {
            this.medals = new DataProvider();
            _loc5_ = param2 as Array;
            for each(_loc3_ in _loc5_)
            {
               _loc4_ = new BattleItemRendererVO(_loc3_);
               this.medals.push(_loc4_);
            }
            return false;
         }
         if(param1 == XP_STATS_FIELD)
         {
            this.xp = new RewardDataVO(param2);
            return false;
         }
         if(param1 == CREDITS_STATS_FIELD)
         {
            this.credits = new RewardDataVO(param2);
            return false;
         }
         if(param1 == VIDEO_BUTTONS_FIELD)
         {
            this.videoButtons = new DataProvider();
            _loc5_ = param2 as Array;
            _loc7_ = _loc5_.length;
            for each(_loc3_ in _loc5_)
            {
               _loc8_ = new RewardVideoDataVO(_loc3_);
               _loc8_.totalCount = _loc7_;
               this.videoButtons.push(_loc8_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleItemRendererVO = null;
         var _loc2_:RewardVideoDataVO = null;
         if(this.stats)
         {
            for each(_loc1_ in this.stats)
            {
               _loc1_.dispose();
            }
            this.stats.cleanUp();
            this.stats = null;
         }
         if(this.ribbons)
         {
            for each(_loc1_ in this.ribbons)
            {
               _loc1_.dispose();
            }
            this.ribbons.cleanUp();
            this.ribbons = null;
         }
         if(this.medals)
         {
            for each(_loc1_ in this.medals)
            {
               _loc1_.dispose();
            }
            this.medals.cleanUp();
            this.medals = null;
         }
         if(this.unlocks)
         {
            for each(_loc1_ in this.unlocks)
            {
               _loc1_.dispose();
            }
            this.unlocks.cleanUp();
            this.unlocks = null;
         }
         if(this.videoButtons)
         {
            for each(_loc2_ in this.videoButtons)
            {
               _loc2_.dispose();
            }
            this.videoButtons.cleanUp();
            this.videoButtons = null;
         }
         this.resultTypeStr = null;
         this.background = null;
         this.finishReasonStr = null;
         if(this.xp)
         {
            this.xp.dispose();
            this.xp = null;
         }
         if(this.credits)
         {
            this.credits.dispose();
            this.credits = null;
         }
         super.onDispose();
      }
   }
}
