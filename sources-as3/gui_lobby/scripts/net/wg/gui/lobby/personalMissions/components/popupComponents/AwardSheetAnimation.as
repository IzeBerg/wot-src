package net.wg.gui.lobby.personalMissions.components.popupComponents
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AwardSheetAnimation extends MovieClip implements IDisposable
   {
      
      private static const ANIMATION_FRAME:String = "animation";
       
      
      public var icon:UILoaderAlt;
      
      private var _disposed:Boolean = false;
      
      public function AwardSheetAnimation()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function playAnimation() : void
      {
         this.clearIcon();
         gotoAndPlay(ANIMATION_FRAME);
      }
      
      public function setIcon(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      protected function onDispose() : void
      {
         this.clearIcon();
      }
      
      private function clearIcon() : void
      {
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
