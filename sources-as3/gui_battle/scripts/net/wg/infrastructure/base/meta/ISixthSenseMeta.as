package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISixthSenseMeta extends IEventDispatcher
   {
       
      
      function as_show(param1:Boolean) : void;
      
      function as_showIndicator() : void;
      
      function as_hide(param1:Boolean) : void;
      
      function as_setIsBig(param1:Boolean) : void;
      
      function as_setAlpha(param1:uint) : void;
   }
}
