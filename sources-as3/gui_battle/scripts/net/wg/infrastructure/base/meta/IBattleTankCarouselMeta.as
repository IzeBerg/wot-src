package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTankCarouselMeta extends IEventDispatcher
   {
       
      
      function setFilterS(param1:int) : void;
      
      function as_useExtendedCarousel(param1:Boolean) : void;
      
      function as_scrollToSlot(param1:int) : void;
   }
}
