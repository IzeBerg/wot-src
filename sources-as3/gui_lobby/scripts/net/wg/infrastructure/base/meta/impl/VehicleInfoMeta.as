package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoButtonDataVO;
   import net.wg.gui.lobby.vehicleInfo.data.VehicleInfoDataVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleInfoMeta extends AbstractWindowView
   {
       
      
      public var getVehicleInfo:Function;
      
      public var onCancelClick:Function;
      
      public var addToCompare:Function;
      
      public var changeNation:Function;
      
      private var _vehicleInfoDataVO:VehicleInfoDataVO;
      
      private var _vehicleInfoButtonDataVO:VehicleInfoButtonDataVO;
      
      private var _vehicleInfoButtonDataVO1:VehicleInfoButtonDataVO;
      
      public function VehicleInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleInfoDataVO)
         {
            this._vehicleInfoDataVO.dispose();
            this._vehicleInfoDataVO = null;
         }
         if(this._vehicleInfoButtonDataVO)
         {
            this._vehicleInfoButtonDataVO.dispose();
            this._vehicleInfoButtonDataVO = null;
         }
         if(this._vehicleInfoButtonDataVO1)
         {
            this._vehicleInfoButtonDataVO1.dispose();
            this._vehicleInfoButtonDataVO1 = null;
         }
         super.onDispose();
      }
      
      public function getVehicleInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.getVehicleInfo,"getVehicleInfo" + Errors.CANT_NULL);
         this.getVehicleInfo();
      }
      
      public function onCancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
      
      public function addToCompareS() : void
      {
         App.utils.asserter.assertNotNull(this.addToCompare,"addToCompare" + Errors.CANT_NULL);
         this.addToCompare();
      }
      
      public function changeNationS() : void
      {
         App.utils.asserter.assertNotNull(this.changeNation,"changeNation" + Errors.CANT_NULL);
         this.changeNation();
      }
      
      public final function as_setVehicleInfo(param1:Object) : void
      {
         var _loc2_:VehicleInfoDataVO = this._vehicleInfoDataVO;
         this._vehicleInfoDataVO = new VehicleInfoDataVO(param1);
         this.setVehicleInfo(this._vehicleInfoDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCompareButtonData(param1:Object) : void
      {
         var _loc2_:VehicleInfoButtonDataVO = this._vehicleInfoButtonDataVO;
         this._vehicleInfoButtonDataVO = new VehicleInfoButtonDataVO(param1);
         this.setCompareButtonData(this._vehicleInfoButtonDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setChangeNationButtonData(param1:Object) : void
      {
         var _loc2_:VehicleInfoButtonDataVO = this._vehicleInfoButtonDataVO1;
         this._vehicleInfoButtonDataVO1 = new VehicleInfoButtonDataVO(param1);
         this.setChangeNationButtonData(this._vehicleInfoButtonDataVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setVehicleInfo(param1:VehicleInfoDataVO) : void
      {
         var _loc2_:String = "as_setVehicleInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCompareButtonData(param1:VehicleInfoButtonDataVO) : void
      {
         var _loc2_:String = "as_setCompareButtonData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setChangeNationButtonData(param1:VehicleInfoButtonDataVO) : void
      {
         var _loc2_:String = "as_setChangeNationButtonData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
