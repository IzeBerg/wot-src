package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyaleWinnerCongratsMeta extends IEventDispatcher
   {
       
      
      function onBecomeVisibleS() : void;
      
      function as_setStpCoins(param1:int, param2:int, param3:int) : void;
   }
}
