package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBoardsResultFilterVehiclesPopoverViewMeta extends IEventDispatcher
   {
       
      
      function setVehicleSelectedS(param1:int) : void;
      
      function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean, param5:Boolean) : void;
      
      function resetFiltersS() : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_getTableDP() : Object;
      
      function as_updateTableSortField(param1:String, param2:String) : void;
   }
}
