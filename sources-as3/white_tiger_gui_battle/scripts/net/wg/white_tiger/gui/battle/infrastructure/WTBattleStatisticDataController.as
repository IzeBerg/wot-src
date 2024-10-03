package net.wg.white_tiger.gui.battle.infrastructure
{
   import flash.display.DisplayObjectContainer;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehiclesDataVO;
   import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
   
   public class WTBattleStatisticDataController extends BattleStatisticDataController
   {
       
      
      public function WTBattleStatisticDataController(param1:DisplayObjectContainer)
      {
         super(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new DAAPIHunterVehiclesDataVO(param1);
      }
   }
}
