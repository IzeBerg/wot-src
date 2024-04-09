package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPveSecondaryObjectivesMeta extends IEventDispatcher
   {
       
      
      function as_addObject(param1:Object) : void;
      
      function as_removeObject(param1:String, param2:String) : void;
      
      function as_setProgressBarValue(param1:String, param2:int) : void;
      
      function as_updateTime(param1:String, param2:String, param3:Boolean) : void;
      
      function as_setAlarm(param1:String, param2:Boolean) : void;
      
      function as_setTitle(param1:String, param2:String) : void;
      
      function as_clear() : void;
   }
}
