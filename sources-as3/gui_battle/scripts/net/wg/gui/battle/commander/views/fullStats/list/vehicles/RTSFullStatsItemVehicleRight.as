package net.wg.gui.battle.commander.views.fullStats.list.vehicles
{
   public class RTSFullStatsItemVehicleRight extends AbstractRTSFullStatsItemVehicle
   {
       
      
      public function RTSFullStatsItemVehicleRight()
      {
         super();
      }
      
      override protected function get isAllyItem() : Boolean
      {
         return false;
      }
   }
}
