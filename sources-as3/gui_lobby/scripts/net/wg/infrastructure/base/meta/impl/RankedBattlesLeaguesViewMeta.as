package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.LeaguesStatsBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.LeaguesViewVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsDeltaVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsInfoVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesLeaguesViewMeta extends RankedBattlesViewStackComponent
   {
       
      
      private var _leaguesViewVO:LeaguesViewVO;
      
      private var _leaguesStatsBlockVO:LeaguesStatsBlockVO;
      
      private var _rankedBattlesStatsDeltaVO:RankedBattlesStatsDeltaVO;
      
      private var _rankedBattlesStatsInfoVO:RankedBattlesStatsInfoVO;
      
      public function RankedBattlesLeaguesViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._leaguesViewVO)
         {
            this._leaguesViewVO.dispose();
            this._leaguesViewVO = null;
         }
         if(this._leaguesStatsBlockVO)
         {
            this._leaguesStatsBlockVO.dispose();
            this._leaguesStatsBlockVO = null;
         }
         if(this._rankedBattlesStatsDeltaVO)
         {
            this._rankedBattlesStatsDeltaVO.dispose();
            this._rankedBattlesStatsDeltaVO = null;
         }
         if(this._rankedBattlesStatsInfoVO)
         {
            this._rankedBattlesStatsInfoVO.dispose();
            this._rankedBattlesStatsInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:LeaguesViewVO = this._leaguesViewVO;
         this._leaguesViewVO = new LeaguesViewVO(param1);
         this.setData(this._leaguesViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setStatsData(param1:Object) : void
      {
         var _loc2_:LeaguesStatsBlockVO = this._leaguesStatsBlockVO;
         this._leaguesStatsBlockVO = new LeaguesStatsBlockVO(param1);
         this.setStatsData(this._leaguesStatsBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setEfficiencyData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsDeltaVO = this._rankedBattlesStatsDeltaVO;
         this._rankedBattlesStatsDeltaVO = new RankedBattlesStatsDeltaVO(param1);
         this.setEfficiencyData(this._rankedBattlesStatsDeltaVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRatingData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsInfoVO = this._rankedBattlesStatsInfoVO;
         this._rankedBattlesStatsInfoVO = new RankedBattlesStatsInfoVO(param1);
         this.setRatingData(this._rankedBattlesStatsInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:LeaguesViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStatsData(param1:LeaguesStatsBlockVO) : void
      {
         var _loc2_:String = "as_setStatsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setEfficiencyData(param1:RankedBattlesStatsDeltaVO) : void
      {
         var _loc2_:String = "as_setEfficiencyData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRatingData(param1:RankedBattlesStatsInfoVO) : void
      {
         var _loc2_:String = "as_setRatingData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
