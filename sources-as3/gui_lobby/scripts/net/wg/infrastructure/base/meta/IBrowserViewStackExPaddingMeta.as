package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBrowserViewStackExPaddingMeta extends IEventDispatcher
   {
       
      
      function setViewSizeS(param1:Number, param2:Number) : void;
      
      function as_setAllowWaiting(param1:Boolean, param2:Boolean) : void;
      
      function as_setWaitingMessage(param1:String) : void;
      
      function as_createBrowserView() : void;
   }
}
