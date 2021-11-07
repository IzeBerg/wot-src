package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHWIngameHelpWindowMeta extends IEventDispatcher
   {
       
      
      function clickSettingWindowS() : void;
      
      function as_setData(param1:Array) : void;
      
      function as_setPaginatorData(param1:Array) : void;
   }
}
