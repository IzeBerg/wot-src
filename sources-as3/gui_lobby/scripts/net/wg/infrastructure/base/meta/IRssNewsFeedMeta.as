package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRssNewsFeedMeta extends IEventDispatcher
   {
       
      
      function openBrowserS(param1:String) : void;
      
      function as_updateFeed(param1:Array) : void;
   }
}
