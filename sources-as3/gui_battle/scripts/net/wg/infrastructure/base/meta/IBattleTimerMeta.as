package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTimerMeta extends IEventDispatcher
   {
       
      
      function as_setTotalTime(param1:String, param2:String) : void;
      
      function as_setColor(param1:Boolean) : void;
      
      function as_showBattleTimer(param1:Boolean) : void;
   }
}
