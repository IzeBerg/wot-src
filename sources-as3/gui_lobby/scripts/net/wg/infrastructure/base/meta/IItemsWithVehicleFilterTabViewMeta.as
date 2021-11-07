package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IItemsWithVehicleFilterTabViewMeta extends IEventDispatcher
   {
       
      
      function resetVehicleFilterS() : void;
      
      function as_initVehicleFilter(param1:Object) : void;
      
      function as_updateVehicleFilterButton(param1:Object) : void;
   }
}
