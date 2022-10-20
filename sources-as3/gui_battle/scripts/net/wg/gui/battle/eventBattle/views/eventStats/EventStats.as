package net.wg.gui.battle.eventBattle.views.eventStats
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.gui.battle.ClassicFullStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class EventStats extends ClassicFullStats
   {
       
      
      private var _tableCtrl:EventStatsTableCtrl = null;
      
      public function EventStats()
      {
         super();
         visible = false;
         this._tableCtrl = EventStatsTableCtrl(tableCtrl);
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._tableCtrl.addVehiclesInfo(_loc2_.leftVehicleInfos,_loc2_.leftVehiclesIDs,false);
         this._tableCtrl.addVehiclesInfo(_loc2_.rightVehicleInfos,_loc2_.rightVehiclesIDs,true);
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         return new EventStatsTableCtrl(EventStatsTable(statsTable),this);
      }
      
      override public function setFrags(param1:IDAAPIDataClass) : void
      {
         this.updateFrags(param1);
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
         this._tableCtrl.setVehiclesData(_loc3_,_loc2_.leftVehiclesIDs,false);
         _loc3_ = [];
         for each(_loc4_ in _loc2_.rightVehicleInfos)
         {
            _loc3_.push(_loc4_);
         }
         this._tableCtrl.setVehiclesData(_loc3_,_loc2_.rightVehiclesIDs,true);
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.dogTag)
         {
            this._tableCtrl.setDogTagToShow(_loc2_.vehicleID,_loc2_.dogTag);
         }
         this._tableCtrl.setVehicleStatus(false,_loc2_.vehicleID,_loc2_.status,_loc2_.leftVehiclesIDs);
         this._tableCtrl.setVehicleStatus(true,_loc2_.vehicleID,_loc2_.status,_loc2_.rightVehiclesIDs);
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         this._tableCtrl.updateVehiclesData(_loc2_.leftVehicleInfos,_loc2_.leftVehiclesIDs,false);
         this._tableCtrl.updateVehiclesData(_loc2_.rightVehicleInfos,_loc2_.rightVehiclesIDs,true);
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
         this.updateFrags(param1);
      }
      
      override public function as_isFDEvent(param1:Boolean) : void
      {
         tabs.visible = !param1;
         this._tableCtrl.setFDEvent(param1);
      }
      
      override protected function onDispose() : void
      {
         this._tableCtrl = null;
         super.onDispose();
      }
      
      override protected function updateFrags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         this._tableCtrl.setVehiclesStats(_loc2_.leftFrags,_loc2_.rightFrags);
      }
   }
}
