package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class MarkerAssetContainer extends MovieClip implements IDisposable, IMarkerManagerHandler
   {
       
      
      public var markerMc:MovieClip = null;
      
      private var _baseDisposed:Boolean = false;
      
      private var _iconName:String = "";
      
      private var _atlasSrcMode:Boolean;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      public function MarkerAssetContainer()
      {
         super();
         this._vmManager = VehicleMarkersManager.getInstance();
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this._vmManager = null;
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function managerReadyHandler() : void
      {
         this.redrawIcon();
      }
      
      public function setIconName(param1:String) : void
      {
         if(this._iconName != param1)
         {
            this._iconName = param1;
            this._atlasSrcMode = !StringUtils.isEmpty(this._iconName);
            if(this._atlasSrcMode)
            {
               if(this._vmManager.isAtlasInited)
               {
                  this.redrawIcon();
               }
               else
               {
                  this._vmManager.addReadyHandler(this);
               }
            }
         }
      }
      
      public function updateColorSettings(param1:String) : void
      {
         if(!this._atlasSrcMode)
         {
            this.markerMc.gotoAndStop(param1);
         }
      }
      
      protected function onDispose() : void
      {
         this.markerMc = null;
      }
      
      private function redrawIcon() : void
      {
         if(this._atlasSrcMode)
         {
            this._vmManager.drawWithCenterAlign(this._iconName,this.markerMc.graphics,true,true);
         }
      }
   }
}
