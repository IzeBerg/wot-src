package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCQueueWindowMeta extends IEventDispatcher
   {
       
      
      function cancelS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_showCancelButton(param1:Boolean, param2:String, param3:String) : void;
      
      function as_setStatusText(param1:String) : void;
   }
}
