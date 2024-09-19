package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventOvertimeMeta extends IEventDispatcher
   {
       
      
      function as_updateOvertimeTimer(param1:int) : void;
      
      function as_getOvertimeInfo(param1:Boolean, param2:Boolean) : void;
   }
}
