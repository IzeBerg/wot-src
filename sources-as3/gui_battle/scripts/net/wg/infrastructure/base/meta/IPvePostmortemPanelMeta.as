package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPvePostmortemPanelMeta extends IEventDispatcher
   {
       
      
      function as_setHintTitle(param1:String) : void;
      
      function as_setHintDescr(param1:String) : void;
      
      function as_setTimer(param1:int, param2:Number) : void;
      
      function as_setCanExit(param1:Boolean) : void;
      
      function as_showLockedLives() : void;
      
      function as_hidePanel() : void;
   }
}
