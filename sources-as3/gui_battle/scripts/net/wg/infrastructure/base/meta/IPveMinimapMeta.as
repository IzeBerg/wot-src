package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPveMinimapMeta extends IEventDispatcher
   {
       
      
      function as_setShorcutLabel(param1:String) : void;
      
      function as_showGrid(param1:Boolean) : void;
      
      function as_setGrid(param1:int, param2:int) : void;
   }
}
