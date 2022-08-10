package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRosterSlotSettingsWindowMeta extends IEventDispatcher
   {
       
      
      function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int, param5:Boolean) : void;
      
      function requestVehicleFiltersS() : void;
      
      function submitButtonHandlerS(param1:Object) : void;
      
      function cancelButtonHandlerS() : void;
      
      function as_setVehicleSelection(param1:Object) : void;
      
      function as_setRangeSelection(param1:Object) : void;
      
      function as_resetSelection() : void;
      
      function as_selectTab(param1:int) : void;
      
      function as_setListData(param1:Array) : void;
      
      function as_setStaticData(param1:Object) : void;
      
      function as_setRosterLimits(param1:Object) : void;
      
      function as_updateVehicleFilters(param1:Object) : void;
   }
}
