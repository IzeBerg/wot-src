package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailsContainerVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseMissionDetailsContainerViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var requestMissionData:Function;
      
      private var _baseMissionDetailsContainerVO:BaseMissionDetailsContainerVO;
      
      private var _baseMissionDetailedViewVO:BaseMissionDetailedViewVO;
      
      public function BaseMissionDetailsContainerViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._baseMissionDetailsContainerVO)
         {
            this._baseMissionDetailsContainerVO.dispose();
            this._baseMissionDetailsContainerVO = null;
         }
         if(this._baseMissionDetailedViewVO)
         {
            this._baseMissionDetailedViewVO.dispose();
            this._baseMissionDetailedViewVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function requestMissionDataS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.requestMissionData,"requestMissionData" + Errors.CANT_NULL);
         this.requestMissionData(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:BaseMissionDetailsContainerVO = this._baseMissionDetailsContainerVO;
         this._baseMissionDetailsContainerVO = this.getBaseMissionDetailsContainerVOForData(param1);
         this.setInitData(this._baseMissionDetailsContainerVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setMissionData(param1:Object) : void
      {
         var _loc2_:BaseMissionDetailedViewVO = this._baseMissionDetailedViewVO;
         this._baseMissionDetailedViewVO = this.getBaseMissionDetailedViewVOForData(param1);
         this.setMissionData(this._baseMissionDetailedViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getBaseMissionDetailsContainerVOForData(param1:Object) : BaseMissionDetailsContainerVO
      {
         var _loc2_:String = "getBaseMissionDetailsContainerVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setInitData(param1:BaseMissionDetailsContainerVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getBaseMissionDetailedViewVOForData(param1:Object) : BaseMissionDetailedViewVO
      {
         var _loc2_:String = "getBaseMissionDetailedViewVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setMissionData(param1:BaseMissionDetailedViewVO) : void
      {
         var _loc2_:String = "as_setMissionData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
