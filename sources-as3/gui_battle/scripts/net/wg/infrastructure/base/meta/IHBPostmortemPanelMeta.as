package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHBPostmortemPanelMeta extends IEventDispatcher
   {
       
      
      function as_setHintTitle(param1:String) : void;
      
      function as_setHintDescr(param1:String) : void;
      
      function as_setTimer(param1:int) : void;
      
      function as_setCanExit(param1:Boolean) : void;
      
      function as_setIsLocked(param1:Boolean) : void;
   }
}
