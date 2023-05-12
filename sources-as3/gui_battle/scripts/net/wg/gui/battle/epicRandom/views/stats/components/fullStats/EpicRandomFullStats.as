package net.wg.gui.battle.epicRandom.views.stats.components.fullStats
{
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.gui.battle.ClassicFullStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class EpicRandomFullStats extends ClassicFullStats implements IBattleComponentDataController
   {
       
      
      public function EpicRandomFullStats()
      {
         super();
         visible = true;
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         return new EpicRandomFullStatsTableCtrl(EpicRandomFullStatsTable(statsTable),this);
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.isEnemy)
         {
            tableCtrl.setVehicleStatus(true,_loc2_.vehicleID,_loc2_.status,_loc2_.rightVehiclesIDs);
            if(_loc2_.dogTag)
            {
               tableCtrl.setDogTagToShow(_loc2_.vehicleID,_loc2_.dogTag);
            }
         }
         else
         {
            tableCtrl.setVehicleStatus(false,_loc2_.vehicleID,_loc2_.status,_loc2_.leftVehiclesIDs);
         }
      }
   }
}
