package net.wg.gui.battle.commander.views.fullStats.list.supply
{
   public class RTSFullStatsListSupplyRight extends AbstractRTSFullStatsListSupply
   {
      
      private static const ITEM_LINKAGE:String = "RTSFullStatsListItemSupplyRightUI";
       
      
      public function RTSFullStatsListSupplyRight()
      {
         super();
      }
      
      override protected function getItemLinkage() : String
      {
         return ITEM_LINKAGE;
      }
   }
}
