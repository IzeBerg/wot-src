package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPrimeTimeMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function applyS() : void;
      
      function selectServerS(param1:int) : void;
      
      function as_getServersDP() : Object;
      
      function as_setData(param1:Object) : void;
   }
}
