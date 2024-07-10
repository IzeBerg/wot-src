package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ZoomingAimDamage extends MovieClip implements IDisposable
   {
       
      
      public var aim:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      public function ZoomingAimDamage()
      {
         super();
         blendMode = BlendMode.SCREEN;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.aim = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setStage(param1:String) : void
      {
         this.aim.gotoAndStop(param1);
      }
   }
}
