package net.wg.gui.battle.epicRandom.views.stats.components.fullStats
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.gui.battle.TabbedFullStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class EpicRandomFullStats extends TabbedFullStats implements IBattleComponentDataController
   {
       
      
      private var _tableCtrl:EpicRandomFullStatsTableCtrl = null;
      
      public function EpicRandomFullStats()
      {
         super();
         this._tableCtrl = EpicRandomFullStatsTableCtrl(tableCtrl);
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._tableCtrl.addVehiclesInfo(false,_loc2_.leftVehicleInfos,_loc2_.leftVehiclesIDs);
         this._tableCtrl.addVehiclesInfo(true,_loc2_.rightVehicleInfos,_loc2_.rightVehiclesIDs);
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         return new EpicRandomFullStatsTableCtrl(EpicRandomFullStatsTable(statsTable),this);
      }
      
      override public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleInfoVO = null;
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         var _loc3_:Array = [];
         for each(_loc4_ in _loc2_.leftVehicleInfos)
         {
            _loc3_.push(_loc4_);
         }
         this._tableCtrl.setVehiclesData(false,_loc3_,_loc2_.leftVehiclesIDs);
         _loc3_ = [];
         for each(_loc4_ in _loc2_.rightVehicleInfos)
         {
            _loc3_.push(_loc4_);
         }
         this._tableCtrl.setVehiclesData(true,_loc3_,_loc2_.rightVehiclesIDs);
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.isEnemy)
         {
            this._tableCtrl.setVehicleStatus(true,_loc2_.vehicleID,_loc2_.status,_loc2_.rightVehiclesIDs);
            if(_loc2_.dogTag)
            {
               this._tableCtrl.setDogTagToShow(_loc2_.vehicleID,_loc2_.dogTag);
            }
         }
         else
         {
            this._tableCtrl.setVehicleStatus(false,_loc2_.vehicleID,_loc2_.status,_loc2_.leftVehiclesIDs);
         }
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._tableCtrl.updateVehiclesInfo(false,_loc2_.leftVehicleInfos,_loc2_.leftVehiclesIDs);
         this._tableCtrl.updateVehiclesInfo(true,_loc2_.rightVehicleInfos,_loc2_.rightVehiclesIDs);
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         this._tableCtrl.setFrags(_loc2_.leftFrags,_loc2_.rightFrags);
      }
      
      override protected function updateFrags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         this._tableCtrl.setFrags(_loc2_.leftFrags,_loc2_.rightFrags);
      }
      
      override protected function onDispose() : void
      {
         this._tableCtrl = null;
         super.onDispose();
      }
   }
}
