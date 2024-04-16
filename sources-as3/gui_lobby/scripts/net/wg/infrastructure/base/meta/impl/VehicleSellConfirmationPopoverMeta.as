package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.shop.data.VehicleSellConfirmationPopoverVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleSellConfirmationPopoverMeta extends SmartPopOverView
   {
       
      
      public var confirmTradeIn:Function;
      
      private var _vehicleSellConfirmationPopoverVO:VehicleSellConfirmationPopoverVO;
      
      public function VehicleSellConfirmationPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleSellConfirmationPopoverVO)
         {
            this._vehicleSellConfirmationPopoverVO.dispose();
            this._vehicleSellConfirmationPopoverVO = null;
         }
         super.onDispose();
      }
      
      public function confirmTradeInS() : void
      {
         App.utils.asserter.assertNotNull(this.confirmTradeIn,"confirmTradeIn" + Errors.CANT_NULL);
         this.confirmTradeIn();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:VehicleSellConfirmationPopoverVO = this._vehicleSellConfirmationPopoverVO;
         this._vehicleSellConfirmationPopoverVO = new VehicleSellConfirmationPopoverVO(param1);
         this.setInitData(this._vehicleSellConfirmationPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:VehicleSellConfirmationPopoverVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
