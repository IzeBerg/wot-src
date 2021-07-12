package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILoginQueueWindowMeta extends IEventDispatcher
   {
       
      
      function onCancelClickS() : void;
      
      function onAutoLoginClickS() : void;
      
      function as_setTitle(param1:String) : void;
      
      function as_setMessage(param1:String) : void;
      
      function as_setCancelLabel(param1:String) : void;
      
      function as_showAutoLoginBtn(param1:Boolean) : void;
   }
}
