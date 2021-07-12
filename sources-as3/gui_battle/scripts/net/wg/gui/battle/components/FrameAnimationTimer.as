package net.wg.gui.battle.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.utils.IDateTime;
   import net.wg.utils.IScheduler;
   
   public class FrameAnimationTimer extends BattleUIComponent
   {
      
      private static const HIDE_TIMER_STEPS:int = 101;
      
      private static const HIDE_TIMER_INTERVAL:int = 30;
       
      
      protected var lastStrTime:String = "";
      
      private var _isActive:Boolean = false;
      
      private var _totalFrames:int = -1;
      
      private var _lastFrameID:int = -1;
      
      private var _totalTime:int = -1;
      
      private var _currentTime:Number = -1;
      
      private var _speed:Number = 1;
      
      private var _progressValues:Vector.<int> = null;
      
      private var _timerTextValues:Vector.<String> = null;
      
      private var _lastTimerIndex:int = -1;
      
      private var _currentTimerIndex:int = -1;
      
      private var _intervalTime:int = -1;
      
      private var _isUpdateProgressValues:Boolean = false;
      
      private var _isUpdateTextValues:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _dateTime:IDateTime;
      
      public function FrameAnimationTimer()
      {
         this._scheduler = App.utils.scheduler;
         this._dateTime = App.utils.dateTime;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.pauseRadialTimer();
         this.pauseHideTimer();
         this._scheduler = null;
         this._dateTime = null;
         this.cleanProgressValues();
         this.cleanTimerTextValues();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.setTimerTimeString();
         }
      }
      
      public function setSpeed(param1:Number) : void
      {
         if(this._speed != param1)
         {
            this.pauseRadialTimer();
            this._speed = param1;
            this.recalculateIntervalTimer();
            if(this._isActive)
            {
               this.runInterval();
            }
         }
      }
      
      public function updateRadialTimer(param1:int, param2:Number) : void
      {
         this.pauseHideTimer();
         this.pauseRadialTimer();
         if(this._totalTime != param1)
         {
            this._totalTime = param1;
            this.recalculateTimeRelatedValues();
            this.recalculateIntervalTimer();
         }
         this._currentTime = param2;
         this.updateCurrentTime();
         this.runInterval();
      }
      
      protected function init(param1:Boolean = false, param2:Boolean = false) : void
      {
         this._isUpdateProgressValues = param1;
         this._isUpdateTextValues = param2;
         this._totalFrames = this.getEndFrame() - this.getStartFrame();
         if(this._isUpdateProgressValues)
         {
            this.cleanProgressValues();
            this._progressValues = new Vector.<int>(this._totalFrames + 1,true);
         }
         if(this._isUpdateTextValues)
         {
            this.cleanTimerTextValues();
            this._timerTextValues = new Vector.<String>(this._totalFrames + 1,true);
         }
         this._lastTimerIndex = this._progressValues.length - 1;
      }
      
      protected function getStartFrame() : int
      {
         return Values.DEFAULT_INT;
      }
      
      protected function getEndFrame() : int
      {
         return Values.DEFAULT_INT;
      }
      
      protected function pauseRadialTimer() : void
      {
         this._scheduler.cancelTask(this.onIntervalUpdateHandler);
      }
      
      protected function pauseHideTimer() : void
      {
         this._scheduler.cancelTask(this.onIntervalHideUpdateHandler);
      }
      
      protected function setTimerTFText(param1:String) : void
      {
         if(this.lastStrTime != param1)
         {
            this.setTTFText(param1);
            this.invokeAdditionalActionOnIntervalUpdate();
         }
      }
      
      protected function setTTFText(param1:String) : void
      {
         this.lastStrTime = param1;
         invalidate(InvalidationType.DATA);
      }
      
      protected function getProgressBarMc() : MovieClip
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getTimerTF() : TextField
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function resetAnimState() : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function onIntervalHideUpdateHandler() : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getTimeFormatted(param1:int) : String
      {
         return this._dateTime.formatSecondsToString(param1);
      }
      
      protected function setTimerTimeString() : void
      {
         this.getTimerTF().text = this.lastStrTime;
      }
      
      protected function recalculateTimeRelatedValues() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this._totalTime >= 0)
         {
            _loc1_ = this.getStartFrame();
            _loc2_ = this._totalTime / this._totalFrames;
            _loc3_ = 0;
            if(this._isUpdateProgressValues && this._isUpdateTextValues)
            {
               _loc3_ = 0;
               while(_loc3_ <= this._totalFrames)
               {
                  this._progressValues[_loc3_] = _loc1_ + _loc3_;
                  this._timerTextValues[_loc3_] = this.getTimeFormatted(Math.ceil(this._totalTime - _loc3_ * _loc2_));
                  _loc3_++;
               }
            }
            else if(this._isUpdateProgressValues)
            {
               _loc3_ = 0;
               while(_loc3_ <= this._totalFrames)
               {
                  this._progressValues[_loc3_] = _loc1_ + _loc3_;
                  _loc3_++;
               }
            }
            else if(this._isUpdateTextValues)
            {
               _loc3_ = 0;
               while(_loc3_ <= this._totalFrames)
               {
                  this._timerTextValues[_loc3_] = this.getTimeFormatted(Math.ceil(this._totalTime - _loc3_ * _loc2_));
                  _loc3_++;
               }
            }
         }
         else
         {
            if(this._isUpdateProgressValues)
            {
               this.cleanProgressValues();
               this._progressValues = new Vector.<int>(this._totalFrames + 1,true);
            }
            if(this._isUpdateTextValues)
            {
               this.cleanTimerTextValues();
               this._timerTextValues = new Vector.<String>(this._totalFrames + 1,true);
            }
         }
      }
      
      private function cleanTimerTextValues() : void
      {
         if(this._timerTextValues)
         {
            this._timerTextValues.fixed = false;
            this._timerTextValues.splice(0,this._timerTextValues.length);
            this._timerTextValues = null;
         }
      }
      
      private function cleanProgressValues() : void
      {
         if(this._progressValues)
         {
            this._progressValues.fixed = false;
            this._progressValues.splice(0,this._progressValues.length);
            this._progressValues = null;
         }
      }
      
      private function recalculateIntervalTimer() : void
      {
         if(this._totalTime >= 0)
         {
            this._intervalTime = Time.MILLISECOND_IN_SECOND * this._totalTime / this._totalFrames / this._speed;
         }
         else
         {
            this._intervalTime = Values.DEFAULT_INT;
         }
      }
      
      private function updateCurrentTime() : void
      {
         this._currentTimerIndex = this._currentTime * this._totalFrames / this._totalTime;
         if(this._currentTimerIndex >= this._progressValues.length)
         {
            this._currentTimerIndex = this._progressValues.length - 1;
         }
         if(this._isUpdateProgressValues)
         {
            if(this._currentTimerIndex >= this._progressValues.length)
            {
               this._currentTimerIndex = this._progressValues.length - 1;
            }
            this.setProgressMcPosition(this._progressValues[this._currentTimerIndex]);
         }
         if(this._isUpdateTextValues)
         {
            if(this._currentTimerIndex >= this._timerTextValues.length)
            {
               this._currentTimerIndex = this._timerTextValues.length - 1;
            }
            this.setTimerTFText(this._timerTextValues[this._currentTimerIndex]);
         }
      }
      
      private function runInterval() : void
      {
         if(this._intervalTime > 0)
         {
            this._scheduler.scheduleRepeatableTask(this.onIntervalUpdateHandler,this._intervalTime,this._totalFrames);
         }
      }
      
      private function onIntervalUpdateHandler() : void
      {
         if(this._currentTimerIndex == this._lastTimerIndex)
         {
            this.pauseRadialTimer();
            this.resetAnimState();
            stop();
            this._scheduler.scheduleRepeatableTask(this.onIntervalHideUpdateHandler,HIDE_TIMER_INTERVAL,HIDE_TIMER_STEPS);
         }
         else
         {
            ++this._currentTimerIndex;
            this._currentTime = this._currentTimerIndex * this._totalTime / this._totalFrames;
            if(this._isUpdateProgressValues)
            {
               this.setProgressMcPosition(this._progressValues[this._currentTimerIndex]);
            }
            if(this._isUpdateTextValues)
            {
               this.setTimerTFText(this._timerTextValues[this._currentTimerIndex]);
            }
         }
      }
      
      private function setProgressMcPosition(param1:int) : void
      {
         if(this._lastFrameID != param1)
         {
            this._lastFrameID = param1;
            this.getProgressBarMc().gotoAndStop(this._lastFrameID);
         }
      }
      
      public function get isActive() : Boolean
      {
         return this._isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         this._isActive = param1;
      }
   }
}
