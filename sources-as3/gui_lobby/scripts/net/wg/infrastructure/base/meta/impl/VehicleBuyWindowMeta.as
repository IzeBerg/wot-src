package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyVo;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleBuyWindowMeta extends AbstractWindowView
   {
       
      
      public var submit:Function;
      
      public var stateChange:Function;
      
      public var selectTab:Function;
      
      public var onTradeInClearVehicle:Function;
      
      private var _vehicleBuyVo:VehicleBuyVo;
      
      private var _vehicleBuyTradeOffVo:VehicleBuyTradeOffVo;
      
      public function VehicleBuyWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleBuyVo)
         {
            this._vehicleBuyVo.dispose();
            this._vehicleBuyVo = null;
         }
         if(this._vehicleBuyTradeOffVo)
         {
            this._vehicleBuyTradeOffVo.dispose();
            this._vehicleBuyTradeOffVo = null;
         }
         super.onDispose();
      }
      
      public function submitS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1);
      }
      
      public function stateChangeS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.stateChange,"stateChange" + Errors.CANT_NULL);
         this.stateChange(param1);
      }
      
      public function selectTabS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.selectTab,"selectTab" + Errors.CANT_NULL);
         this.selectTab(param1);
      }
      
      public function onTradeInClearVehicleS() : void
      {
         App.utils.asserter.assertNotNull(this.onTradeInClearVehicle,"onTradeInClearVehicle" + Errors.CANT_NULL);
         this.onTradeInClearVehicle();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:VehicleBuyVo = this._vehicleBuyVo;
         this._vehicleBuyVo = new VehicleBuyVo(param1);
         this.setInitData(this._vehicleBuyVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateTradeOffVehicle(param1:Object) : void
      {
         var _loc2_:VehicleBuyTradeOffVo = this._vehicleBuyTradeOffVo;
         this._vehicleBuyTradeOffVo = new VehicleBuyTradeOffVo(param1);
         this.updateTradeOffVehicle(this._vehicleBuyTradeOffVo);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:VehicleBuyVo) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void
      {
         var _loc2_:String = "as_updateTradeOffVehicle" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
