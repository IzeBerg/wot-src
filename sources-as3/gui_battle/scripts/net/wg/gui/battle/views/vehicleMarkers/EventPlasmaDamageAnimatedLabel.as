package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   
   public class EventPlasmaDamageAnimatedLabel extends HealthBarAnimatedLabel
   {
       
      
      public var plasmaIcon:MovieClip = null;
      
      public function EventPlasmaDamageAnimatedLabel()
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
