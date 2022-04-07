package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesSeasonCompleteViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesSeasonCompleteViewMeta extends AbstractView
   {
       
      
      public var showRating:Function;
      
      public var closeView:Function;
      
      public var onSoundTrigger:Function;
      
      private var _rankedBattlesSeasonCompleteViewVO:RankedBattlesSeasonCompleteViewVO;
      
      private var _ribbonAwardsVO:RibbonAwardsVO;
      
      public function RankedBattlesSeasonCompleteViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattlesSeasonCompleteViewVO)
         {
            this._rankedBattlesSeasonCompleteViewVO.dispose();
            this._rankedBattlesSeasonCompleteViewVO = null;
         }
         if(this._ribbonAwardsVO)
         {
            this._ribbonAwardsVO.dispose();
            this._ribbonAwardsVO = null;
         }
         super.onDispose();
      }
      
      public function showRatingS() : void
      {
         App.utils.asserter.assertNotNull(this.showRating,"showRating" + Errors.CANT_NULL);
         this.showRating();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function onSoundTriggerS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSoundTrigger,"onSoundTrigger" + Errors.CANT_NULL);
         this.onSoundTrigger(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedBattlesSeasonCompleteViewVO = this._rankedBattlesSeasonCompleteViewVO;
         this._rankedBattlesSeasonCompleteViewVO = new RankedBattlesSeasonCompleteViewVO(param1);
         this.setData(this._rankedBattlesSeasonCompleteViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setAwardsData(param1:Object) : void
      {
         var _loc2_:RibbonAwardsVO = this._ribbonAwardsVO;
         this._ribbonAwardsVO = new RibbonAwardsVO(param1);
         this.setAwardsData(this._ribbonAwardsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RankedBattlesSeasonCompleteViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAwardsData(param1:RibbonAwardsVO) : void
      {
         var _loc2_:String = "as_setAwardsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
