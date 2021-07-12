package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;
   import net.wg.gui.components.controls.StatusIndicatorAnim;
   import scaleform.clik.constants.InvalidationType;
   
   public class StatusDeltaIndicatorAnim extends StatusIndicatorAnim implements IProgressBarAnim
   {
      
      private static const PADDING:int = 11;
      
      private static const HUNDRED_PERCENT:int = 100;
      
      private static const CORRECTION:int = 1;
      
      private static const ANIM_STEP_TIME:int = 10;
      
      private static const NUM_CYCLES:int = 40;
      
      protected static const INVALID_POSITION:String = "invalidPosition";
       
      
      public var commonBar:Sprite = null;
      
      public var plusBar:Sprite = null;
      
      public var optionalBar:Sprite = null;
      
      public var minusBar:Sprite = null;
      
      public var marker:Sprite = null;
      
      private var _endDelta:Number = 0;
      
      private var _delta:Number = 0;
      
      private var _markerValue:Number = 0;
      
      private var _endMarkerValue:Number = 0;
      
      private var _deltaStepsNumber:Number = 0;
      
      private var _deltaStep:Number = 0;
      
      private var _markerStepsNumber:int = 0;
      
      private var _markerStep:int = 0;
      
      private var _onePercent:Number = 0;
      
      private var _onePercentWidth:Number = 0;
      
      private var _isOptional:Boolean = false;
      
      public function StatusDeltaIndicatorAnim()
      {
         super();
      }
      
      override protected function animIndicator() : void
      {
         super.animIndicator();
         this.animMarker();
         --this._deltaStepsNumber;
         if(this._delta - this._endDelta >= 0)
         {
            this._deltaStepsNumber = 0;
            this._delta = this._endDelta;
         }
         else if(this._deltaStepsNumber == 0)
         {
            this._delta = this._endDelta;
            this.stopAnimation();
         }
         else
         {
            this._delta += this._deltaStep;
         }
         invalidate(INVALID_POSITION);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            invalidate(INVALID_POSITION);
         }
         if(isInvalid(INVALID_POSITION))
         {
            this.updatePosition();
         }
      }
      
      override protected function updatePosition() : void
      {
         this._onePercentWidth = (width / scaleX - (PADDING << 1)) / HUNDRED_PERCENT;
         this.commonBar.width = _value / this._onePercent * this._onePercentWidth ^ 0;
         this.marker.visible = this._markerValue > 0;
         if(this._markerValue > 0)
         {
            this.marker.x = (this._markerValue / this._onePercent * this._onePercentWidth ^ 0) + PADDING;
         }
         if(this._isOptional && this._delta > 0)
         {
            this.layoutBar(this.optionalBar,this._delta,false);
            this.minusBar.visible = false;
            this.plusBar.visible = false;
            this.optionalBar.visible = true;
         }
         else if(this._delta > 0)
         {
            this.layoutBar(this.plusBar,this._delta,false);
            this.minusBar.visible = false;
            this.optionalBar.visible = false;
            this.plusBar.visible = true;
         }
         else if(this._delta < 0)
         {
            this.layoutBar(this.minusBar,-this._delta,true);
            this.minusBar.visible = true;
            this.plusBar.visible = false;
            this.optionalBar.visible = false;
         }
         else
         {
            this.minusBar.visible = false;
            this.plusBar.visible = false;
            this.optionalBar.visible = false;
         }
      }
      
      override protected function stopAnimation() : void
      {
         if(this._delta == this._endDelta && this._markerValue == this._endMarkerValue)
         {
            super.stopAnimation();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.minusBar.visible = false;
         this.plusBar.visible = false;
         this.optionalBar.visible = false;
         this.marker.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.commonBar = null;
         this.plusBar = null;
         this.minusBar = null;
         this.optionalBar = null;
         this.marker = null;
         super.onDispose();
      }
      
      override protected function getAnimStepTime() : int
      {
         return ANIM_STEP_TIME;
      }
      
      override protected function getNumCycles() : int
      {
         return NUM_CYCLES;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:StatusDeltaIndicatorVO = StatusDeltaIndicatorVO(param1);
         minimum = _loc2_.minValue;
         maximum = _loc2_.maxValue;
         useAnim = _loc2_.useAnim;
         value = _loc2_.value;
         this.delta = _loc2_.delta;
         this.markerValue = _loc2_.markerValue;
         this._isOptional = _loc2_.isOptional;
         this._onePercent = (_maximum - _minimum) / HUNDRED_PERCENT;
         invalidate(INVALID_POSITION);
      }
      
      private function layoutBar(param1:Sprite, param2:Number, param3:Boolean) : void
      {
         param1.width = param2 / this._onePercent * this._onePercentWidth - CORRECTION;
         param1.width = param1.width > CORRECTION ? Number(param1.width) : Number(CORRECTION << 1);
         if(param3)
         {
            param1.x = this.marker.x - param1.width ^ 0;
         }
         else
         {
            param1.x = (this.commonBar.x + this.commonBar.width ^ 0) + CORRECTION;
         }
      }
      
      private function animMarker() : void
      {
         --this._markerStepsNumber;
         if(this._markerValue - this._endMarkerValue == 0)
         {
            this._markerStepsNumber = 0;
            this._markerValue = this._endMarkerValue;
            return;
         }
         if(this._markerStepsNumber == 0)
         {
            this._markerValue = this._endMarkerValue;
            this.stopAnimation();
         }
         else
         {
            this._markerValue += this._markerStep;
         }
      }
      
      private function calculateDeltaSteps() : void
      {
         var _loc1_:Number = Math.max(this._delta,this._endDelta);
         var _loc2_:Number = Math.min(this._delta,this._endDelta);
         var _loc3_:Number = _loc1_ - _loc2_;
         this._deltaStep = Math.ceil(_loc3_ / numCycles);
         this._deltaStepsNumber = _loc3_ / this._deltaStep;
         if(this._endDelta < this._delta)
         {
            this._deltaStep *= -1;
         }
      }
      
      private function calculateStockSteps() : void
      {
         var _loc1_:Number = Math.max(this._markerValue,this._endMarkerValue);
         var _loc2_:Number = Math.min(this._markerValue,this._endMarkerValue);
         var _loc3_:Number = _loc1_ - _loc2_;
         this._markerStep = Math.ceil(_loc3_ / numCycles);
         this._markerStepsNumber = _loc3_ / this._markerStep;
         if(this._endMarkerValue < this._markerValue)
         {
            this._markerStep *= -1;
         }
      }
      
      public function get delta() : Number
      {
         return this._delta;
      }
      
      public function set delta(param1:Number) : void
      {
         if(this._delta == param1)
         {
            return;
         }
         if(useAnim)
         {
            this._endDelta = param1;
            this.calculateDeltaSteps();
            invalidate(INVALID_ANIMATE);
         }
         else
         {
            this._delta = this._endDelta = param1;
            invalidate(INVALID_POSITION);
         }
      }
      
      public function get markerValue() : Number
      {
         return this._markerValue;
      }
      
      public function set markerValue(param1:Number) : void
      {
         if(this._markerValue == param1)
         {
            this._endMarkerValue = param1;
            return;
         }
         if(useAnim)
         {
            this._endMarkerValue = param1;
            this.calculateStockSteps();
            invalidate(INVALID_ANIMATE);
         }
         else
         {
            this._markerValue = param1;
            invalidate(INVALID_POSITION);
         }
      }
   }
}
