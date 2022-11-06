package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageVehicleSelectPopoverMeta extends IEventDispatcher
   {
       
      
      function setVehicleSelectedS(param1:int, param2:Boolean = false) : void;
      
      function applyFiltersS(param1:int, param2:String, param3:int, param4:Boolean) : void;
      
      function changeSearchNameVehicleS(param1:String) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_getTableDP() : Object;
      
      function as_updateTableSortField(param1:String, param2:String) : void;
      
      function as_updateSearch(param1:String, param2:String, param3:String, param4:int) : void;
      
      function as_showDummy(param1:Boolean) : void;
   }
}
