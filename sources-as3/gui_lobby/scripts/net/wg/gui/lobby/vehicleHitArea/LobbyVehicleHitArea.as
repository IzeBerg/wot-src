package net.wg.gui.lobby.vehicleHitArea
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LobbyVehicleHitArea extends MovieClip implements IDisposable
   {
       
      
      public var hit:VehicleHitArea;
      
      private var _disposed:Boolean = false;
      
      public function LobbyVehicleHitArea()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.hit = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
