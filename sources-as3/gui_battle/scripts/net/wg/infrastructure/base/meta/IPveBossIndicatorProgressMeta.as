package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPveBossIndicatorProgressMeta extends IEventDispatcher
   {
       
      
      function as_setValue(param1:int) : void;
      
      function as_setIndicatorEnabled(param1:Boolean) : void;
   }
}
