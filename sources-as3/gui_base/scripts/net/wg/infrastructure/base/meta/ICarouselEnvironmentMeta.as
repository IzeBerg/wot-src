package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICarouselEnvironmentMeta extends IEventDispatcher
   {
       
      
      function selectVehicleS(param1:int) : void;
      
      function resetFiltersS() : void;
      
      function as_getDataProvider() : Object;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setEnabled(param1:Boolean) : void;
      
      function as_showCounter(param1:String, param2:Boolean) : void;
      
      function as_hideCounter() : void;
      
      function as_blinkCounter() : void;
   }
}
