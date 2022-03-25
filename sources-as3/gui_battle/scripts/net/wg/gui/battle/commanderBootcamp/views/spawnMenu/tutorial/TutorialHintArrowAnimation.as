package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   import flash.display.MovieClip;
   
   public class TutorialHintArrowAnimation extends TutorialHintAnimation implements ITutorialHintArrowAnimation
   {
       
      
      public var loopAnimation:MovieClip = null;
      
      private var _needHide:Boolean = false;
      
      private var _isLooped:Boolean = false;
      
      public function TutorialHintArrowAnimation()
      {
         super();
         showAnimation.addFrameScript(showAnimation.totalFrames - 1,this.endShowAnimationDispatch);
      }
      
      override protected function getAnimations() : void
      {
         super.getAnimations();
         animations.push(this.loopAnimation);
      }
      
      override protected function onDispose() : void
      {
         this.loopAnimation.addFrameScript(this.loopAnimation.totalFrames - 1,null);
         showAnimation.addFrameScript(showAnimation.totalFrames - 1,null);
         this.loopAnimation = null;
         super.onDispose();
      }
      
      public function loop() : void
      {
         hideAndStopAnimations();
         this.loopAnimation.visible = true;
         this.loopAnimation.gotoAndPlay(0);
      }
      
      public function needToHide(param1:Boolean) : void
      {
         this._needHide = param1;
         if(this._needHide)
         {
            this.loopAnimation.addFrameScript(this.loopAnimation.totalFrames - 1,this.endLoopAnimationDispatch);
         }
      }
      
      private function endShowAnimationDispatch() : void
      {
         dispatchEvent(new TutorialHintEvent(TutorialHintEvent.ANIMATION_ENDED));
         if(this._isLooped)
         {
            this.loop();
         }
      }
      
      private function endLoopAnimationDispatch() : void
      {
         if(this._needHide)
         {
            this.loopAnimation.stop();
            this._isLooped = false;
            dispatchEvent(new TutorialHintEvent(TutorialHintEvent.LOOP_ENDED));
         }
      }
      
      public function get isLooped() : Boolean
      {
         return this._isLooped;
      }
      
      public function set isLooped(param1:Boolean) : void
      {
         this._isLooped = param1;
      }
   }
}
