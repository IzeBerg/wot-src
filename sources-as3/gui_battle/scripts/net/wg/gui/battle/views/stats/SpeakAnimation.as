package net.wg.gui.battle.views.stats
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SpeakAnimation extends MovieClip implements IDisposable
   {
      
      private static const FRAME_SHOW:String = "show";
      
      private static const FRAME_HIDE:String = "hide";
       
      
      public var waveAnimationMC:MovieClip = null;
      
      private var _isSpeaking:Boolean = false;
      
      private var _totalFrames:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function SpeakAnimation()
      {
         super();
         stop();
         this.waveAnimationMC.stop();
         this._totalFrames = totalFrames;
         addFrameScript(this._totalFrames - 1,this.reset);
         visible = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         addFrameScript(this._totalFrames - 1,null);
         this.waveAnimationMC = null;
      }
      
      public function reset() : void
      {
         stop();
         this.waveAnimationMC.stop();
         visible = false;
      }
      
      public function get speaking() : Boolean
      {
         return this._isSpeaking;
      }
      
      public function set speaking(param1:Boolean) : void
      {
         if(param1 == this._isSpeaking)
         {
            return;
         }
         if(param1)
         {
            visible = true;
            this.waveAnimationMC.play();
            gotoAndPlay(FRAME_SHOW);
         }
         else
         {
            gotoAndPlay(FRAME_HIDE);
         }
         this._isSpeaking = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
