package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageCategoryPersonalReservesViewMeta extends IEventDispatcher
   {
       
      
      function navigateToStoreS() : void;
      
      function activateReserveS(param1:Number) : void;
      
      function resetFilterS() : void;
      
      function onFiltersChangeS(param1:int) : void;
      
      function onInfoClickedS() : void;
      
      function as_init(param1:Object) : void;
      
      function as_initFilter(param1:Object) : void;
      
      function as_resetFilter(param1:int) : void;
      
      function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void;
   }
}
