package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleSelectorPopupMeta extends IEventDispatcher
   {
       
      
      function onFiltersUpdateS(param1:int, param2:String, param3:Boolean, param4:int, param5:Boolean) : void;
      
      function onSelectVehiclesS(param1:Array) : void;
      
      function as_setFiltersData(param1:Object) : void;
      
      function as_setListData(param1:Array, param2:Array) : void;
      
      function as_setListRenderer(param1:String) : void;
      
      function as_setListMode(param1:Boolean) : void;
      
      function as_setTexts(param1:String, param2:String, param3:String, param4:String) : void;
   }
}
