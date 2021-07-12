package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IUseAwardSheetWindowMeta extends IEventDispatcher
   {
       
      
      function acceptS() : void;
      
      function cancelS() : void;
      
      function as_setSettings(param1:Object) : void;
      
      function as_setData(param1:Object) : void;
   }
}
