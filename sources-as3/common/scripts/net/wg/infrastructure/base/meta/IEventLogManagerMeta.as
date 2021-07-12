package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventLogManagerMeta extends IEventDispatcher
   {
       
      
      function logEventS(param1:int, param2:String, param3:int, param4:int) : void;
      
      function as_setSystemEnabled(param1:Boolean) : void;
   }
}
