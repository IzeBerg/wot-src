package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.ChainsPanelVO;
   import net.wg.gui.lobby.personalMissions.data.OperationsHeaderVO;
   import net.wg.gui.lobby.personalMissions.data.StatusFooterVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionsPageMeta extends AbstractScreen
   {
       
      
      public var onBarClick:Function;
      
      public var onSkipTaskClick:Function;
      
      public var onBackBtnClick:Function;
      
      public var closeView:Function;
      
      public var onTutorialAcceptBtnClicked:Function;
      
      public var showAwards:Function;
      
      private var _operationsHeaderVO:OperationsHeaderVO;
      
      private var _chainsPanelVO:ChainsPanelVO;
      
      private var _statusFooterVO:StatusFooterVO;
      
      public function PersonalMissionsPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._operationsHeaderVO)
         {
            this._operationsHeaderVO.dispose();
            this._operationsHeaderVO = null;
         }
         if(this._chainsPanelVO)
         {
            this._chainsPanelVO.dispose();
            this._chainsPanelVO = null;
         }
         if(this._statusFooterVO)
         {
            this._statusFooterVO.dispose();
            this._statusFooterVO = null;
         }
         super.onDispose();
      }
      
      public function onBarClickS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onBarClick,"onBarClick" + Errors.CANT_NULL);
         this.onBarClick(param1,param2);
      }
      
      public function onSkipTaskClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onSkipTaskClick,"onSkipTaskClick" + Errors.CANT_NULL);
         this.onSkipTaskClick();
      }
      
      public function onBackBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackBtnClick,"onBackBtnClick" + Errors.CANT_NULL);
         this.onBackBtnClick();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function onTutorialAcceptBtnClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onTutorialAcceptBtnClicked,"onTutorialAcceptBtnClicked" + Errors.CANT_NULL);
         this.onTutorialAcceptBtnClicked();
      }
      
      public function showAwardsS() : void
      {
         App.utils.asserter.assertNotNull(this.showAwards,"showAwards" + Errors.CANT_NULL);
         this.showAwards();
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:OperationsHeaderVO = this._operationsHeaderVO;
         this._operationsHeaderVO = new OperationsHeaderVO(param1);
         this.setHeaderData(this._operationsHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateSideBarData(param1:Object) : void
      {
         var _loc2_:ChainsPanelVO = this._chainsPanelVO;
         this._chainsPanelVO = new ChainsPanelVO(param1);
         this.updateSideBarData(this._chainsPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setStatusData(param1:Object) : void
      {
         var _loc2_:StatusFooterVO = this._statusFooterVO;
         this._statusFooterVO = new StatusFooterVO(param1);
         this.setStatusData(this._statusFooterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeaderData(param1:OperationsHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateSideBarData(param1:ChainsPanelVO) : void
      {
         var _loc2_:String = "as_updateSideBarData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setStatusData(param1:StatusFooterVO) : void
      {
         var _loc2_:String = "as_setStatusData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
