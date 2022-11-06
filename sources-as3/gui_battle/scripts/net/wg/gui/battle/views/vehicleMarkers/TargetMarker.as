package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TargetMarker extends MovieClip implements IDisposable
   {
       
      
      public var marker:Sprite;
      
      private var _disposed:Boolean = false;
      
      public function TargetMarker()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.marker = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
