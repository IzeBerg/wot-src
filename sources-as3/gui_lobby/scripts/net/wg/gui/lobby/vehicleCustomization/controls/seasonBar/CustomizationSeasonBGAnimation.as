package net.wg.gui.lobby.vehicleCustomization.controls.seasonBar
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.ImageWrapper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationSeasonBGAnimation extends MovieClip implements IDisposable
   {
      
      private static const ANIM_STATE_SHOW:String = "show";
      
      private static const ANIM_STATE_HIDE:String = "hide";
      
      private static const ANIM_SHOW_FINAL_FRAME:int = 10;
      
      private static const SMALL_ALPHA:Number = 0.4;
       
      
      public var image:ImageWrapper = null;
      
      public var shine:Image = null;
      
      private var _isMinResolution:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function CustomizationSeasonBGAnimation()
      {
         super();
         addFrameScript(ANIM_SHOW_FINAL_FRAME,this.gotoStart);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
         addFrameScript(ANIM_SHOW_FINAL_FRAME,null);
         this.image.dispose();
         this.image = null;
         this.shine.dispose();
         this.shine = null;
      }
      
      public function hide() : void
      {
         gotoAndPlay(ANIM_STATE_HIDE);
      }
      
      public function show() : void
      {
         gotoAndPlay(ANIM_STATE_SHOW);
      }
      
      private function gotoStart() : void
      {
         gotoAndStop(1);
      }
      
      public function toggleResolution(param1:Boolean) : void
      {
         if(this._isMinResolution == param1)
         {
            return;
         }
         this._isMinResolution = param1;
         this.image.image.alpha = !!param1 ? Number(SMALL_ALPHA) : Number(1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
