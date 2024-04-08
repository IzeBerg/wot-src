package net.wg.gui.battle.pveBase.views.stats.components.playersPanel.infrastructure
{
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.PveDAAPIVehiclesDataVO;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class PveStatisticsDataController extends BattleStatisticDataController
   {
       
      
      public function PveStatisticsDataController()
      {
         super();
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new PveDAAPIVehiclesDataVO(param1);
      }
   }
}
