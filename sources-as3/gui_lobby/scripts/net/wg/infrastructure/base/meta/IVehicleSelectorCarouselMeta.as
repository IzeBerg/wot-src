package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleSelectorCarouselMeta extends IEventDispatcher
   {
       
      
      function setFilterS(param1:int, param2:Boolean) : void;
      
      function as_initCarouselFilter(param1:Object) : void;
   }
}
