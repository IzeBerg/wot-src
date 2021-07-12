package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.ammunitionPanel.data.VehicleStatusVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AmmunitionPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var showRepairDialog:Function;
      
      public var showCustomization:Function;
      
      public var toRentContinue:Function;
      
      public var showChangeNation:Function;
      
      private var _vehicleStatusVO:VehicleStatusVO;
      
      public function AmmunitionPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleStatusVO)
         {
            this._vehicleStatusVO.dispose();
            this._vehicleStatusVO = null;
         }
         super.onDispose();
      }
      
      public function showRepairDialogS() : void
      {
         App.utils.asserter.assertNotNull(this.showRepairDialog,"showRepairDialog" + Errors.CANT_NULL);
         this.showRepairDialog();
      }
      
      public function showCustomizationS() : void
      {
         App.utils.asserter.assertNotNull(this.showCustomization,"showCustomization" + Errors.CANT_NULL);
         this.showCustomization();
      }
      
      public function toRentContinueS() : void
      {
         App.utils.asserter.assertNotNull(this.toRentContinue,"toRentContinue" + Errors.CANT_NULL);
         this.toRentContinue();
      }
      
      public function showChangeNationS() : void
      {
         App.utils.asserter.assertNotNull(this.showChangeNation,"showChangeNation" + Errors.CANT_NULL);
         this.showChangeNation();
      }
      
      public final function as_updateVehicleStatus(param1:Object) : void
      {
         var _loc2_:VehicleStatusVO = this._vehicleStatusVO;
         this._vehicleStatusVO = new VehicleStatusVO(param1);
         this.updateVehicleStatus(this._vehicleStatusVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function updateVehicleStatus(param1:VehicleStatusVO) : void
      {
         var _loc2_:String = "as_updateVehicleStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
