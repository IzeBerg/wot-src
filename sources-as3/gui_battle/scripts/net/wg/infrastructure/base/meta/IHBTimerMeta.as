package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHBTimerMeta extends IEventDispatcher
   {
       
      
      function as_updateTime(param1:String) : void;
      
      function as_showMessage(param1:String) : void;
      
      function as_hideMessage() : void;
      
      function as_setTimerState(param1:int) : void;
      
      function as_setTimerBackground(param1:Boolean) : void;
      
      function as_setHintState(param1:Boolean) : void;
      
      function as_playFx(param1:Boolean, param2:Boolean) : void;
      
      function as_updateTitle(param1:String) : void;
      
      function as_updateObjective(param1:String) : void;
      
      function as_updateObjectiveBig(param1:String) : void;
      
      function as_updateProgressBar(param1:int, param2:Boolean) : void;
   }
}
