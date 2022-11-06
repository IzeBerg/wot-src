package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IItemsWithTypeAndNationFilterTabViewMeta extends IEventDispatcher
   {
       
      
      function selectNationS(param1:int) : void;
      
      function as_initNationFilter(param1:Object) : void;
   }
}
