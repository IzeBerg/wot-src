package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MarkerAssetContainer extends MovieClip implements IDisposable
   {
       
      
      public var markerMc:MovieClip = null;
      
      private var _baseDisposed:Boolean = false;
      
      public function MarkerAssetContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function updateColorSettings(param1:String) : void
      {
         this.markerMc.gotoAndStop(param1);
      }
      
      protected function onDispose() : void
      {
         this.markerMc = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
