package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsVehicleSelectorMeta extends IEventDispatcher
   {
       
      
      function as_setInitData(param1:Object) : void;
      
      function as_showSelectedVehicle(param1:Object) : void;
      
      function as_hideSelectedVehicle() : void;
      
      function as_close() : void;
   }
}
