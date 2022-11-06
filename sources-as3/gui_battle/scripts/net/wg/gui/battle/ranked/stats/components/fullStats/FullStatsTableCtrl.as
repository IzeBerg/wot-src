package net.wg.gui.battle.ranked.stats.components.fullStats
{
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   
   public class FullStatsTableCtrl extends StatsTableControllerBase implements ITabbedFullStatsTableController
   {
      
      private static const RIGHT_COLUMN:int = 1;
      
      private static const NUM_ROWS:int = 10;
       
      
      public function FullStatsTableCtrl(param1:FullStatsTable)
      {
         super(param1);
      }
      
      override protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         var _loc3_:StatsTableItem = this.createPlayerStatsItem(param1,param2);
         var _loc4_:DogTagCtrl = this.createDogTagCtrl(param1,param2);
         return new StatsTableItemHolder(_loc3_,_loc4_,param1 == RIGHT_COLUMN);
      }
      
      private function createDogTagCtrl(param1:int, param2:int) : DogTagCtrl
      {
         var _loc3_:int = param1 * this.numRows + param2;
         return new DogTagCtrl(this.getTable().hitCollection[_loc3_]);
      }
      
      private function createPlayerStatsItem(param1:int, param2:int) : StatsTableItem
      {
         return new StatsTableItem(this.getTable(),param1,param2);
      }
      
      override protected function get numRows() : int
      {
         return NUM_ROWS;
      }
      
      private function getTable() : FullStatsTable
      {
         return FullStatsTable(table);
      }
   }
}
