package net.wg.gui.battle.eventBattle.infrastructure
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehiclesDataVO;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class EventBattleStatisticDataController extends BattleStatisticDataController
   {
       
      
      public function EventBattleStatisticDataController(param1:DisplayObjectContainer)
      {
         super(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new DAAPIHunterVehiclesDataVO(param1);
      }
   }
}
