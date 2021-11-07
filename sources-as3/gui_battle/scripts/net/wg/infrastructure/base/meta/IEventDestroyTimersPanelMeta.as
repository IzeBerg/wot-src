package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventDestroyTimersPanelMeta extends IEventDispatcher
   {
       
      
      function setComponentsOverlayS(param1:Boolean, param2:Boolean) : void;
      
      function as_setWarningText(param1:String) : void;
      
      function as_setFillingInProgress(param1:int, param2:int, param3:Boolean, param4:Boolean) : void;
      
      function as_setGotoPointTimer(param1:int, param2:int, param3:String, param4:Boolean) : void;
      
      function as_setWaitForAllies(param1:Boolean) : void;
      
      function as_hideAllNotifications() : void;
   }
}
