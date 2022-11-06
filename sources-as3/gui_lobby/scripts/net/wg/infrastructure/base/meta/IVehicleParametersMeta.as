package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleParametersMeta extends IEventDispatcher
   {
       
      
      function onParamClickS(param1:String) : void;
      
      function onListScrollS() : void;
      
      function as_getDP() : Object;
      
      function as_setIsParamsAnimated(param1:Boolean) : void;
   }
}
