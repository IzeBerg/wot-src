package net.wg.gui.battle.commander.views.fullStats.list.supply
{
   public class RTSFullStatsListSupplyLeft extends AbstractRTSFullStatsListSupply
   {
      
      private static const ITEM_LINKAGE:String = "RTSFullStatsListItemSupplyLeftUI";
       
      
      public function RTSFullStatsListSupplyLeft()
      {
         super();
      }
      
      override protected function getItemLinkage() : String
      {
         return ITEM_LINKAGE;
      }
   }
}
