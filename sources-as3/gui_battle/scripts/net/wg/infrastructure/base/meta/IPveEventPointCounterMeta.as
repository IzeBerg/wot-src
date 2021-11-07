package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPveEventPointCounterMeta extends IEventDispatcher
   {
       
      
      function as_updateCount(param1:int, param2:int) : void;
      
      function as_enableAnimation(param1:Boolean) : void;
   }
}
