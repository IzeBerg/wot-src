package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.OperationAwardsVO;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsAbstractInfoViewVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalMissionsAbstractInfoViewMeta extends AbstractScreen
   {
       
      
      public var bigBtnClicked:Function;
      
      private var _personalMissionsAbstractInfoViewVO:PersonalMissionsAbstractInfoViewVO;
      
      private var _operationAwardsVO:OperationAwardsVO;
      
      public function PersonalMissionsAbstractInfoViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalMissionsAbstractInfoViewVO)
         {
            this._personalMissionsAbstractInfoViewVO.dispose();
            this._personalMissionsAbstractInfoViewVO = null;
         }
         if(this._operationAwardsVO)
         {
            this._operationAwardsVO.dispose();
            this._operationAwardsVO = null;
         }
         super.onDispose();
      }
      
      public function bigBtnClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.bigBtnClicked,"bigBtnClicked" + Errors.CANT_NULL);
         this.bigBtnClicked();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:PersonalMissionsAbstractInfoViewVO = this._personalMissionsAbstractInfoViewVO;
         this._personalMissionsAbstractInfoViewVO = this.getPersonalMissionsAbstractInfoViewVOForData(param1);
         this.setInitData(this._personalMissionsAbstractInfoViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_update(param1:Object) : void
      {
         var _loc2_:OperationAwardsVO = this._operationAwardsVO;
         this._operationAwardsVO = this.getOperationAwardsVOForData(param1);
         this.update(this._operationAwardsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getPersonalMissionsAbstractInfoViewVOForData(param1:Object) : PersonalMissionsAbstractInfoViewVO
      {
         var _loc2_:String = "getPersonalMissionsAbstractInfoViewVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setInitData(param1:PersonalMissionsAbstractInfoViewVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getOperationAwardsVOForData(param1:Object) : OperationAwardsVO
      {
         var _loc2_:String = "getOperationAwardsVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function update(param1:OperationAwardsVO) : void
      {
         var _loc2_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
