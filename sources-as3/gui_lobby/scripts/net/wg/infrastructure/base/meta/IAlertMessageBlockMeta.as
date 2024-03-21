package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAlertMessageBlockMeta extends IEventDispatcher
   {
       
      
      function onBlockClickS() : void;
      
      function onButtonClickS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
