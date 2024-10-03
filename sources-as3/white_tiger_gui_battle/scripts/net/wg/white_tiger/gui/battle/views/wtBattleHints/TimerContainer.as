package net.wg.white_tiger.gui.battle.views.wtBattleHints
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.motion.Tween;
   
   public class TimerContainer extends MovieClip implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _totalTime:int = 0;
      
      private var _currentTime:int = 0;
      
      private var _timerTween:Tween = null;
      
      public function TimerContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearTweens();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function startTimer(param1:int) : void
      {
         if(param1 > 0)
         {
            this._totalTime = param1;
            this._currentTime = param1;
            this.clearTweens();
            this._timerTween = new Tween(this._totalTime,this,{"currentTime":0},{"onComplete":this.inTimerTweenComplete});
         }
      }
      
      public function stopTimer() : void
      {
         this.clearTweens();
      }
      
      private function inTimerTweenComplete(param1:Tween) : void
      {
         this.clearTweens();
      }
      
      private function clearTweens() : void
      {
         if(this._timerTween)
         {
            this._timerTween.dispose();
            this._timerTween = null;
         }
      }
      
      public function get currentTime() : int
      {
         return this._currentTime;
      }
      
      public function set currentTime(param1:int) : void
      {
         this._currentTime = param1;
         var _loc2_:int = this.totalFrames * (this._totalTime > 0 ? this._currentTime / this._totalTime : 1) | 0;
         if(_loc2_ != this.currentFrame)
         {
            this.gotoAndStop(_loc2_);
         }
      }
   }
}
