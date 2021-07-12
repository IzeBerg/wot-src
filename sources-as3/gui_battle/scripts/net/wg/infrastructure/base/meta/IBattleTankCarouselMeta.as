package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTankCarouselMeta extends IEventDispatcher
   {
       
      
      function setFilterS(param1:int) : void;
      
      function updateHotFiltersS() : void;
      
      function as_setCarouselFilter(param1:Object) : void;
      
      function as_initCarouselFilter(param1:Object) : void;
   }
}
