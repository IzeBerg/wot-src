package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.window.BaseExchangeWindowRateVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseExchangeWindowMeta extends AbstractWindowView
   {
       
      
      public var exchange:Function;
      
      private var _baseExchangeWindowRateVO:BaseExchangeWindowRateVO;
      
      public function BaseExchangeWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._baseExchangeWindowRateVO)
         {
            this._baseExchangeWindowRateVO.dispose();
            this._baseExchangeWindowRateVO = null;
         }
         super.onDispose();
      }
      
      public function exchangeS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.exchange,"exchange" + Errors.CANT_NULL);
         this.exchange(param1);
      }
      
      public final function as_exchangeRate(param1:Object) : void
      {
         var _loc2_:BaseExchangeWindowRateVO = this._baseExchangeWindowRateVO;
         this._baseExchangeWindowRateVO = new BaseExchangeWindowRateVO(param1);
         this.exchangeRate(this._baseExchangeWindowRateVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function exchangeRate(param1:BaseExchangeWindowRateVO) : void
      {
         var _loc2_:String = "as_exchangeRate" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
