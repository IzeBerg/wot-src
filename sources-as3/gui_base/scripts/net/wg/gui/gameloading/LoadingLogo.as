package net.wg.gui.gameloading
{
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class LoadingLogo extends MovieClip implements IDisposable
   {
      
      private static const TWEEN_DURATION:uint = 200;
      
      private static const LOGO_WIDTH:uint = 490;
      
      private static const LOGO_HEIGHT:uint = 230;
      
      private static const LOGO_X:int = -248;
      
      private static const LOGO_Y:int = -105;
       
      
      public var logo:UILoaderAlt = null;
      
      private var _tween:Tween = null;
      
      private var _disposed:Boolean = false;
      
      public function LoadingLogo()
      {
         super();
         this.logo.addEventListener(UILoaderEvent.COMPLETE,this.onLogoCompleteHandler);
         this.logo.source = RES_ICONS.MAPS_ICONS_LIBRARY_LOGOS_LOADING_LOGO;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.logo.removeEventListener(UILoaderEvent.COMPLETE,this.onLogoCompleteHandler);
         this.logo.dispose();
         this.logo = null;
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onLogoCompleteHandler(param1:UILoaderEvent) : void
      {
         this._tween = new Tween(TWEEN_DURATION,this.logo,{
            "x":LOGO_X,
            "y":LOGO_Y,
            "width":LOGO_WIDTH,
            "height":LOGO_HEIGHT,
            "alpha":1
         },{"ease":Strong.easeIn});
      }
   }
}
