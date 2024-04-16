package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.window.BaseExchangeWindow;
   import net.wg.gui.lobby.window.ExchangeXPWindowVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ExchangeXpWindowMeta extends BaseExchangeWindow
   {
       
      
      public var getSubmitButtonEnableState:Function;
      
      private var _exchangeXPWindowVO:ExchangeXPWindowVO;
      
      public function ExchangeXpWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._exchangeXPWindowVO)
         {
            this._exchangeXPWindowVO.dispose();
            this._exchangeXPWindowVO = null;
         }
         super.onDispose();
      }
      
      public function getSubmitButtonEnableStateS(param1:int) : Boolean
      {
         App.utils.asserter.assertNotNull(this.getSubmitButtonEnableState,"getSubmitButtonEnableState" + Errors.CANT_NULL);
         return this.getSubmitButtonEnableState(param1);
      }
      
      public final function as_vehiclesDataChanged(param1:Object) : void
      {
         var _loc2_:ExchangeXPWindowVO = this._exchangeXPWindowVO;
         this._exchangeXPWindowVO = new ExchangeXPWindowVO(param1);
         this.vehiclesDataChanged(this._exchangeXPWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function vehiclesDataChanged(param1:ExchangeXPWindowVO) : void
      {
         var _loc2_:String = "as_vehiclesDataChanged" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
