package net.wg.white_tiger.gui.battle.views.wtFullStats
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.eventBattle.VO.DAAPIHunterVehicleInfoVO;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItemHolder;
   
   public class FullStatsTableItemHolder extends StatsTableItemHolder
   {
      
      private static const EVENT_VEHICLE_TYPE_PREFIX:String = "wt_";
       
      
      private var _statsItem:FullStatsTableItem = null;
      
      private var _data:DAAPIHunterVehicleInfoVO = null;
      
      public function FullStatsTableItemHolder(param1:FullStatsTableItem, param2:DynamicSquadCtrl, param3:Boolean)
      {
         super(param1,param2,param3);
         this._statsItem = param1;
      }
      
      override public function setDAAPIVehicleData(param1:DAAPIVehicleInfoVO) : void
      {
         this._data = param1 as DAAPIHunterVehicleInfoVO;
         this.updateTimers();
         super.setDAAPIVehicleData(param1);
      }
      
      override protected function onDispose() : void
      {
         this._statsItem = null;
         this._data = null;
         super.onDispose();
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
      
      override public function get isSelected() : Boolean
      {
         return super.isSelected && this._data == null;
      }
   }
}
