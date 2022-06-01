package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   
   public class VehicleStatusIconMarker extends VehicleAnimatedStatusBaseMarker
   {
       
      
      public var iconMC:MovieClip = null;
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public function VehicleStatusIconMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.glowContainer.dispose();
         this.glowContainer = null;
         this.iconMC = null;
         super.onDispose();
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         this.glowContainer.updateColorSettings(color);
         this.iconMC.gotoAndStop(color);
      }
   }
}
