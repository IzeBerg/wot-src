package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleBuyWindowMeta extends IEventDispatcher
   {
       
      
      function submitS(param1:Object) : void;
      
      function stateChangeS(param1:Object) : void;
      
      function selectTabS(param1:Number) : void;
      
      function onTradeInClearVehicleS() : void;
      
      function as_setGold(param1:Number) : void;
      
      function as_setCredits(param1:Number) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_updateTradeOffVehicle(param1:Object) : void;
      
      function as_setTradeInWarningMessagege(param1:String) : void;
      
      function as_setState(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void;
   }
}
