package net.wg.white_tiger.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
   
   public class PlasmaDamageAnimatedLabel extends HealthBarAnimatedLabel
   {
       
      
      public var plasmaIcon:MovieClip = null;
      
      public function PlasmaDamageAnimatedLabel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.plasmaIcon = null;
         super.onDispose();
      }
   }
}
