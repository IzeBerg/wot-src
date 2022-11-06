package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITimersPanelMeta extends IEventDispatcher
   {
       
      
      function as_setInitData(param1:Object) : void;
      
      function as_show(param1:String, param2:String, param3:Boolean) : void;
      
      function as_hide(param1:String) : void;
      
      function as_setVerticalOffset(param1:int) : void;
      
      function as_setTimeInSeconds(param1:String, param2:int, param3:Number) : void;
      
      function as_setTimeSnapshot(param1:String, param2:int, param3:int) : void;
      
      function as_setSpeed(param1:Number) : void;
      
      function as_turnOnStackView(param1:Boolean) : void;
      
      function as_setTimerText(param1:String, param2:String, param3:String) : void;
      
      function as_showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean) : void;
      
      function as_hideSecondaryTimer(param1:String) : void;
      
      function as_setSecondaryTimeSnapshot(param1:String, param2:int, param3:Number) : void;
      
      function as_setSecondaryTimerText(param1:String, param2:String, param3:String) : void;
   }
}
