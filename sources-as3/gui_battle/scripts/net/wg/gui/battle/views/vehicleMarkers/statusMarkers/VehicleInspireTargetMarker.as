package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   public class VehicleInspireTargetMarker extends VehicleAnimatedStatusBaseMarker
   {
       
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public var arrowContainer:MarkerAssetContainer = null;
      
      public function VehicleInspireTargetMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.glowContainer.dispose();
         this.glowContainer = null;
         this.arrowContainer.dispose();
         this.arrowContainer = null;
         super.onDispose();
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         this.arrowContainer.updateColorSettings(arrowColorFrame);
         this.glowContainer.updateColorSettings(color);
      }
      
      override protected function updateSourceVehicle() : void
      {
         this.arrowContainer.updateColorSettings(arrowColorFrame);
      }
   }
}
