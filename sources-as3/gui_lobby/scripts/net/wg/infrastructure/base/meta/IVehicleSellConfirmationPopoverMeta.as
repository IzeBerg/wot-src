package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleSellConfirmationPopoverMeta extends IEventDispatcher
   {
       
      
      function confirmTradeInS() : void;
      
      function as_setInitData(param1:Object) : void;
   }
}
