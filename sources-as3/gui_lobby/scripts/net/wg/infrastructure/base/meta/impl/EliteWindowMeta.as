package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EliteWindowMeta extends AbstractWindowView
   {
       
      
      private var _vehicleVO:VehicleVO;
      
      public function EliteWindowMeta()
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
         super.onDispose();
      }
      
      public final function as_setVehicle(param1:Object) : void
      {
         var _loc2_:VehicleVO = this._vehicleVO;
         this._vehicleVO = new VehicleVO(param1);
         this.setVehicle(this._vehicleVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setVehicle(param1:VehicleVO) : void
      {
         var _loc2_:String = "as_setVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
