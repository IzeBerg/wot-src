package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationFadeInFadeOutMovieClip extends MovieClip implements IDisposable
   {
      
      private static const FADE_IN_FRAME_LABEL:String = "fadeIn";
      
      private static const FADE_OUT_FRAME_LABEL:String = "fadeOut";
      
      private static const FADE_IN_STATE:uint = 0;
      
      private static const FADE_OUT_STATE:uint = 1;
       
      
      public var currentState:int = 1;
      
      public var customizationContentTypeIcon:MovieClip;
      
      public function CustomizationFadeInFadeOutMovieClip()
      {
         super();
         mouseChildren = mouseEnabled = false;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function fadeIn() : void
      {
         if(this.currentState != FADE_IN_STATE)
         {
            this.currentState = FADE_IN_STATE;
            gotoAndPlay(FADE_IN_FRAME_LABEL);
         }
      }
      
      public function fadeOut() : void
      {
         if(this.currentState != FADE_OUT_STATE)
         {
            this.currentState = FADE_OUT_STATE;
            gotoAndPlay(FADE_OUT_FRAME_LABEL);
         }
      }
      
      public function setType(param1:int) : void
      {
         this.customizationContentTypeIcon.gotoAndStop(param1 + 1);
      }
      
      protected function onDispose() : void
      {
         stop();
         this.customizationContentTypeIcon = null;
      }
   }
}
