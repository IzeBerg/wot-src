package net.wg.gui.battle.ranked.stats.components.fullStats.tableItem
{
   import net.wg.gui.battle.ranked.VO.daapi.RankedDAAPIVehicleInfoVO;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderCommon;
   
   public class StatsTableItemHolder extends StatsTableItemHolderCommon
   {
       
      
      public function StatsTableItemHolder(param1:StatsTableItem, param2:DogTagCtrl, param3:Boolean)
      {
         super(param1,param2,param3);
      }
      
      override protected function vehicleDataSync() : void
      {
         var _loc2_:StatsTableItem = null;
         super.vehicleDataSync();
         var _loc1_:RankedDAAPIVehicleInfoVO = data as RankedDAAPIVehicleInfoVO;
         if(_loc1_)
         {
            _loc2_ = this.getStatsItem;
            _loc2_.setRank(_loc1_.division,_loc1_.level,_loc1_.isGroup);
         }
      }
      
      private function get getStatsItem() : StatsTableItem
      {
         return StatsTableItem(statsItem);
      }
   }
}
