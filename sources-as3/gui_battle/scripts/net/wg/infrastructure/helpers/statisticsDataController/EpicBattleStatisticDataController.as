package net.wg.infrastructure.helpers.statisticsDataController
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.infrastructure.base.meta.IEpicBattleStatisticDataControllerMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattleStatisticDataControllerMeta;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   
   public class EpicBattleStatisticDataController extends EpicBattleStatisticDataControllerMeta implements IEpicBattleStatisticDataControllerMeta
   {
       
      
      private var _epicComponents:Vector.<IEpicBattleStatisticDataController> = null;
      
      public function EpicBattleStatisticDataController()
      {
         super();
         this._epicComponents = new Vector.<IEpicBattleStatisticDataController>(0);
      }
      
      override protected function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         var _loc2_:IEpicBattleStatisticDataController = null;
         for each(_loc2_ in this._epicComponents)
         {
            _loc2_.setEpicVehiclesStats(param1);
         }
      }
      
      override protected function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         var _loc2_:IEpicBattleStatisticDataController = null;
         for each(_loc2_ in this._epicComponents)
         {
            _loc2_.updateEpicVehiclesStats(param1);
         }
      }
      
      override protected function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
         var _loc2_:IEpicBattleStatisticDataController = null;
         for each(_loc2_ in this._epicComponents)
         {
            _loc2_.updateEpicPlayerStats(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this._epicComponents.fixed = false;
         this._epicComponents.splice(0,this._epicComponents.length);
         this._epicComponents = null;
         super.onDispose();
      }
      
      public function registerEpicComponentController(param1:IEpicBattleStatisticDataController) : void
      {
         App.utils.asserter.assertNotNull(param1,"ComponentController to be added " + Errors.CANT_NULL);
         this._epicComponents.push(param1);
      }
      
      public function unregisterEpicComponentController(param1:IEpicBattleStatisticDataController) : void
      {
         var _loc2_:int = this._epicComponents.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._epicComponents.splice(_loc2_,1);
         }
      }
   }
}
