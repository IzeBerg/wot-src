package net.wg.gui.battle.views.battleLevelPanel
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import net.wg.data.constants.Values;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IFramesHelper;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   
   public class ProgressDeltaAnimation extends MovieClip implements IDisposable
   {
      
      private static const MIN_WIDTH:uint = 1;
      
      private static const TWEEN_DURATION:int = 350;
      
      private static const TWEEN_DELAY:int = 175;
      
      private static const FADE_OUT_START_LABEL:String = "fadeOutStart";
      
      private static const FADE_OUT_END_LABEL:String = "fadeOutEnd";
       
      
      public var onFadeInWidthComplete:Function = null;
      
      public var onFadeOutComplete:Function = null;
      
      private var _frameHelper:IFramesHelper = null;
      
      private var _tween:Tween = null;
      
      private var _scheduler:IScheduler;
      
      private var _isActive:Boolean = false;
      
      private var _isFadeOutActive:Boolean = false;
      
      public function ProgressDeltaAnimation()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this.initFramesScript();
         gotoAndStop(FADE_OUT_END_LABEL);
      }
      
      public final function dispose() : void
      {
         stop();
         this.cancelFadeOutTask();
         this.clearTween();
         this._scheduler = null;
         this.onFadeInWidthComplete = null;
         this.onFadeOutComplete = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.onFadeInWidthComplete = null;
         this.onFadeOutComplete = null;
      }
      
      public function reset() : void
      {
         width = Values.ZERO;
         stop();
         this.cancelFadeOutTask();
         this.clearTween();
         this._isActive = false;
      }
      
      public function pause() : void
      {
         if(this._isActive)
         {
            if(this._isFadeOutActive)
            {
               stop();
            }
            else
            {
               this._tween.paused = true;
            }
         }
      }
      
      public function unpause() : void
      {
         if(this._isActive)
         {
            if(this._isFadeOutActive)
            {
               play();
            }
            else
            {
               this._tween.paused = false;
            }
         }
      }
      
      public function fadeInWidth(param1:int) : void
      {
         width = Values.ZERO;
         this._isActive = true;
         this._isFadeOutActive = false;
         this.cancelFadeOutTask();
         this.clearTween();
         if(param1 > MIN_WIDTH)
         {
            gotoAndStop(FADE_OUT_START_LABEL);
            this._tween = new Tween(TWEEN_DURATION,this,{"width":param1},{"onComplete":this.onFadeInWidthTweenComplete});
         }
         else if(param1 == MIN_WIDTH)
         {
            gotoAndStop(FADE_OUT_START_LABEL);
            this.onFadeInWidthTweenComplete();
         }
         else
         {
            gotoAndStop(FADE_OUT_END_LABEL);
            this.onFadeInWidthCompleteCallback();
            this.onFadeOutEnd();
         }
      }
      
      public function fadeOut() : void
      {
         this._isActive = true;
         this._isFadeOutActive = true;
         this.cancelFadeOutTask();
         this.clearTween();
         gotoAndPlay(FADE_OUT_START_LABEL);
      }
      
      private function initFramesScript() : void
      {
         var _loc3_:FrameLabel = null;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FADE_OUT_END_LABEL)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutEnd);
               break;
            }
            _loc4_++;
         }
      }
      
      private function cancelFadeOutTask() : void
      {
         this._scheduler.cancelTask(this.fadeOutTask);
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onFadeInWidthTweenComplete() : void
      {
         this._scheduler.scheduleTask(this.fadeOutTask,TWEEN_DELAY);
      }
      
      private function onFadeInWidthCompleteCallback() : void
      {
         if(this.onFadeInWidthComplete != null)
         {
            this.onFadeInWidthComplete();
         }
      }
      
      private function fadeOutTask() : void
      {
         this.onFadeInWidthCompleteCallback();
         this.fadeOut();
      }
      
      private function onFadeOutEnd() : void
      {
         stop();
         this._isActive = false;
         this._isFadeOutActive = false;
         if(this.onFadeOutComplete != null)
         {
            this.onFadeOutComplete();
         }
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
   }
}
