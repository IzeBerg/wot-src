package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattleStatisticDataControllerMeta extends IEventDispatcher
   {
       
      
      function as_updateEpicPlayerStats(param1:Object) : void;
      
      function as_setEpicVehiclesStats(param1:Object) : void;
      
      function as_updateEpicVehiclesStats(param1:Object) : void;
   }
}
