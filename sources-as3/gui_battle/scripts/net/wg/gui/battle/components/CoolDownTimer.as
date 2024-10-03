package net.wg.gui.battle.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IScheduler;
   
   public class CoolDownTimer implements IDisposable
   {
       
      
      private var _reversed:Boolean = false;
      
      private var _totalFrames:uint;
      
      private var _currentFrame:uint;
      
      private var _progressValues:Vector.<int> = null;
      
      private var _context:MovieClip = null;
      
      private var _coolDownHandler:ICoolDownCompleteHandler = null;
      
      private var _scheduler:IScheduler;
      
      private var _disposed:Boolean = false;
      
      public function CoolDownTimer(param1:MovieClip)
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._context = param1;
         this._context.stop();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._scheduler.cancelTask(this.run);
         this._scheduler = null;
         this._context.stop();
         this._context = null;
         this._progressValues = null;
         this._coolDownHandler = null;
      }
      
      public function end() : void
      {
         this._scheduler.cancelTask(this.run);
      }
      
      public function moveToFrame(param1:int) : void
      {
         if(param1 >= 0 && param1 < this._progressValues.length)
         {
            this._context.gotoAndStop(this._progressValues[param1]);
         }
      }
      
      public function restartFromCurrentFrame(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         this.end();
         var _loc2_:int = (!!this._reversed ? this._currentFrame : this._totalFrames - this._currentFrame) + 1;
         if(_loc2_ > 0)
         {
            _loc3_ = param1 * Time.MILLISECOND_IN_SECOND / _loc2_;
            this._scheduler.scheduleRepeatableTask(this.run,_loc3_,int.MAX_VALUE);
         }
         this.run();
      }
      
      public function setFrames(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         this._totalFrames = param2 - param1;
         this._progressValues = new Vector.<int>(this._totalFrames + 1,true);
         var _loc4_:uint = 0;
         while(_loc4_ <= this._totalFrames)
         {
            this._progressValues[_loc4_] = param1 + _loc4_;
            _loc4_++;
         }
         if(param3)
         {
            this._progressValues.reverse();
         }
      }
      
      public function setPositionAsPercent(param1:Number) : void
      {
         this.end();
         this._currentFrame = Math.floor(this._progressValues.length * 0.01 * param1);
         this.moveToFrame(this._currentFrame);
      }
      
      public function step(param1:ICoolDownCompleteHandler, param2:int, param3:Number, param4:Boolean = false, param5:Boolean = false) : void
      {
         this._reversed = param4;
         if(param5)
         {
            this._currentFrame = !!this._reversed ? uint(this._totalFrames) : uint(0);
         }
         else
         {
            this._currentFrame = param2;
         }
         this._coolDownHandler = param1;
         this.run();
      }
      
      public function start(param1:Number, param2:ICoolDownCompleteHandler, param3:int, param4:Number, param5:Boolean = false, param6:Boolean = false) : void
      {
         var _loc8_:Number = NaN;
         this.end();
         this._reversed = param5;
         if(param6)
         {
            this._currentFrame = !!this._reversed ? uint(this._totalFrames) : uint(0);
         }
         else
         {
            this._currentFrame = param3;
         }
         this._coolDownHandler = param2;
         var _loc7_:int = (!!this._reversed ? this._currentFrame : this._totalFrames - this._currentFrame) + 1;
         if(_loc7_ > 0)
         {
            _loc8_ = param1 * Time.MILLISECOND_IN_SECOND / _loc7_ / param4;
            this._scheduler.scheduleRepeatableTask(this.run,_loc8_,int.MAX_VALUE);
         }
         this.run();
      }
      
      private function run() : void
      {
         var _loc1_:Boolean = !!this._reversed ? Boolean(this._currentFrame < 0) : Boolean(this._currentFrame >= this._progressValues.length);
         if(_loc1_)
         {
            this.end();
            this._coolDownHandler.onCoolDownComplete();
            return;
         }
         this.moveToFrame(this._currentFrame);
         if(this._reversed)
         {
            --this._currentFrame;
         }
         else
         {
            ++this._currentFrame;
         }
      }
      
      public function get currentFrame() : int
      {
         return this._currentFrame;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
