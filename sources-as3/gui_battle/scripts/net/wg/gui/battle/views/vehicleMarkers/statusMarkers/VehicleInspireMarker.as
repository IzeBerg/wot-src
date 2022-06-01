package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.text.TextField;
   
   public class VehicleInspireMarker extends VehicleStunMarker
   {
       
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public function VehicleInspireMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MarkerAssetContainer = arrowMc as MarkerAssetContainer;
         if(_loc1_)
         {
            _loc1_.dispose();
         }
         this.glowContainer.dispose();
         this.glowContainer = null;
         super.onDispose();
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         this.updateArrowContainer();
         this.glowContainer.updateColorSettings(color);
         TextField(counterMc.labelTf).textColor = param1;
      }
      
      override protected function updateSourceVehicle() : void
      {
         this.updateArrowContainer();
      }
      
      private function updateArrowContainer() : void
      {
         var _loc1_:MarkerAssetContainer = arrowMc as MarkerAssetContainer;
         if(_loc1_)
         {
            _loc1_.updateColorSettings(arrowColorFrame);
         }
      }
   }
}
