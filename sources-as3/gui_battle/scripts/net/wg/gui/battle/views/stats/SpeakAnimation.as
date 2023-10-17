package net.wg.gui.battle.views.stats
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SpeakAnimation extends MovieClip implements IDisposable
   {
      
      private static const FRAME_SHOW:String = "show";
      
      private static const FRAME_HIDE:String = "hide";
       
      
      public var waveAnimationMC:MovieClip = null;
      
      public var muteIcon:MovieClip = null;
      
      private var _isMuted:Boolean = false;
      
      private var _isSpeaking:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function SpeakAnimation()
      {
         super();
         this.waveAnimationMC.stop();
         this.muteIcon.visible = false;
      }
      
      public final function dispose() : void
      {
         this.waveAnimationMC = null;
         this.muteIcon = null;
         this._disposed = true;
      }
      
      public function get speaking() : Boolean
      {
         return this._isSpeaking;
      }
      
      public function set speaking(param1:Boolean) : void
      {
         if(this._isMuted || param1 == this._isSpeaking)
         {
            return;
         }
         this._isSpeaking = param1;
         if(param1)
         {
            this.waveAnimationMC.play();
            gotoAndPlay(FRAME_SHOW);
         }
         else
         {
            gotoAndPlay(FRAME_HIDE);
         }
      }
      
      public function set mute(param1:Boolean) : void
      {
         if(param1 == this._isMuted)
         {
            return;
         }
         this._isMuted = param1;
         this.muteIcon.visible = param1;
         if(this._isMuted)
         {
            this._isSpeaking = false;
            gotoAndStop(FRAME_SHOW);
            this.waveAnimationMC.stop();
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
