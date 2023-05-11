package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISwitchPeripheryWindowMeta extends IEventDispatcher
   {
       
      
      function requestForChangeS(param1:int) : void;
      
      function onDropDownOpenedS(param1:Boolean) : void;
      
      function as_setServerParams(param1:String, param2:Boolean) : void;
      
      function as_setSelectedIndex(param1:int) : void;
      
      function as_getServersDP() : Object;
   }
}
