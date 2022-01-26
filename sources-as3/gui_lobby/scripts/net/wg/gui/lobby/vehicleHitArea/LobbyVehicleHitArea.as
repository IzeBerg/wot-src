package net.wg.gui.lobby.vehicleHitArea
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LobbyVehicleHitArea extends MovieClip implements IDisposable
   {
       
      
      public var hit:VehicleHitArea;
      
      public function LobbyVehicleHitArea()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.hit = null;
      }
   }
}
