package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesDivisionProgressVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsBlockVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesDivisionProgressMeta extends RankedBattlesViewStackComponent
   {
       
      
      private var _rankedBattlesStatsBlockVO:RankedBattlesStatsBlockVO;
      
      private var _rankedBattlesDivisionProgressVO:RankedBattlesDivisionProgressVO;
      
      public function RankedBattlesDivisionProgressMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattlesStatsBlockVO)
         {
            this._rankedBattlesStatsBlockVO.dispose();
            this._rankedBattlesStatsBlockVO = null;
         }
         if(this._rankedBattlesDivisionProgressVO)
         {
            this._rankedBattlesDivisionProgressVO.dispose();
            this._rankedBattlesDivisionProgressVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setStatsData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsBlockVO = this._rankedBattlesStatsBlockVO;
         this._rankedBattlesStatsBlockVO = new RankedBattlesStatsBlockVO(param1);
         this.setStatsData(this._rankedBattlesStatsBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRankedData(param1:Object) : void
      {
         var _loc2_:RankedBattlesDivisionProgressVO = this._rankedBattlesDivisionProgressVO;
         this._rankedBattlesDivisionProgressVO = new RankedBattlesDivisionProgressVO(param1);
         this.setRankedData(this._rankedBattlesDivisionProgressVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setStatsData(param1:RankedBattlesStatsBlockVO) : void
      {
         var _loc2_:String = "as_setStatsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRankedData(param1:RankedBattlesDivisionProgressVO) : void
      {
         var _loc2_:String = "as_setRankedData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
