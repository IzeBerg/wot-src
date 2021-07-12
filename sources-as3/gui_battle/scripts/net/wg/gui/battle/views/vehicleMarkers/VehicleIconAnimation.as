package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleIconAnimation extends MovieClip implements IDisposable
   {
       
      
      public var vehicleTypeIcon:MovieClip = null;
      
      public function VehicleIconAnimation()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.vehicleTypeIcon = null;
      }
   }
}
