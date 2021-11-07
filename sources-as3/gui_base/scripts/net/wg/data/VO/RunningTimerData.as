package net.wg.data.VO
{
   import flash.utils.getTimer;
   
   public class RunningTimerData
   {
      
      private static const DEFAULT_TOTAL_TIME:int = -1;
       
      
      private var _startTime:Number;
      
      private var _totalTime:Number = -1;
      
      private var _elapsedTime:Number;
      
      private var _isRunning:Boolean;
      
      private var _speedFactor:Number = 1;
      
      public function RunningTimerData()
      {
         super();
      }
      
      public function complete() : void
      {
         this._elapsedTime = this._totalTime;
         this._isRunning = false;
      }
      
      public function get isRunning() : Boolean
      {
         return this._isRunning;
      }
      
      public function reset() : void
      {
         this._totalTime = DEFAULT_TOTAL_TIME;
         this._startTime = 0;
         this._elapsedTime = 0;
         this._isRunning = false;
      }
      
      public function setSpeed(param1:Number) : void
      {
         this._speedFactor = param1;
         if(this._isRunning && this._speedFactor > 0)
         {
            this._startTime = getTimer() - this._elapsedTime / this._speedFactor;
         }
      }
      
      public function stop() : void
      {
         this._isRunning = false;
      }
      
      public function update(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._totalTime = param2;
         this._isRunning = param3;
         this._elapsedTime = this._totalTime - param1;
         this._startTime = getTimer() - this._elapsedTime / this._speedFactor;
      }
      
      public function get elapsedPercent() : Number
      {
         if(this._totalTime == DEFAULT_TOTAL_TIME)
         {
            return 0;
         }
         if(this._isRunning)
         {
            this._elapsedTime = (getTimer() - this._startTime) * this._speedFactor;
         }
         return Math.min(this._elapsedTime / this._totalTime,1);
      }
      
      public function get timeLeft() : Number
      {
         return (1 - this.elapsedPercent) * this._totalTime;
      }
      
      public function get totalTime() : Number
      {
         if(this._totalTime == DEFAULT_TOTAL_TIME)
         {
            return 0;
         }
         return this._totalTime;
      }
   }
}
