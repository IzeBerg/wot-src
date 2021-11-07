package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProgressTimersPanelMeta extends IEventDispatcher
   {
       
      
      function as_setLocalizedData(param1:int, param2:Object) : void;
      
      function as_show(param1:int, param2:int, param3:int) : void;
      
      function as_hide() : void;
      
      function as_setState(param1:int) : void;
      
      function as_setTimeString(param1:String) : void;
      
      function as_setProgressValue(param1:Number) : void;
   }
}
