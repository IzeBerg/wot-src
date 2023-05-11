package net.wg.gui.battle.ranked.stats.components.fullStats
{
   import net.wg.gui.battle.StatsBase;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   
   public class FullStats extends StatsBase
   {
       
      
      public function FullStats()
      {
         super();
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         return new FullStatsTableCtrl(FullStatsTable(statsTable));
      }
   }
}
