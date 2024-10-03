package net.wg.white_tiger.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWTBattleHintMeta extends IEventDispatcher
   {
       
      
      function as_showHint(param1:Object) : void;
      
      function as_hideHint() : void;
   }
}
