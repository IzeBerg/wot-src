package net.wg.gui.battle.ranked.infrastructure
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehiclesDataVO;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class RankedStatisticsDataController extends BattleStatisticDataController
   {
       
      
      public function RankedStatisticsDataController(param1:DisplayObjectContainer)
      {
         super(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new RankedDAAPIVehiclesDataVO(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForVehInfo(param1:Object) : DAAPIVehiclesDataVO
      {
         return this.getDAAPIVehiclesDataVOForVehData(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForUpVehInfo(param1:Object) : DAAPIVehiclesDataVO
      {
         return this.getDAAPIVehiclesDataVOForVehData(param1);
      }
   }
}
