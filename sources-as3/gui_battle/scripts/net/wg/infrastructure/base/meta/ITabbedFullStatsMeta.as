package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITabbedFullStatsMeta extends IEventDispatcher
   {
       
      
      function onSelectQuestS(param1:uint) : void;
      
      function as_setActiveTab(param1:Number) : void;
      
      function as_questProgressPerform(param1:Object) : void;
      
      function as_resetActiveTab() : void;
      
      function as_updateProgressTracking(param1:Object) : void;
      
      function as_updateTabs(param1:Array) : void;
   }
}
