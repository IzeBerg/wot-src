package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareConfiguratorInitDataVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleCompareConfiguratorBaseViewMeta extends BaseDAAPIComponent
   {
       
      
      public var applyConfig:Function;
      
      public var resetConfig:Function;
      
      public var onCloseView:Function;
      
      private var _vehicleCompareConfiguratorInitDataVO:VehicleCompareConfiguratorInitDataVO;
      
      public function VehicleCompareConfiguratorBaseViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleCompareConfiguratorInitDataVO)
         {
            this._vehicleCompareConfiguratorInitDataVO.dispose();
            this._vehicleCompareConfiguratorInitDataVO = null;
         }
         super.onDispose();
      }
      
      public function applyConfigS() : void
      {
         App.utils.asserter.assertNotNull(this.applyConfig,"applyConfig" + Errors.CANT_NULL);
         this.applyConfig();
      }
      
      public function resetConfigS() : void
      {
         App.utils.asserter.assertNotNull(this.resetConfig,"resetConfig" + Errors.CANT_NULL);
         this.resetConfig();
      }
      
      public function onCloseViewS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseView,"onCloseView" + Errors.CANT_NULL);
         this.onCloseView();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:VehicleCompareConfiguratorInitDataVO = this._vehicleCompareConfiguratorInitDataVO;
         this._vehicleCompareConfiguratorInitDataVO = this.getVehicleCompareConfiguratorInitDataVOForData(param1);
         this.setInitData(this._vehicleCompareConfiguratorInitDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getVehicleCompareConfiguratorInitDataVOForData(param1:Object) : VehicleCompareConfiguratorInitDataVO
      {
         var _loc2_:String = "getVehicleCompareConfiguratorInitDataVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setInitData(param1:VehicleCompareConfiguratorInitDataVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
