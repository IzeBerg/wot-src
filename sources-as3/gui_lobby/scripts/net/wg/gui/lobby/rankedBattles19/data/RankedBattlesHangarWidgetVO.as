package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattlesHangarWidgetVO extends DAAPIDataClass
   {
      
      private static const RANK_LEFT_VO:String = "rankLeftVO";
      
      private static const RANK_RIGHT_VO:String = "rankRightVO";
      
      private static const NEW_RANK_VO:String = "newRankVO";
      
      private static const STEPS_CONTAINER_VO:String = "stepsContainerVO";
      
      private static const NEW_STEPS_CONTAINER_VO:String = "newStepsContainerVO";
      
      private static const FINAL_STATE_VO:String = "finalState";
      
      private static const DIVISION_VO:String = "divisionVO";
      
      private static const LEAGUE_VO:String = "leagueVO";
      
      private static const NEW_LEAGUE_VO:String = "newLeagueVO";
       
      
      public var infoText:String = "";
      
      public var nextInfoText:String = "";
      
      public var rankLeftVO:RankIconVO = null;
      
      public var rankRightVO:RankIconVO = null;
      
      public var newRankVO:RankIconVO = null;
      
      public var state:String = "";
      
      public var stepsContainerVO:StepsContainerVO = null;
      
      public var newStepsContainerVO:StepsContainerVO = null;
      
      public var isHuge:Boolean = false;
      
      public var finalState:RankedBattlesHangarWidgetVO = null;
      
      public var animationEnabled:Boolean = true;
      
      public var divisionVO:WidgetDivisionVO = null;
      
      public var leagueVO:WidgetLeagueVO = null;
      
      public var newLeagueVO:WidgetLeagueVO = null;
      
      public function RankedBattlesHangarWidgetVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param2 != null)
         {
            if(param1 == STEPS_CONTAINER_VO)
            {
               this.stepsContainerVO = new StepsContainerVO(param2);
               return false;
            }
            if(param1 == RANK_LEFT_VO)
            {
               this.rankLeftVO = new RankIconVO(param2);
               return false;
            }
            if(param1 == RANK_RIGHT_VO)
            {
               this.rankRightVO = new RankIconVO(param2);
               return false;
            }
            if(param1 == NEW_RANK_VO)
            {
               this.newRankVO = new RankIconVO(param2);
               return false;
            }
            if(param1 == NEW_STEPS_CONTAINER_VO)
            {
               this.newStepsContainerVO = new StepsContainerVO(param2);
               return false;
            }
            if(param1 == FINAL_STATE_VO)
            {
               this.finalState = new RankedBattlesHangarWidgetVO(param2);
               return false;
            }
            if(param1 == DIVISION_VO)
            {
               this.divisionVO = new WidgetDivisionVO(param2);
               return false;
            }
            if(param1 == LEAGUE_VO)
            {
               this.leagueVO = new WidgetLeagueVO(param2);
               return false;
            }
            if(param1 == NEW_LEAGUE_VO)
            {
               this.newLeagueVO = new WidgetLeagueVO(param2);
               return false;
            }
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.rankLeftVO != null)
         {
            this.rankLeftVO.dispose();
            this.rankLeftVO = null;
         }
         if(this.rankRightVO != null)
         {
            this.rankRightVO.dispose();
            this.rankRightVO = null;
         }
         if(this.newRankVO != null)
         {
            this.newRankVO.dispose();
            this.newRankVO = null;
         }
         if(this.stepsContainerVO != null)
         {
            this.stepsContainerVO.dispose();
            this.stepsContainerVO = null;
         }
         if(this.newStepsContainerVO != null)
         {
            this.newStepsContainerVO.dispose();
            this.newStepsContainerVO = null;
         }
         if(this.finalState != null)
         {
            this.finalState.dispose();
            this.finalState = null;
         }
         if(this.divisionVO != null)
         {
            this.divisionVO.dispose();
            this.divisionVO = null;
         }
         if(this.leagueVO != null)
         {
            this.leagueVO.dispose();
            this.leagueVO = null;
         }
         if(this.newLeagueVO != null)
         {
            this.newLeagueVO.dispose();
            this.newLeagueVO = null;
         }
         super.onDispose();
      }
   }
}
