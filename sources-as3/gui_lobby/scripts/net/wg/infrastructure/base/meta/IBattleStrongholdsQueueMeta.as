package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleStrongholdsQueueMeta extends IEventDispatcher
   {
       
      
      function exitClickS() : void;
      
      function onEscapeS() : void;
      
      function as_setTimer(param1:String, param2:String) : void;
      
      function as_setTypeInfo(param1:Object) : void;
      
      function as_setLeagues(param1:Object) : void;
      
      function as_showExit(param1:Boolean) : void;
      
      function as_showWaiting(param1:String) : void;
      
      function as_hideWaiting() : void;
   }
}
