package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   public class VehicleInspireMarker extends VehicleStunMarker
   {
       
      
      public function VehicleInspireMarker()
      {
         super();
      }
      
      override protected function updateSourceVehicle() : void
      {
         arrowContainer.updateColorSettings(arrowColorFrame);
      }
   }
}
