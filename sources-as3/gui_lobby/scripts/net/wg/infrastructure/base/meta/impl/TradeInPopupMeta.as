package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.popover.TradeInVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TradeInPopupMeta extends SmartPopOverView
   {
       
      
      public var onSelectVehicle:Function;
      
      private var _tradeInVO:TradeInVO;
      
      public function TradeInPopupMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tradeInVO)
         {
            this._tradeInVO.dispose();
            this._tradeInVO = null;
         }
         super.onDispose();
      }
      
      public function onSelectVehicleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectVehicle,"onSelectVehicle" + Errors.CANT_NULL);
         this.onSelectVehicle(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:TradeInVO = this._tradeInVO;
         this._tradeInVO = new TradeInVO(param1);
         this.setInitData(this._tradeInVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:TradeInVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
