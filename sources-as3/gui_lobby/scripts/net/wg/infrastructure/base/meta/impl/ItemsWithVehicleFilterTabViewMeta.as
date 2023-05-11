package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.storage.ItemsWithTypeFilterTabView;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ItemsWithVehicleFilterTabViewMeta extends ItemsWithTypeFilterTabView
   {
       
      
      public var resetVehicleFilter:Function;
      
      private var _vehicleVO:VehicleVO;
      
      private var _vehicleVO1:VehicleVO;
      
      public function ItemsWithVehicleFilterTabViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleVO)
         {
            this._vehicleVO.dispose();
            this._vehicleVO = null;
         }
         if(this._vehicleVO1)
         {
            this._vehicleVO1.dispose();
            this._vehicleVO1 = null;
         }
         super.onDispose();
      }
      
      public function resetVehicleFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.resetVehicleFilter,"resetVehicleFilter" + Errors.CANT_NULL);
         this.resetVehicleFilter();
      }
      
      public final function as_initVehicleFilter(param1:Object) : void
      {
         var _loc2_:VehicleVO = this._vehicleVO;
         this._vehicleVO = Boolean(param1) ? new VehicleVO(param1) : null;
         this.initVehicleFilter(this._vehicleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateVehicleFilterButton(param1:Object) : void
      {
         var _loc2_:VehicleVO = this._vehicleVO1;
         this._vehicleVO1 = Boolean(param1) ? new VehicleVO(param1) : null;
         this.updateVehicleFilterButton(this._vehicleVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function initVehicleFilter(param1:VehicleVO) : void
      {
         var _loc2_:String = "as_initVehicleFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateVehicleFilterButton(param1:VehicleVO) : void
      {
         var _loc2_:String = "as_updateVehicleFilterButton" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
