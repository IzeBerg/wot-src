package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageCategoryStorageViewMeta extends IEventDispatcher
   {
       
      
      function setActiveStateS(param1:Boolean) : void;
      
      function onOpenTabS(param1:String) : void;
      
      function as_setTabsData(param1:Array) : void;
      
      function as_setTabCounter(param1:int, param2:int) : void;
   }
}
