package net.wg.gui.battle.commander.views.fullStats.list.supply
{
   public class RTSFullStatsItemSupplyRight extends AbstractRTSFullStatsItemSupply
   {
       
      
      public function RTSFullStatsItemSupplyRight()
      {
         super();
      }
      
      override protected function get isAllyItem() : Boolean
      {
         return false;
      }
   }
}
