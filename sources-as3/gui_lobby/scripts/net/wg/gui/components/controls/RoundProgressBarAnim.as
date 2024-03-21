package net.wg.gui.components.controls
{
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RoundProgressBarAnim extends UIComponentEx implements IProgressBarAnim
   {
      
      private static const HUNDRED_PERCENT:int = 100;
      
      private static const FIRST_FRAME:int = 1;
      
      private static const ANIM_TIME_MSEC:int = 2000;
       
      
      private var _maximum:int = 0;
      
      private var _minimum:int = 0;
      
      private var _value:int = 0;
      
      private var _useAnim:Boolean = false;
      
      public function RoundProgressBarAnim()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._value > this._minimum && this._value <= this._maximum)
            {
               _loc1_ = 0;
               if(this._value == this._maximum)
               {
                  _loc1_ = totalFrames;
               }
               else
               {
                  _loc1_ = (this._value - this._minimum) / (this._maximum - this._minimum) * HUNDRED_PERCENT + 1 | 0;
               }
               if(this._useAnim)
               {
                  App.utils.scheduler.cancelTask(this.nextFrameTick);
                  gotoAndStop(FIRST_FRAME);
                  App.utils.scheduler.scheduleRepeatableTask(this.nextFrameTick,ANIM_TIME_MSEC / totalFrames,_loc1_);
               }
               else
               {
                  gotoAndStop(_loc1_);
               }
            }
            else
            {
               App.utils.scheduler.cancelTask(this.nextFrameTick);
               gotoAndStop(FIRST_FRAME);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.nextFrameTick);
         super.onDispose();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:ProgressBarAnimVO = ProgressBarAnimVO(param1);
         this._minimum = _loc2_.minValue;
         this._maximum = _loc2_.maxValue;
         this._useAnim = _loc2_.useAnim;
         this._value = _loc2_.value;
         invalidateData();
      }
      
      private function nextFrameTick() : void
      {
         gotoAndStop(currentFrame + 1);
      }
      
      public function get minimum() : Number
      {
         return this._minimum;
      }
      
      public function set minimum(param1:Number) : void
      {
         if(this._minimum != param1)
         {
            this._minimum = param1;
            invalidateData();
         }
      }
      
      public function get maximum() : Number
      {
         return this._maximum;
      }
      
      public function set maximum(param1:Number) : void
      {
         if(this._maximum != param1)
         {
            this._maximum = param1;
            invalidateData();
         }
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         if(this._value != param1)
         {
            this._value = param1;
            invalidateData();
         }
      }
      
      public function get useAnim() : Boolean
      {
         return this._useAnim;
      }
      
      public function set useAnim(param1:Boolean) : void
      {
         if(this._useAnim != param1)
         {
            this._useAnim = param1;
            invalidateData();
         }
      }
   }
}
