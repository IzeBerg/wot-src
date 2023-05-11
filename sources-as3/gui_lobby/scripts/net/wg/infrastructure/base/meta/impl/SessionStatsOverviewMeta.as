package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.ButtonPropertiesVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsOverviewVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SessionStatsOverviewMeta extends BaseDAAPIComponent
   {
       
      
      public var onClickMoreBtn:Function;
      
      public var onClickResetBtn:Function;
      
      public var onClickSettingsBtn:Function;
      
      public var onExpanded:Function;
      
      public var onTabSelected:Function;
      
      public var onCounterUpdated:Function;
      
      private var _sessionStatsOverviewVO:SessionStatsOverviewVO;
      
      private var _vectorButtonPropertiesVO:Vector.<ButtonPropertiesVO>;
      
      public function SessionStatsOverviewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ButtonPropertiesVO = null;
         if(this._sessionStatsOverviewVO)
         {
            this._sessionStatsOverviewVO.dispose();
            this._sessionStatsOverviewVO = null;
         }
         if(this._vectorButtonPropertiesVO)
         {
            for each(_loc1_ in this._vectorButtonPropertiesVO)
            {
               _loc1_.dispose();
            }
            this._vectorButtonPropertiesVO.splice(0,this._vectorButtonPropertiesVO.length);
            this._vectorButtonPropertiesVO = null;
         }
         super.onDispose();
      }
      
      public function onClickMoreBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickMoreBtn,"onClickMoreBtn" + Errors.CANT_NULL);
         this.onClickMoreBtn();
      }
      
      public function onClickResetBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickResetBtn,"onClickResetBtn" + Errors.CANT_NULL);
         this.onClickResetBtn();
      }
      
      public function onClickSettingsBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickSettingsBtn,"onClickSettingsBtn" + Errors.CANT_NULL);
         this.onClickSettingsBtn();
      }
      
      public function onExpandedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onExpanded,"onExpanded" + Errors.CANT_NULL);
         this.onExpanded(param1);
      }
      
      public function onTabSelectedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onTabSelected,"onTabSelected" + Errors.CANT_NULL);
         this.onTabSelected(param1);
      }
      
      public function onCounterUpdatedS() : void
      {
         App.utils.asserter.assertNotNull(this.onCounterUpdated,"onCounterUpdated" + Errors.CANT_NULL);
         this.onCounterUpdated();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SessionStatsOverviewVO = this._sessionStatsOverviewVO;
         this._sessionStatsOverviewVO = new SessionStatsOverviewVO(param1);
         this.setData(this._sessionStatsOverviewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setButtonsState(param1:Array) : void
      {
         var _loc5_:ButtonPropertiesVO = null;
         var _loc2_:Vector.<ButtonPropertiesVO> = this._vectorButtonPropertiesVO;
         this._vectorButtonPropertiesVO = new Vector.<ButtonPropertiesVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorButtonPropertiesVO[_loc4_] = new ButtonPropertiesVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setButtonsState(this._vectorButtonPropertiesVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setData(param1:SessionStatsOverviewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setButtonsState(param1:Vector.<ButtonPropertiesVO>) : void
      {
         var _loc2_:String = "as_setButtonsState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
