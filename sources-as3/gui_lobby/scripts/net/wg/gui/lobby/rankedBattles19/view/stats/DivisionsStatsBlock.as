package net.wg.gui.lobby.rankedBattles19.view.stats
{
   import flash.display.Sprite;
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesStatsBlockVO;
   
   public class DivisionsStatsBlock extends StatsBlock
   {
       
      
      public var divisionEfficiency:RankedBattleStats = null;
      
      public var seasonEfficiency:RankedBattleStats = null;
      
      public var separator:Sprite = null;
      
      public function DivisionsStatsBlock()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.divisionEfficiency.dispose();
         this.divisionEfficiency = null;
         this.seasonEfficiency.dispose();
         this.seasonEfficiency = null;
         this.separator = null;
         super.onDispose();
      }
      
      override protected function minimizeElements() : void
      {
         this.divisionEfficiency.minimize();
         this.seasonEfficiency.minimize();
      }
      
      override protected function maximizeElements() : void
      {
         this.divisionEfficiency.maximize();
         this.seasonEfficiency.maximize();
      }
      
      public function setData(param1:RankedBattlesStatsBlockVO) : void
      {
         if(param1)
         {
            this.divisionEfficiency.setData(param1.divisionEfficiency);
            this.seasonEfficiency.setData(param1.seasonEfficiency);
         }
      }
   }
}
