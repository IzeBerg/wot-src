package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IComp7PlayersPanelMeta extends IEventDispatcher
   {
       
      
      function onVoiceChatControlClickS() : void;
      
      function as_setVoiceChatData(param1:Object) : void;
      
      function as_setVoiceChatControlVisible(param1:Boolean) : void;
      
      function as_setVoiceChatControlSelected(param1:Boolean) : void;
   }
}
