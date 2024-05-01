package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IItemsWithTypeFilterTabViewMeta extends IEventDispatcher
   {
       
      
      function sellItemS(param1:Number) : void;
      
      function resetFilterS() : void;
      
      function onFiltersChangeS(param1:int) : void;
      
      function navigateToStoreS() : void;
      
      function upgradeItemS(param1:int) : void;
      
      function as_initTypeFilter(param1:Object) : void;
      
      function as_resetFilter(param1:int) : void;
      
      function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void;
   }
}
