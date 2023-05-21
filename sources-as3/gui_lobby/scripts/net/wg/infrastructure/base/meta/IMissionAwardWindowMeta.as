package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionAwardWindowMeta extends IEventDispatcher
   {
       
      
      function onCurrentQuestClickS() : void;
      
      function onNextQuestClickS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
