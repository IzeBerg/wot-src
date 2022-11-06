package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleIconAnimation extends MovieClip implements IDisposable
   {
       
      
      public var vehicleTypeIcon:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function VehicleIconAnimation()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.vehicleTypeIcon = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
