package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBattleTimerMeta extends IEventDispatcher
   {
       
      
      function as_setPlayerType(param1:Boolean) : void;
      
      function as_showAdditionalTime(param1:String) : void;
      
      function as_showMessage(param1:String, param2:Boolean) : void;
      
      function as_hideMessage() : void;
   }
}
