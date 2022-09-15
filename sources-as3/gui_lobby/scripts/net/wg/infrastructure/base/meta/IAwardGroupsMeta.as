package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAwardGroupsMeta extends IEventDispatcher
   {
       
      
      function showGroupS(param1:int) : void;
      
      function as_setData(param1:Array) : void;
      
      function as_setTooltips(param1:Array) : void;
      
      function as_setSelected(param1:int, param2:Boolean) : void;
      
      function as_setEnabled(param1:int, param2:Boolean) : void;
   }
}
