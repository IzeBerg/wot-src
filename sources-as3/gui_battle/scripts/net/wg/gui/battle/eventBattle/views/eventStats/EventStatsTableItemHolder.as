package net.wg.gui.battle.eventBattle.views.eventStats
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehicleInfoVO;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItemHolder;
   
   public class EventStatsTableItemHolder extends StatsTableItemHolder
   {
      
      private static const EVENT_VEHICLE_TYPE_PREFIX:String = "wt_";
       
      
      private var _statsItem:EventStatsTableItem = null;
      
      private var _data:DAAPIHunterVehicleInfoVO = null;
      
      public function EventStatsTableItemHolder(param1:EventStatsTableItem, param2:DynamicSquadCtrl, param3:Boolean)
      {
         super(param1,param2,param3);
         this._statsItem = param1;
      }
      
      override protected function onDispose() : void
      {
         this._statsItem = null;
         this._data = null;
         super.onDispose();
      }
      
      override public function get isSelected() : Boolean
      {
         return super.isSelected && this._data == null;
      }
      
      override public function setDAAPIVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         this._data = param1 as DAAPIHunterVehicleInfoVO;
         this.updateTimers();
         super.setDAAPIVehicleData(param1);
      }
      
      override protected function vehicleDataSync() : void
      {
         super.vehicleDataSync();
         if(this._data != null)
         {
            this._statsItem.isResurrect = this._data.resurrectTimeLeft > 0;
         }
      }
      
      override protected function updateVehicleType() : void
      {
         this._statsItem.setVehicleType(EVENT_VEHICLE_TYPE_PREFIX + data.vehicleType);
      }
      
      private function updateTimers() : void
      {
         this._statsItem.setResurrectTimer(this._data.resurrectTimeLeft,this._data.resurrectTimeTotal,this._data.replaySpeed);
      }
   }
}
