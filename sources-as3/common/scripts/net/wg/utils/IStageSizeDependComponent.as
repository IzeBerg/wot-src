package net.wg.utils
{
   import flash.events.IEventDispatcher;
   
   public interface IStageSizeDependComponent extends IEventDispatcher
   {
       
      
      function setStateSizeBoundaries(param1:int, param2:int) : void;
   }
}
