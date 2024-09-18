package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWTEventParamsWidgetMeta extends IEventDispatcher
   {
       
      
      function updateWidgetLayoutS(param1:int) : void;
      
      function as_showWidget() : void;
      
      function as_hideWidget() : void;
   }
}
