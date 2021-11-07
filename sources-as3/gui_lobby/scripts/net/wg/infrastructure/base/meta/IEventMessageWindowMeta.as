package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventMessageWindowMeta extends IEventDispatcher
   {
       
      
      function onResultS(param1:Boolean) : void;
      
      function as_setMessageData(param1:Object) : void;
      
      function as_blurOtherWindows(param1:String) : void;
   }
}
