package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlePageMeta extends IEventDispatcher
   {
       
      
      function as_setSelectReservesAvailable(param1:Boolean) : void;
      
      function as_setVehPostProgressionEnabled(param1:Boolean) : void;
   }
}
