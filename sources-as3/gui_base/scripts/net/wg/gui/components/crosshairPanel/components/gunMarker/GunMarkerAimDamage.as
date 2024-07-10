package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class GunMarkerAimDamage extends MovieClip implements IDisposable
   {
      
      private static const ZOOM_LABEL:String = "zoom";
       
      
      public var zoomingAim:ZoomingAimDamage = null;
      
      private var _stage:String = "stage0";
      
      private var _zoomFactor:Number = 1;
      
      private var _disposed:Boolean = false;
      
      public function GunMarkerAimDamage()
      {
         super();
         blendMode = BlendMode.SCREEN;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
         this.zoomingAim.dispose();
         this.zoomingAim = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setStage(param1:String) : void
      {
         if(this._stage != param1)
         {
            this.zoomingAim.setStage(param1);
            this._stage = param1;
         }
         gotoAndPlay(0);
      }
      
      public function set zoomFactor(param1:Number) : void
      {
         if(param1 == this._zoomFactor)
         {
            return;
         }
         this.zoomingAim.gotoAndStop(ZOOM_LABEL + param1);
         this.zoomingAim.setStage(this._stage);
         this._zoomFactor = param1;
      }
   }
}
