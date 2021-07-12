package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBoardsVehiclesOverlayMeta extends IEventDispatcher
   {
       
      
      function changeFilterS(param1:int) : void;
      
      function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean) : void;
      
      function as_setHeader(param1:Object) : void;
      
      function as_setFilters(param1:Object) : void;
      
      function as_setVehicles(param1:Object) : void;
   }
}
