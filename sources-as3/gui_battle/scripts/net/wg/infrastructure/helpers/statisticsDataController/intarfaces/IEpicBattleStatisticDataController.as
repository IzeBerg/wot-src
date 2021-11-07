package net.wg.infrastructure.helpers.statisticsDataController.intarfaces
{
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   
   public interface IEpicBattleStatisticDataController
   {
       
      
      function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void;
      
      function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void;
      
      function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void;
   }
}
