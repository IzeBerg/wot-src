package net.wg.gui.battle.random.views.stats.components.fullStats
{
   import net.wg.gui.battle.TabbedFullStats;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   
   public class FullStats extends TabbedFullStats
   {
       
      
      public function FullStats()
      {
         super();
      }
      
      override public function getTableCtrl() : ITabbedFullStatsTableController
      {
         return new FullStatsTableCtrl(FullStatsTable(statsTable),this);
      }
   }
}
