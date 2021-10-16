package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IUILoggerManagerMeta extends IEventDispatcher
   {
       
      
      function onLogS(param1:String, param2:String, param3:String, param4:int, param5:Object) : void;
   }
}
