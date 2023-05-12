package net.wg.gui.battle.epicRandom.infrastructure
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.gui.battle.epicRandom.VO.daapi.EpicRandomDAAPIVehiclesDataVO;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class EpicRandomStatisticsDataController extends BattleStatisticDataController
   {
       
      
      public function EpicRandomStatisticsDataController(param1:DisplayObjectContainer)
      {
         super(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new EpicRandomDAAPIVehiclesDataVO(param1);
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
