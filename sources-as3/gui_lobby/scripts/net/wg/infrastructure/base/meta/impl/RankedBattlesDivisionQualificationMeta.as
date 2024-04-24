package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesDivisionQualificationMeta extends RankedBattlesViewStackComponent
   {
       
      
      private var _rankedBattlesStatsVO:RankedBattlesStatsVO;
      
      private var _rankedBattlesStatsVO1:RankedBattlesStatsVO;
      
      public function RankedBattlesDivisionQualificationMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattlesStatsVO)
         {
            this._rankedBattlesStatsVO.dispose();
            this._rankedBattlesStatsVO = null;
         }
         if(this._rankedBattlesStatsVO1)
         {
            this._rankedBattlesStatsVO1.dispose();
            this._rankedBattlesStatsVO1 = null;
         }
         super.onDispose();
      }
      
      public final function as_setQualificationEfficiencyData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsVO = this._rankedBattlesStatsVO;
         this._rankedBattlesStatsVO = new RankedBattlesStatsVO(param1);
         this.setQualificationEfficiencyData(this._rankedBattlesStatsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setQualificationStepsData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsVO = this._rankedBattlesStatsVO1;
         this._rankedBattlesStatsVO1 = new RankedBattlesStatsVO(param1);
         this.setQualificationStepsData(this._rankedBattlesStatsVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setQualificationEfficiencyData(param1:RankedBattlesStatsVO) : void
      {
         var _loc2_:String = "as_setQualificationEfficiencyData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setQualificationStepsData(param1:RankedBattlesStatsVO) : void
      {
         var _loc2_:String = "as_setQualificationStepsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
