package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.VehicleInfoViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyaleVehicleInfoMeta extends AbstractView
   {
       
      
      public var onClose:Function;
      
      private var _vehicleInfoViewVO:VehicleInfoViewVO;
      
      public function BattleRoyaleVehicleInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleInfoViewVO)
         {
            this._vehicleInfoViewVO.dispose();
            this._vehicleInfoViewVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VehicleInfoViewVO = this._vehicleInfoViewVO;
         this._vehicleInfoViewVO = new VehicleInfoViewVO(param1);
         this.setData(this._vehicleInfoViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VehicleInfoViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
