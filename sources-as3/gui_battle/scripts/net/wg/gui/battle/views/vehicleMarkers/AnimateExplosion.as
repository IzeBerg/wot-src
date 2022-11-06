package net.wg.gui.battle.views.vehicleMarkers
{
   public class AnimateExplosion extends HealthBarAnimatedPart
   {
       
      
      public function AnimateExplosion()
      {
         super();
         partType = VehicleMarkersConstants.HB_ANIMATED_PART_EXPLOSION;
      }
      
      public function setColorAndDamageType(param1:String, param2:String) : void
      {
         setAnimationType(param1 + "_" + param2);
      }
   }
}
