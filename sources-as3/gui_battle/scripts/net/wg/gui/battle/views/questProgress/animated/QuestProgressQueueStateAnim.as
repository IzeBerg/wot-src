package net.wg.gui.battle.views.questProgress.animated
{
   import fl.motion.easing.Cubic;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
   import net.wg.infrastructure.interfaces.questProgress.IQueueAnimItemAbstract;
   import scaleform.clik.motion.Tween;
   
   public class QuestProgressQueueStateAnim extends QuestProgressQueueAnimAbstract
   {
      
      private static const FADE_DURATION:int = 500;
      
      private static const FADE_IN_DELAY:int = 140;
       
      
      private var _tweenFadeIn:Tween = null;
      
      private var _tweenFadeOut:Tween = null;
      
      public function QuestProgressQueueStateAnim(param1:IQuestProgressView, param2:IQueueAnimItemAbstract, param3:IAnimationTopContainer)
      {
         super(param1,param2,param3);
         this._tweenFadeIn = new Tween(FADE_DURATION,param1,{"alpha":Values.DEFAULT_ALPHA},{
            "paused":true,
            "ease":Cubic.easeOut,
            "delay":FADE_IN_DELAY,
            "onComplete":this.onFadeInCompleted
         });
         this._tweenFadeIn.fastTransform = false;
         this._tweenFadeOut = new Tween(FADE_DURATION,param1,{"alpha":Values.ZERO},{
            "paused":true,
            "ease":Cubic.easeOut,
            "delay":0,
            "onComplete":null
         });
         this._tweenFadeOut.fastTransform = false;
      }
      
      override protected function onDispose() : void
      {
         this.clearTweens();
         super.onDispose();
      }
      
      override protected function onPreCompletedAnim() : void
      {
         this._tweenFadeIn.reset();
         this._tweenFadeIn.paused = false;
         super.onPreCompletedAnim();
      }
      
      override protected function onAnimStart() : void
      {
         this._tweenFadeOut.reset();
         this._tweenFadeOut.paused = false;
         super.onAnimStart();
      }
      
      private function onFadeInCompleted() : void
      {
         viewAllowCallCompleteFn = true;
         onAnimCompleted();
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
   }
}
