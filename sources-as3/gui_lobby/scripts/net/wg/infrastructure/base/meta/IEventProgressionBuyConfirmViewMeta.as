package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventProgressionBuyConfirmViewMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onBuyS() : void;
      
      function onBackS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
