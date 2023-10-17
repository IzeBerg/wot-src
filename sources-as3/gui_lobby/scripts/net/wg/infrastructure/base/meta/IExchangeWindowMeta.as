package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IExchangeWindowMeta extends IEventDispatcher
   {
       
      
      function as_setSecondaryCurrency(param1:Number) : void;
      
      function as_setWalletStatus(param1:Object) : void;
      
      function as_setDefaultPrimaryCurrencyValue(param1:Number) : void;
   }
}
