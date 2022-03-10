package net.wg.gui.battle.views.questProgress.animated
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import scaleform.clik.motion.Tween;
   
   public class AnimationTopContainer extends Sprite implements IAnimationTopContainer
   {
      
      private static const FADE_IN_DURATION:int = 400;
       
      
      public var shadow:Sprite = null;
      
      private var _tweenFadeIn:Tween = null;
      
      private var _tweenFadeOut:Tween = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimationTopContainer()
      {
         super();
         this._tweenFadeIn = new Tween(FADE_IN_DURATION,this.shadow,{"alpha":Values.DEFAULT_ALPHA},{
            "paused":true,
            "ease":Cubic.easeOut,
            "delay":0,
            "onComplete":null
         });
         this._tweenFadeIn.fastTransform = false;
         this._tweenFadeOut = new Tween(FADE_IN_DURATION,this.shadow,{"alpha":Values.ZERO},{
            "paused":true,
            "ease":Cubic.easeOut,
            "delay":0,
            "onComplete":null
         });
         this._tweenFadeOut.fastTransform = false;
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
         this.shadow = null;
      }
      
      public function hide() : void
      {
         this._tweenFadeOut.reset();
         this._tweenFadeOut.paused = false;
      }
      
      public function show() : void
      {
         this._tweenFadeIn.reset();
         this._tweenFadeIn.paused = false;
      }
      
      private function clearTweens() : void
      {
         if(this._tweenFadeIn)
         {
            this._tweenFadeIn.paused = true;
            this._tweenFadeIn.dispose();
            this._tweenFadeIn = null;
         }
         if(this._tweenFadeOut)
         {
            this._tweenFadeOut.paused = true;
            this._tweenFadeOut.dispose();
            this._tweenFadeOut = null;
         }
      }
      
      public function reset() : void
      {
         this.hide();
         this.shadow.alpha = Values.ZERO;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
