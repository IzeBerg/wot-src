package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsVO;
   import net.wg.gui.lobby.rankedBattles19.data.SeasonGapViewVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesSeasonGapViewMeta extends RankedBattlesViewStackComponent
   {
       
      
      public var onBtnClick:Function;
      
      private var _seasonGapViewVO:SeasonGapViewVO;
      
      private var _rankedBattlesStatsVO:RankedBattlesStatsVO;
      
      private var _rankedBattlesStatsVO1:RankedBattlesStatsVO;
      
      public function RankedBattlesSeasonGapViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._seasonGapViewVO)
         {
            this._seasonGapViewVO.dispose();
            this._seasonGapViewVO = null;
         }
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
      
      public function onBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBtnClick,"onBtnClick" + Errors.CANT_NULL);
         this.onBtnClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SeasonGapViewVO = this._seasonGapViewVO;
         this._seasonGapViewVO = new SeasonGapViewVO(param1);
         this.setData(this._seasonGapViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setEfficiencyData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsVO = this._rankedBattlesStatsVO;
         this._rankedBattlesStatsVO = new RankedBattlesStatsVO(param1);
         this.setEfficiencyData(this._rankedBattlesStatsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRatingData(param1:Object) : void
      {
         var _loc2_:RankedBattlesStatsVO = this._rankedBattlesStatsVO1;
         this._rankedBattlesStatsVO1 = new RankedBattlesStatsVO(param1);
         this.setRatingData(this._rankedBattlesStatsVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SeasonGapViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setEfficiencyData(param1:RankedBattlesStatsVO) : void
      {
         var _loc2_:String = "as_setEfficiencyData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRatingData(param1:RankedBattlesStatsVO) : void
      {
         var _loc2_:String = "as_setRatingData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
