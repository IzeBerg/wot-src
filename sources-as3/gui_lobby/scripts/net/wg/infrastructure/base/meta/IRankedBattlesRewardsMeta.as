package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesRewardsMeta extends IEventDispatcher
   {
       
      
      function onTabChangedS(param1:String) : void;
      
      function as_setTabsData(param1:Array) : void;
      
      function as_setCounters(param1:Array) : void;
   }
}
