package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewBlockVO;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainCrewOperationVO;
   import net.wg.gui.lobby.retrainCrewWindow.RetrainVehicleBlockVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RetrainCrewWindowMeta extends AbstractWindowView
   {
       
      
      public var submit:Function;
      
      public var changeRetrainType:Function;
      
      private var _retrainCrewBlockVO:RetrainCrewBlockVO;
      
      private var _retrainVehicleBlockVO:RetrainVehicleBlockVO;
      
      private var _retrainCrewOperationVO:RetrainCrewOperationVO;
      
      public function RetrainCrewWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._retrainCrewBlockVO)
         {
            this._retrainCrewBlockVO.dispose();
            this._retrainCrewBlockVO = null;
         }
         if(this._retrainVehicleBlockVO)
         {
            this._retrainVehicleBlockVO.dispose();
            this._retrainVehicleBlockVO = null;
         }
         if(this._retrainCrewOperationVO)
         {
            this._retrainCrewOperationVO.dispose();
            this._retrainCrewOperationVO = null;
         }
         super.onDispose();
      }
      
      public function submitS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1);
      }
      
      public function changeRetrainTypeS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.changeRetrainType,"changeRetrainType" + Errors.CANT_NULL);
         this.changeRetrainType(param1);
      }
      
      public final function as_setCrewData(param1:Object) : void
      {
         var _loc2_:RetrainCrewBlockVO = this._retrainCrewBlockVO;
         this._retrainCrewBlockVO = new RetrainCrewBlockVO(param1);
         this.setCrewData(this._retrainCrewBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setVehicleData(param1:Object) : void
      {
         var _loc2_:RetrainVehicleBlockVO = this._retrainVehicleBlockVO;
         this._retrainVehicleBlockVO = new RetrainVehicleBlockVO(param1);
         this.setVehicleData(this._retrainVehicleBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCrewOperationData(param1:Object) : void
      {
         var _loc2_:RetrainCrewOperationVO = this._retrainCrewOperationVO;
         this._retrainCrewOperationVO = new RetrainCrewOperationVO(param1);
         this.setCrewOperationData(this._retrainCrewOperationVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setCrewData(param1:RetrainCrewBlockVO) : void
      {
         var _loc2_:String = "as_setCrewData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehicleData(param1:RetrainVehicleBlockVO) : void
      {
         var _loc2_:String = "as_setVehicleData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCrewOperationData(param1:RetrainCrewOperationVO) : void
      {
         var _loc2_:String = "as_setCrewOperationData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
