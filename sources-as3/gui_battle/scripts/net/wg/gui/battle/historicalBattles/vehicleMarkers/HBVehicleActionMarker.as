package net.wg.gui.battle.historicalBattles.vehicleMarkers
{
   import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;
   
   public class HBVehicleActionMarker extends VehicleActionMarker
   {
       
      
      private const HISTORICAL_STICKY_MARKER_UI:String = "HistoricalStickyMarkerUI";
      
      public function HBVehicleActionMarker()
      {
         super();
      }
      
      override protected function get stickyMarkerClassLinkage() : String
      {
         return this.HISTORICAL_STICKY_MARKER_UI;
      }
   }
}
