package net.wg.white_tiger.gui.battle.views.shared
{
   import flash.events.Event;
   import flash.utils.getTimer;
   import net.wg.data.constants.Time;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.white_tiger.gui.battle.views.shared.interfaces.ITimerAnimation;
   
   public class TimerAnimHelper implements IDisposable
   {
       
      
      private var _animation:ITimerAnimation = null;
      
      private var _disposed:Boolean = false;
      
      private var _timeLeft:Number = 0;
      
      private var _timeTotal:Number = 0;
      
      private var _lastUpdateTime:Number = 0;
      
      private var _replaySpeed:Number = 1;
      
      private var _isPlaying:Boolean = false;
      
      private var _finishCallback:Function = null;
      
      public function TimerAnimHelper(param1:ITimerAnimation)
      {
         super();
         this._animation = param1;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._animation.removeEventListener(Event.ENTER_FRAME,this.onEventEnterFrameHandler);
         this._animation = null;
         this._finishCallback = null;
      }
      
      public function getTimeFormatted(param1:int) : String
      {
         var _loc2_:int = Math.round(param1 / Time.MILLISECOND_IN_SECOND);
         var _loc3_:int = _loc2_ / Time.SECONDS_IN_MINUTE;
         _loc2_ %= Time.SECONDS_IN_MINUTE;
         return (_loc3_ < 10 ? "0" + _loc3_ : _loc3_) + ":" + (_loc2_ < 10 ? "0" + _loc2_ : _loc2_);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setTime(param1:Number, param2:Number, param3:Number, param4:Boolean = true) : void
      {
         this._timeLeft = param1 * Time.MILLISECOND_IN_SECOND;
         this._timeTotal = param2 * Time.MILLISECOND_IN_SECOND;
         this._replaySpeed = param3;
         this._lastUpdateTime = getTimer();
         this.isPlaying = param4;
      }
      
      private function updateTime() : void
      {
         var _loc1_:int = getTimer();
         this._timeLeft -= this._replaySpeed * (_loc1_ - this._lastUpdateTime);
         if(this._timeLeft <= 0)
         {
            this.isPlaying = false;
            this._timeLeft = 0;
            if(this._finishCallback != null)
            {
               this._finishCallback();
            }
         }
         this._lastUpdateTime = _loc1_;
         var _loc2_:Number = this._timeTotal > 0 ? Number((this._timeTotal - this._timeLeft) / this._timeTotal) : Number(0);
         this._animation.updateProgress(_loc2_,this._timeLeft);
      }
      
      public function set finishCallback(param1:Function) : void
      {
         this._finishCallback = param1;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         if(this._isPlaying == param1)
         {
            return;
         }
         this._isPlaying = param1;
         if(this._isPlaying)
         {
            this._animation.addEventListener(Event.ENTER_FRAME,this.onEventEnterFrameHandler);
         }
         else
         {
            this._animation.removeEventListener(Event.ENTER_FRAME,this.onEventEnterFrameHandler);
         }
      }
      
      private function onEventEnterFrameHandler(param1:Event) : void
      {
         this.updateTime();
      }
   }
}
