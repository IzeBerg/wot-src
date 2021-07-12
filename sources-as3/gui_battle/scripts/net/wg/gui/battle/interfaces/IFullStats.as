package net.wg.gui.battle.interfaces
{
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public interface IFullStats extends IBattleComponentDataController, IQuestProgressStats, IDAAPIModule
   {
       
      
      function updateStageSize(param1:Number, param2:Number) : void;
      
      function getTableCtrl() : ITabbedFullStatsTableController;
   }
}
