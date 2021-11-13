package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleListPopupMeta extends IEventDispatcher
   {
       
      
      function onSelectVehiclesS(param1:uint) : void;
      
      function applyFiltersS(param1:int, param2:String) : void;
      
      function as_setListData(param1:Array, param2:Array) : void;
      
      function as_setInfoText(param1:String) : void;
      
      function as_setFiltersData(param1:Object) : void;
   }
}
