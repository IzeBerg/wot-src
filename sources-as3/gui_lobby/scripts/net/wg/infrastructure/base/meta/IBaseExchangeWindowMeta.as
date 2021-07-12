package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseExchangeWindowMeta extends IEventDispatcher
   {
       
      
      function exchangeS(param1:Object) : void;
      
      function as_setPrimaryCurrency(param1:Number) : void;
      
      function as_exchangeRate(param1:Object) : void;
   }
}
