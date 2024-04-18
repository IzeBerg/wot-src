package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCompare.VehicleCompareCommonView;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareStaticDataVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleCompareViewMeta extends VehicleCompareCommonView
   {
       
      
      public var onBackClick:Function;
      
      public var onGoToPreviewClick:Function;
      
      public var onGoToHangarClick:Function;
      
      public var onSelectModulesClick:Function;
      
      public var onParamDeltaRequested:Function;
      
      public var onCrewLevelChanged:Function;
      
      public var onRemoveVehicle:Function;
      
      public var onRevertVehicle:Function;
      
      public var onRemoveAllVehicles:Function;
      
      private var _vehCompareStaticDataVO:VehCompareStaticDataVO;
      
      private var _vehCompareParamsDeltaVO:VehCompareParamsDeltaVO;
      
      private var _array:Array;
      
      public function VehicleCompareViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehCompareStaticDataVO)
         {
            this._vehCompareStaticDataVO.dispose();
            this._vehCompareStaticDataVO = null;
         }
         if(this._vehCompareParamsDeltaVO)
         {
            this._vehCompareParamsDeltaVO.dispose();
            this._vehCompareParamsDeltaVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         super.onDispose();
      }
      
      public function onBackClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
         this.onBackClick();
      }
      
      public function onGoToPreviewClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onGoToPreviewClick,"onGoToPreviewClick" + Errors.CANT_NULL);
         this.onGoToPreviewClick(param1);
      }
      
      public function onGoToHangarClickS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onGoToHangarClick,"onGoToHangarClick" + Errors.CANT_NULL);
         this.onGoToHangarClick(param1);
      }
      
      public function onSelectModulesClickS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectModulesClick,"onSelectModulesClick" + Errors.CANT_NULL);
         this.onSelectModulesClick(param1,param2);
      }
      
      public function onParamDeltaRequestedS(param1:Number, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.onParamDeltaRequested,"onParamDeltaRequested" + Errors.CANT_NULL);
         this.onParamDeltaRequested(param1,param2);
      }
      
      public function onCrewLevelChangedS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onCrewLevelChanged,"onCrewLevelChanged" + Errors.CANT_NULL);
         this.onCrewLevelChanged(param1,param2);
      }
      
      public function onRemoveVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onRemoveVehicle,"onRemoveVehicle" + Errors.CANT_NULL);
         this.onRemoveVehicle(param1);
      }
      
      public function onRevertVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onRevertVehicle,"onRevertVehicle" + Errors.CANT_NULL);
         this.onRevertVehicle(param1);
      }
      
      public function onRemoveAllVehiclesS() : void
      {
         App.utils.asserter.assertNotNull(this.onRemoveAllVehicles,"onRemoveAllVehicles" + Errors.CANT_NULL);
         this.onRemoveAllVehicles();
      }
      
      public final function as_setStaticData(param1:Object) : void
      {
         var _loc2_:VehCompareStaticDataVO = this._vehCompareStaticDataVO;
         this._vehCompareStaticDataVO = new VehCompareStaticDataVO(param1);
         this.setStaticData(this._vehCompareStaticDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setParamsDelta(param1:Object) : void
      {
         var _loc2_:VehCompareParamsDeltaVO = this._vehCompareParamsDeltaVO;
         this._vehCompareParamsDeltaVO = new VehCompareParamsDeltaVO(param1);
         this.setParamsDelta(this._vehCompareParamsDeltaVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setVehicleParamsData(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setVehicleParamsData(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setStaticData(param1:VehCompareStaticDataVO) : void
      {
         var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setParamsDelta(param1:VehCompareParamsDeltaVO) : void
      {
         var _loc2_:String = "as_setParamsDelta" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehicleParamsData(param1:Array) : void
      {
         var _loc2_:String = "as_setVehicleParamsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
