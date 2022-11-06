package net.wg.gui.components.controls
{
   import net.wg.utils.IScheduler;
   
   public class StatusIndicatorAnim extends StatusIndicatorEx
   {
      
      private static const ANIM_STEP_TIME:int = 40;
      
      private static const NUM_CYCLES:int = 20;
      
      protected static const INVALID_ANIMATE:String = "invalidAnimate";
       
      
      private var _curCycle:int = 0;
      
      private var _step:int = 0;
      
      private var _scheduler:IScheduler = null;
      
      private var _endValue:Number = 0;
      
      private var _useAnim:Boolean = false;
      
      private var _callback:Function = null;
      
      private var _animStepTime:int = 40;
      
      private var _numCycles:int = 20;
      
      public function StatusIndicatorAnim()
      {
         super();
         this._scheduler = App.utils.scheduler;
         this._animStepTime = this.getAnimStepTime();
         this._numCycles = this.getNumCycles();
      }
      
      override protected function updatePosition() : void
      {
         super.updatePosition();
         if(this.callback != null)
         {
            this.callback.call(null);
         }
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.animIndicator);
         this._scheduler = null;
         this._callback = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_ANIMATE))
         {
            this.animUpdatePosition();
         }
      }
      
      protected function animIndicator() : void
      {
         --this._curCycle;
         if(this._step < 0 && _value <= this._endValue)
         {
            this._curCycle = 0;
         }
         if(this._step >= 0 && _value >= this._endValue)
         {
            this._curCycle = 0;
         }
         if(this._curCycle == 0)
         {
            _value = this._endValue;
            this.stopAnimation();
         }
         else
         {
            _value += this._step;
         }
         this.updatePosition();
      }
      
      protected function stopAnimation() : void
      {
         if(_value == this._endValue && this._scheduler)
         {
            this._scheduler.cancelTask(this.animIndicator);
         }
      }
      
      protected function getAnimStepTime() : int
      {
         return ANIM_STEP_TIME;
      }
      
      protected function getNumCycles() : int
      {
         return NUM_CYCLES;
      }
      
      private function calculateValueSteps() : void
      {
         var _loc1_:Number = Math.max(_value,this._endValue);
         var _loc2_:Number = Math.min(_value,this._endValue);
         var _loc3_:Number = _loc1_ - _loc2_;
         this._step = Math.ceil(_loc3_ / this._numCycles);
         this._curCycle = this._numCycles;
         if(this._endValue < _value)
         {
            this._step *= -1;
         }
      }
      
      private function animUpdatePosition() : void
      {
         this._scheduler.cancelTask(this.animIndicator);
         if(this._useAnim)
         {
            this._scheduler.scheduleRepeatableTask(this.animIndicator,this._animStepTime,this._numCycles);
         }
         else
         {
            this.animIndicator();
         }
      }
      
      override public function set value(param1:Number) : void
      {
         if(_value == param1)
         {
            return;
         }
         this._endValue = param1;
         if(this._useAnim)
         {
            this.calculateValueSteps();
            invalidate(INVALID_ANIMATE);
         }
         else
         {
            _value = param1;
            invalidate(INVALID_ANIMATE);
         }
      }
      
      public function get useAnim() : Boolean
      {
         return this._useAnim;
      }
      
      public function set useAnim(param1:Boolean) : void
      {
         this._useAnim = param1;
      }
      
      public function get callback() : Function
      {
         return this._callback;
      }
      
      public function set callback(param1:Function) : void
      {
         this._callback = param1;
      }
      
      public function get numCycles() : int
      {
         return this._numCycles;
      }
   }
}
