package net.wg.gui.components.vehicleHitArea
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleHitAreaComponent extends MovieClip implements IDisposable
   {
       
      
      public var hit:VehicleHitArea;
      
      private var _disposed:Boolean = false;
      
      public function VehicleHitAreaComponent()
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
