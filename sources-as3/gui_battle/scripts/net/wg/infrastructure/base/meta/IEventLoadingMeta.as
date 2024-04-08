package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventLoadingMeta extends IEventDispatcher
   {
       
      
      function as_setData(param1:Object) : void;
      
      function as_updateProgress(param1:Number) : void;
   }
}
