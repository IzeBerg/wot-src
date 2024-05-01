package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITradeInPopupMeta extends IEventDispatcher
   {
       
      
      function onSelectVehicleS(param1:Number) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_getDP() : Object;
   }
}
