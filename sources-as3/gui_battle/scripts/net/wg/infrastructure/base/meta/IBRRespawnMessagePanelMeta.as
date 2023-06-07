package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBRRespawnMessagePanelMeta extends IEventDispatcher
   {
       
      
      function as_addMessage(param1:Object) : void;
      
      function as_hideMessage() : void;
      
      function as_setMessageTime(param1:int) : void;
   }
}
