package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProgressiveRewardWidgetMeta extends IEventDispatcher
   {
       
      
      function onWidgetClickS() : void;
      
      function onOpenBtnClickS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
