package net.wg.gui.battle.commander.views.fullStats.list.vehicles
{
   public class RTSFullStatsListVehiclesRight extends AbstractRTSFullStatsListVehicles
   {
      
      private static const ITEM_LINKAGE:String = "RTSFullStatsListItemVehicleRightUI";
       
      
      public function RTSFullStatsListVehiclesRight()
      {
         super();
      }
      
      override protected function getItemLinkage() : String
      {
         return ITEM_LINKAGE;
      }
      
      override protected function get isAllyList() : Boolean
      {
         return false;
      }
   }
}
