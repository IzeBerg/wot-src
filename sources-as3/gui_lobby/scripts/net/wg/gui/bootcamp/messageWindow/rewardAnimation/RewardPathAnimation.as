package net.wg.gui.bootcamp.messageWindow.rewardAnimation
{
   import fl.transitions.easing.Regular;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class RewardPathAnimation extends Sprite implements IDisposable
   {
      
      private static const DISAPPEAR:String = "disappear";
      
      private static const DISAPPEAR_SCALE:Number = 0.1;
      
      private static const DISAPPEAR_TIME:Number = 250;
       
      
      public var fx:MovieClip = null;
      
      public var line:MovieClip = null;
      
      private var _disappearTween:Tween;
      
      public function RewardPathAnimation()
      {
         super();
      }
      
      public function setup(param1:String) : void
      {
         this.line.gotoAndStop(param1);
         this.fx.addFrameScript(this.fx.totalFrames - 1,this.onFxComplete);
      }
      
      public function setDistance(param1:Number) : void
      {
         this.line.height = param1;
      }
      
      public function disappear() : void
      {
         this.fx.gotoAndPlay(DISAPPEAR);
         this.clearTween();
         this._disappearTween = new Tween(DISAPPEAR_TIME,this.line,{"scaleY":DISAPPEAR_SCALE},{"ease":Regular.easeOut});
      }
      
      public final function dispose() : void
      {
         this.clearTween();
         this.fx.addFrameScript(this.fx.totalFrames,null);
         this.fx = null;
         this.line = null;
      }
      
      private function onFxComplete() : void
      {
         this.fx.stop();
         dispatchEvent(new MessageViewEvent(MessageViewEvent.REWARD_ANIMATION_COMPLETE,Values.EMPTY_STR,true));
      }
      
      private function clearTween() : void
      {
         if(this._disappearTween)
         {
            this._disappearTween.paused = true;
            this._disappearTween.dispose();
            this._disappearTween = null;
         }
      }
   }
}
