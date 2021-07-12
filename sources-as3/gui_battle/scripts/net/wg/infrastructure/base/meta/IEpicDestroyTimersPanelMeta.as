package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicDestroyTimersPanelMeta extends IEventDispatcher
   {
       
      
      function as_showAdditionalTimer(param1:int, param2:int) : void;
      
      function as_hideAdditionalTimer(param1:int) : void;
      
      function as_setAdditionalTimerState(param1:int, param2:int) : void;
      
      function as_setAdditionalTimerTimeString(param1:int, param2:String) : void;
      
      function as_setAdditionalTimerProgressValue(param1:int, param2:Number) : void;
   }
}
