package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IComp7BattleTankCarouselMeta extends IEventDispatcher
   {
       
      
      function setFilterS(param1:int) : void;
      
      function onViewIsHiddenS() : void;
      
      function as_rowCount(param1:int) : void;
      
      function as_hide(param1:Boolean) : void;
   }
}
