package net.wg.gui.battle.commander.views.fullStats.list.vehicles
{
   public class RTSFullStatsListVehiclesLeft extends AbstractRTSFullStatsListVehicles
   {
      
      private static const ITEM_LINKAGE:String = "RTSFullStatsListItemVehicleLeftUI";
       
      
      public function RTSFullStatsListVehiclesLeft()
      {
         super();
      }
      
      override protected function getItemLinkage() : String
      {
         return ITEM_LINKAGE;
      }
      
      override protected function get isAllyList() : Boolean
      {
         return true;
      }
   }
}
