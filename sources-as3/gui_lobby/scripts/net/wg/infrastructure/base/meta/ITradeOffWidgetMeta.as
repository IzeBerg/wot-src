package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITradeOffWidgetMeta extends IEventDispatcher
   {
       
      
      function onClickS() : void;
      
      function onResetClickS() : void;
      
      function getTooltipS() : Object;
      
      function as_setData(param1:Object) : void;
   }
}
