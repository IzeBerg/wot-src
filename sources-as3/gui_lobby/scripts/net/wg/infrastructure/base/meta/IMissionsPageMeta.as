package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsPageMeta extends IEventDispatcher
   {
       
      
      function resetFiltersS() : void;
      
      function onTabSelectedS(param1:String, param2:String) : void;
      
      function onCloseS() : void;
      
      function as_setTabsDataProvider(param1:Array) : void;
      
      function as_showFilter(param1:Boolean, param2:Boolean) : void;
      
      function as_showFilterCounter(param1:String, param2:Boolean) : void;
      
      function as_blinkFilterCounter() : void;
      
      function as_setTabsCounterData(param1:Array) : void;
      
      function as_showBattleMattersAnimation(param1:String, param2:Object) : void;
   }
}
