package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITabbedFullStatsMeta extends IEventDispatcher
   {
       
      
      function as_setActiveTab(param1:Number) : void;
      
      function as_resetActiveTab() : void;
      
      function as_updateTabs(param1:Array) : void;
   }
}
