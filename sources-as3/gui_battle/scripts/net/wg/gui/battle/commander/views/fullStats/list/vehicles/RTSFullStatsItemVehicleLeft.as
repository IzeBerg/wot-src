package net.wg.gui.battle.commander.views.fullStats.list.vehicles
{
   public class RTSFullStatsItemVehicleLeft extends AbstractRTSFullStatsItemVehicle
   {
       
      
      public function RTSFullStatsItemVehicleLeft()
      {
         super();
      }
      
      override protected function get isAllyItem() : Boolean
      {
         return true;
      }
   }
}
