package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   public class VehicleBerserkerMarker extends VehicleAnimatedStatusBaseMarker
   {
       
      
      public var iconContainer:MarkerAssetContainer = null;
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public function VehicleBerserkerMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.iconContainer.dispose();
         this.iconContainer = null;
         this.glowContainer.dispose();
         this.glowContainer = null;
         super.onDispose();
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         this.iconContainer.updateColorSettings(color);
         this.glowContainer.updateColorSettings(color);
      }
   }
}
