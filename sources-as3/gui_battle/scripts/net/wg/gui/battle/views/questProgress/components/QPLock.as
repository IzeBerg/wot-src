package net.wg.gui.battle.views.questProgress.components
{
   import fl.motion.easing.Quartic;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class QPLock extends MovieClip implements IDisposable
   {
      
      private static const FADE_IN_DURATION:int = 1000;
      
      private static const ALPHA_SHOW:int = 1;
      
      private static const ALPHA_HIDE:int = 0;
      
      private static const LOCK_TWEEN_DELAY:int = 500;
      
      private static const HIDE_STATE:String = "hide";
       
      
      public var lockSprite:Sprite = null;
      
      public var lineAnimation:QPLockLineAnimation = null;
      
      private var _lockTween:Tween = null;
      
      private var _disposed:Boolean = false;
      
      public function QPLock()
      {
         super();
         blendMode = BlendMode.SCREEN;
         this._lockTween = new Tween(FADE_IN_DURATION,this,{"alpha":ALPHA_SHOW},{
            "paused":true,
            "ease":Quartic.easeOut,
            "delay":LOCK_TWEEN_DELAY,
            "fastTransform":false,
            "onComplete":this.onLockTweenComplete
         });
         addFrameScript(totalFrames - 1,this.onHide);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         addFrameScript(totalFrames - 1,null);
         this._lockTween.paused = true;
         this._lockTween.dispose();
         this._lockTween = null;
         this.lockSprite = null;
         this.lineAnimation.dispose();
         this.lineAnimation = null;
      }
      
      public function hide() : void
      {
         gotoAndPlay(HIDE_STATE);
      }
      
      public function resetShownContent() : void
      {
         this._lockTween.paused = true;
         this._lockTween.reset();
         this.lineAnimation.resetShownContent();
         alpha = ALPHA_HIDE;
      }
      
      public function resetTween() : void
      {
         this._lockTween.paused = true;
         this._lockTween.reset();
      }
      
      public function setLockedItemsCount(param1:uint) : void
      {
         this.lineAnimation.gotoAndStop(param1);
      }
      
      public function showContent() : void
      {
         alpha = ALPHA_SHOW;
         this.lineAnimation.showContent();
      }
      
      public function showContentAnimation() : void
      {
         this._lockTween.reset();
         this._lockTween.paused = false;
      }
      
      private function onLockTweenComplete() : void
      {
         this.lineAnimation.showAnim();
      }
      
      private function onHide() : void
      {
         visible = false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
