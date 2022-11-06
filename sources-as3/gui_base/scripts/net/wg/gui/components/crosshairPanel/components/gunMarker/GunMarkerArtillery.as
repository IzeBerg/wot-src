package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   public class GunMarkerArtillery extends GunMarkerStrategic
   {
       
      
      public function GunMarkerArtillery()
      {
         super();
         var _loc1_:int = 0;
         while(_loc1_ < _nodesTotal)
         {
            _nodes[_loc1_].gotoAndStop(NODE_TYPE_GREEN);
            _loc1_++;
         }
      }
      
      override protected function setCurrentReloading(param1:Number) : void
      {
      }
   }
}
