package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPvePrimaryObjectiveMeta extends IEventDispatcher
   {
       
      
      function as_showMessage(param1:String) : void;
      
      function as_hideMessage() : void;
      
      function as_playFx(param1:Boolean, param2:Boolean) : void;
      
      function as_setHintState(param1:Boolean) : void;
      
      function as_setTimerBackground(param1:Boolean) : void;
      
      function as_setTimerState(param1:int) : void;
      
      function as_updateTime(param1:String) : void;
      
      function as_updateProgressBar(param1:int, param2:Boolean) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_showResult(param1:Boolean, param2:String, param3:String) : void;
      
      function as_hideResult() : void;
   }
}
