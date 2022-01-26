package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsControlsVO;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class SessionStatsSettingsMeta extends BaseDAAPIComponent
   {
       
      
      public var onClickApplyBtn:Function;
      
      public var onClickBackBtn:Function;
      
      public var onClickResetBtn:Function;
      
      public var onSettingsInputChanged:Function;
      
      private var _sessionStatsSettingsVO:SessionStatsSettingsVO;
      
      private var _sessionStatsSettingsControlsVO:SessionStatsSettingsControlsVO;
      
      public function SessionStatsSettingsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._sessionStatsSettingsVO)
         {
            this._sessionStatsSettingsVO.dispose();
            this._sessionStatsSettingsVO = null;
         }
         if(this._sessionStatsSettingsControlsVO)
         {
            this._sessionStatsSettingsControlsVO.dispose();
            this._sessionStatsSettingsControlsVO = null;
         }
         super.onDispose();
      }
      
      public function onClickApplyBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickApplyBtn,"onClickApplyBtn" + Errors.CANT_NULL);
         this.onClickApplyBtn();
      }
      
      public function onClickBackBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickBackBtn,"onClickBackBtn" + Errors.CANT_NULL);
         this.onClickBackBtn();
      }
      
      public function onClickResetBtnS() : void
      {
         App.utils.asserter.assertNotNull(this.onClickResetBtn,"onClickResetBtn" + Errors.CANT_NULL);
         this.onClickResetBtn();
      }
      
      public function onSettingsInputChangedS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSettingsInputChanged,"onSettingsInputChanged" + Errors.CANT_NULL);
         this.onSettingsInputChanged(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:SessionStatsSettingsVO = this._sessionStatsSettingsVO;
         this._sessionStatsSettingsVO = new SessionStatsSettingsVO(param1);
         this.setData(this._sessionStatsSettingsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setControlsState(param1:Object) : void
      {
         var _loc2_:SessionStatsSettingsControlsVO = this._sessionStatsSettingsControlsVO;
         this._sessionStatsSettingsControlsVO = new SessionStatsSettingsControlsVO(param1);
         this.setControlsState(this._sessionStatsSettingsControlsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:SessionStatsSettingsVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setControlsState(param1:SessionStatsSettingsControlsVO) : void
      {
         var _loc2_:String = "as_setControlsState" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
