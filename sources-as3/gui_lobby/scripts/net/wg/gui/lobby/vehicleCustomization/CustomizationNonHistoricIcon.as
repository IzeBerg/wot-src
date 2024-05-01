package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationNonHistoricIcon extends MovieClip implements IDisposable
   {
      
      private static const FADE_IN_FRAME_LABEL:String = "fadeIn";
      
      private static const FADE_OUT_FRAME_LABEL:String = "fadeOut";
      
      private static const FADE_IN_STATE:uint = 0;
      
      private static const FADE_OUT_STATE:uint = 1;
       
      
      public var currentState:int = 1;
      
      private var _disposed:Boolean = false;
      
      public function CustomizationNonHistoricIcon()
      {
         super();
         mouseChildren = mouseEnabled = false;
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
      
      public final function dispose() : void
      {
         this._disposed = true;
         stop();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
