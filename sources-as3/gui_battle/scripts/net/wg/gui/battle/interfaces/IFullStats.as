package net.wg.gui.battle.interfaces
{
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.entity.IDisplayable;
   
   public interface IFullStats extends IBattleComponentDataController, IQuestProgressStats, IDAAPIModule, IDisplayable
   {
       
      
      function updateStageSize(param1:Number, param2:Number) : void;
      
      function getTableCtrl() : ITabbedFullStatsTableController;
   }
}
