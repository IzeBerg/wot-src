package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleResultsMeta extends AbstractWindowView
   {
       
      
      public var saveSorting:Function;
      
      public var showEventsWindow:Function;
      
      public var getClanEmblem:Function;
      
      public var onResultsSharingBtnPress:Function;
      
      public var showUnlockWindow:Function;
      
      public var showProgressiveRewardView:Function;
      
      public var onAppliedPremiumBonus:Function;
      
      public var onShowDetailsPremium:Function;
      
      public var onShowDetailsWotPlus:Function;
      
      public var onShowManageableXPScreen:Function;
      
      public var showDogTagWindow:Function;
      
      public var showVehicleStats:Function;
      
      private var _battleResultsVO:BattleResultsVO;
      
      public function BattleResultsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleResultsVO)
         {
            this._battleResultsVO.dispose();
            this._battleResultsVO = null;
         }
         super.onDispose();
      }
      
      public function saveSortingS(param1:String, param2:String, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.saveSorting,"saveSorting" + Errors.CANT_NULL);
         this.saveSorting(param1,param2,param3);
      }
      
      public function showEventsWindowS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.showEventsWindow,"showEventsWindow" + Errors.CANT_NULL);
         this.showEventsWindow(param1,param2);
      }
      
      public function getClanEmblemS(param1:String, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.getClanEmblem,"getClanEmblem" + Errors.CANT_NULL);
         this.getClanEmblem(param1,param2);
      }
      
      public function onResultsSharingBtnPressS() : void
      {
         App.utils.asserter.assertNotNull(this.onResultsSharingBtnPress,"onResultsSharingBtnPress" + Errors.CANT_NULL);
         this.onResultsSharingBtnPress();
      }
      
      public function showUnlockWindowS(param1:int, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.showUnlockWindow,"showUnlockWindow" + Errors.CANT_NULL);
         this.showUnlockWindow(param1,param2);
      }
      
      public function showProgressiveRewardViewS() : void
      {
         App.utils.asserter.assertNotNull(this.showProgressiveRewardView,"showProgressiveRewardView" + Errors.CANT_NULL);
         this.showProgressiveRewardView();
      }
      
      public function onAppliedPremiumBonusS() : void
      {
         App.utils.asserter.assertNotNull(this.onAppliedPremiumBonus,"onAppliedPremiumBonus" + Errors.CANT_NULL);
         this.onAppliedPremiumBonus();
      }
      
      public function onShowDetailsPremiumS() : void
      {
         App.utils.asserter.assertNotNull(this.onShowDetailsPremium,"onShowDetailsPremium" + Errors.CANT_NULL);
         this.onShowDetailsPremium();
      }
      
      public function onShowDetailsWotPlusS() : void
      {
         App.utils.asserter.assertNotNull(this.onShowDetailsWotPlus,"onShowDetailsWotPlus" + Errors.CANT_NULL);
         this.onShowDetailsWotPlus();
      }
      
      public function onShowManageableXPScreenS() : void
      {
         App.utils.asserter.assertNotNull(this.onShowManageableXPScreen,"onShowManageableXPScreen" + Errors.CANT_NULL);
         this.onShowManageableXPScreen();
      }
      
      public function showDogTagWindowS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.showDogTagWindow,"showDogTagWindow" + Errors.CANT_NULL);
         this.showDogTagWindow(param1);
      }
      
      public function showVehicleStatsS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.showVehicleStats,"showVehicleStats" + Errors.CANT_NULL);
         this.showVehicleStats(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BattleResultsVO = this._battleResultsVO;
         this._battleResultsVO = new BattleResultsVO(param1);
         this.setData(this._battleResultsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BattleResultsVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
