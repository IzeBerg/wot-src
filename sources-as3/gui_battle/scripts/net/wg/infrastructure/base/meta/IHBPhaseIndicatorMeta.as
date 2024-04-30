package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHBPhaseIndicatorMeta extends IEventDispatcher
   {
       
      
      function as_setData(param1:int, param2:int) : void;
      
      function as_setVisible(param1:Boolean) : void;
   }
}
