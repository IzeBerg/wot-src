package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISystemMessageDialogMeta extends IEventDispatcher
   {
       
      
      function as_setInitData(param1:Object) : void;
      
      function as_setMessageData(param1:Object) : void;
   }
}
