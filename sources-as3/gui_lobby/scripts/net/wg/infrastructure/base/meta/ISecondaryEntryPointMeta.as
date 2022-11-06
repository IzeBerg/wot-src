package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISecondaryEntryPointMeta extends IEventDispatcher
   {
       
      
      function onClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setCount(param1:int) : void;
   }
}
