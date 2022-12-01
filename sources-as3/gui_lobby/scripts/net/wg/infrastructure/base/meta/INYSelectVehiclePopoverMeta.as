package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface INYSelectVehiclePopoverMeta extends IEventDispatcher
   {
       
      
      function onSelectVehicleS(param1:Number) : void;
      
      function applyFiltersS(param1:int, param2:String, param3:int) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_getDP() : Object;
   }
}
