package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICorrodingShotIndicatorMeta extends IEventDispatcher
   {
       
      
      function as_show() : void;
      
      function as_hide() : void;
      
      function as_updateLayout(param1:Number, param2:Number) : void;
   }
}
