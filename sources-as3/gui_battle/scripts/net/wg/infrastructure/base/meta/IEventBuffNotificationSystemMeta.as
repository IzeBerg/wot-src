package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBuffNotificationSystemMeta extends IEventDispatcher
   {
       
      
      function as_showBuffNotification(param1:Object) : void;
      
      function as_hideBuffNotification() : void;
   }
}
