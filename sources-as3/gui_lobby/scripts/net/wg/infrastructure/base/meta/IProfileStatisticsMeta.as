package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileStatisticsMeta extends IEventDispatcher
   {
       
      
      function getDataS(param1:Object) : void;
      
      function setSeasonS(param1:String) : void;
      
      function showPlayersStatsS() : void;
      
      function as_updatePlayerStatsBtn(param1:Boolean) : void;
   }
}
