package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsLeagueVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesRewardsLeaguesMeta extends RankedBattlesViewStackComponent
   {
       
      
      public var onStyleClick:Function;
      
      private var _rewardsLeagueVO:RewardsLeagueVO;
      
      public function RankedBattlesRewardsLeaguesMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rewardsLeagueVO)
         {
            this._rewardsLeagueVO.dispose();
            this._rewardsLeagueVO = null;
         }
         super.onDispose();
      }
      
      public function onStyleClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onStyleClick,"onStyleClick" + Errors.CANT_NULL);
         this.onStyleClick(param1);
      }
      
      public final function as_setRewards(param1:Object) : void
      {
         var _loc2_:RewardsLeagueVO = this._rewardsLeagueVO;
         this._rewardsLeagueVO = new RewardsLeagueVO(param1);
         this.setRewards(this._rewardsLeagueVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setRewards(param1:RewardsLeagueVO) : void
      {
         var _loc2_:String = "as_setRewards" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
