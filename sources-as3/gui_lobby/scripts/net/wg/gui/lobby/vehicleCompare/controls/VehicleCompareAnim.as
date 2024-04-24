package net.wg.gui.lobby.vehicleCompare.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareAnimVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleCompareAnim extends MovieClip implements IDisposable
   {
       
      
      public var renderer:VehicleCompareAnimRenderer;
      
      private var _disposed:Boolean = false;
      
      public function VehicleCompareAnim()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.renderer.dispose();
         this.renderer = null;
      }
      
      public function setData(param1:VehicleCompareAnimVO) : void
      {
         this.renderer.setData(param1);
      }
      
      override public function get width() : Number
      {
         return this.renderer.width;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
