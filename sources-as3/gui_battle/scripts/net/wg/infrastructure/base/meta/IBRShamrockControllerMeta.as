package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBRShamrockControllerMeta extends IEventDispatcher
   {
       
      
      function as_addPoints(param1:int, param2:int, param3:Boolean) : void;
      
      function as_setCounter(param1:int) : void;
   }
}
