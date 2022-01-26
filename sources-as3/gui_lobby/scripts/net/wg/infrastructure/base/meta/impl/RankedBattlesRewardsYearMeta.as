package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedRewardsYearVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesRewardsYearMeta extends RankedBattlesViewStackComponent
   {
       
      
      private var _rankedRewardsYearVO:RankedRewardsYearVO;
      
      public function RankedBattlesRewardsYearMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedRewardsYearVO)
         {
            this._rankedRewardsYearVO.dispose();
            this._rankedRewardsYearVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedRewardsYearVO = this._rankedRewardsYearVO;
         this._rankedRewardsYearVO = new RankedRewardsYearVO(param1);
         this.setData(this._rankedRewardsYearVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RankedRewardsYearVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
