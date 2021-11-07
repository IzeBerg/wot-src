package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStatusNotificationsPanelMeta extends IEventDispatcher
   {
       
      
      function as_setInitData(param1:Object) : void;
      
      function as_setData(param1:Array) : void;
      
      function as_setVerticalOffset(param1:int) : void;
      
      function as_setSpeed(param1:Number) : void;
   }
}
