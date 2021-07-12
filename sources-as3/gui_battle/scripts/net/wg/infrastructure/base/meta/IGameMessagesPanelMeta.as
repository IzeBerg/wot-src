package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGameMessagesPanelMeta extends IEventDispatcher
   {
       
      
      function onMessageStartedS(param1:String, param2:int) : void;
      
      function onMessageEndedS(param1:String, param2:int) : void;
      
      function onMessageHidingS(param1:String, param2:int) : void;
      
      function as_addMessage(param1:Object) : void;
      
      function as_clearMessages() : void;
   }
}
