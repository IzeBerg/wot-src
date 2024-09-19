package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   public class TwinGunMarker extends GunMarker
   {
       
      
      public function TwinGunMarker()
      {
         super();
      }
      
      override public function setZoomFactor(param1:Number) : void
      {
         super.setZoomFactor(param1);
         var _loc2_:TwinGunMarkerDispersionCircle = radiusMC as TwinGunMarkerDispersionCircle;
         if(_loc2_ != null)
         {
            _loc2_.zoomFactor = param1;
         }
      }
      
      public function setTwinGunActive(param1:Boolean) : void
      {
         var _loc2_:TwinGunMarkerDispersionCircle = radiusMC as TwinGunMarkerDispersionCircle;
         if(_loc2_ != null)
         {
            _loc2_.isTwinGunActive = param1;
         }
      }
      
      public function setTwinGunMarkerState(param1:uint) : void
      {
         var _loc2_:TwinGunMarkerDispersionCircle = radiusMC as TwinGunMarkerDispersionCircle;
         if(_loc2_ != null)
         {
            _loc2_.twinGunMarkerState = param1;
         }
      }
   }
}
