package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClassicFullStatsMeta extends IEventDispatcher
   {
       
      
      function onSelectQuestS(param1:uint) : void;
      
      function as_questProgressPerform(param1:Object) : void;
      
      function as_updateProgressTracking(param1:Object) : void;
   }
}
