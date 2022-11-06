package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.events.RangeSliderEvent;
   import net.wg.gui.components.controls.interfaces.ISliderKeyPoint;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.SliderEvent;
   
   [InspectableList("divisionLabelPostfix")]
   public class RangeSlider extends Slider
   {
      
      private static const INVALID_MODE:String = "invalidMode";
      
      private static const INVALID_RANGE:String = "invalidRange";
      
      private static const INVALID_DIVISION_SCALE:String = "invalidDivisionScale";
      
      private static const INVALID_DIVISION_POINT_RENDERER:String = "invalidDivisionPointRenderer";
      
      private static const DEFAULT_PROGRESS_MASK_OFFSET:int = 4;
      
      private static const DEFAULT_LEFT_PROGRESS_MASK_OFFSET:int = -6;
      
      private static const DISABLED_ALPHA_VALUE:Number = 0.5;
      
      private static const ENABLE_ALPHA_VALUE:int = 1;
      
      private static const RENDERER_LINE_SIZE:int = 1;
      
      private static const LEFT_PROGRESS_MASK_NAME:String = "left_progress_mask";
      
      private static const RIGHT_PROGRESS_MASK_NAME:String = "progress_mask";
       
      
      public var leftThumb:Button = null;
      
      public var rightThumb:Button = null;
      
      public var divisionScaleContainer:Sprite = null;
      
      public var line:MovieClip = null;
      
      private var _leftProgressMask:MovieClip = null;
      
      private var _rightProgressMask:MovieClip = null;
      
      private var _draggingThumb:Button = null;
      
      private var _progressMaskOffset:int = 4;
      
      private var _leftProgressMaskOffset:int = -6;
      
      private var _rangeMode:Boolean = true;
      
      private var _clickableRenderer:Boolean = false;
      
      private var _divisionPointRenderer:String = "SliderDivisionPointUI";
      
      private var _divisionStep:Number = 5;
      
      private var _divisionLabelStep:Number = 10;
      
      private var _minRangeDistance:Number = 0;
      
      private var _divisionLabelPostfix:String = "";
      
      private var _leftValue:Number = 0;
      
      private var _rightValue:Number = 10;
      
      private var _actualWidth:Number = 0;
      
      private var _traceWidth:Number = 0;
      
      private var _rangeMin:Number = 0;
      
      private var _rangeMax:Number = 0;
      
      private var _trackEdge:Number = 0;
      
      private var _trackHorizontalPadding:Number = 3;
      
      public function RangeSlider()
      {
         super();
         this._leftProgressMask = track[LEFT_PROGRESS_MASK_NAME];
         this._rightProgressMask = track[RIGHT_PROGRESS_MASK_NAME];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._leftProgressMask.gotoAndStop(0);
         this.leftThumb.addEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag);
         this.rightThumb.addEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag);
         this.leftThumb.doubleClickEnabled = true;
         this.rightThumb.doubleClickEnabled = true;
         this.leftThumb.addEventListener(MouseEvent.DOUBLE_CLICK,this.onLeftThumbDoubleClickHandler);
         this.rightThumb.addEventListener(MouseEvent.DOUBLE_CLICK,this.onRightThumbDoubleClickHandler);
         offsetRight = 0;
         offsetLeft = -1;
      }
      
      override protected function onDispose() : void
      {
         this.leftThumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag);
         this.rightThumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag);
         this.leftThumb.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onLeftThumbDoubleClickHandler);
         this.rightThumb.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onRightThumbDoubleClickHandler);
         this.clearDivisionScale();
         this.divisionScaleContainer = null;
         this.leftThumb.dispose();
         this.leftThumb = null;
         this.rightThumb.dispose();
         this.rightThumb = null;
         this.line = null;
         this._draggingThumb = null;
         this._leftProgressMask = null;
         this._rightProgressMask = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE,INVALID_RANGE))
         {
            this._actualWidth = width;
            if(this._rangeMax - this._rangeMin > 0)
            {
               _loc1_ = this._actualWidth;
               _loc2_ = this._rangeMax - this._rangeMin;
               _loc3_ = _loc1_ / _loc2_;
               this._traceWidth = _loc3_ * (_maximum - _minimum) + offsetRight;
               this._trackEdge = _loc3_ * (_minimum - this._rangeMin);
            }
            else
            {
               this._traceWidth = this._actualWidth;
            }
         }
         if(isInvalid(INVALID_MODE))
         {
            this.updateMode();
         }
         if(isInvalid(INVALID_DIVISION_POINT_RENDERER,INVALID_DIVISION_SCALE,INVALID_RANGE))
         {
            this.updateDivisionScale();
         }
         this.updateTrackRange();
         if(this._rangeMode)
         {
            this.updateRangeThumbs();
         }
         else
         {
            this.updateThumb();
         }
      }
      
      override protected function updateThumb() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = track.width - (this._trackHorizontalPadding << 1) - RENDERER_LINE_SIZE;
         thumb.x = (_value - _minimum) / (_maximum - _minimum) * _loc1_ - (thumb.width >> 1) + offsetLeft + this._trackEdge + this._trackHorizontalPadding ^ 0;
         if(!enabled)
         {
            this._rightProgressMask.gotoAndStop(0);
            return;
         }
         if(!_undefined)
         {
            _loc2_ = (position - _minimum) / (_maximum - _minimum);
            this._rightProgressMask.gotoAndStop(Math.round(_loc2_ * this._rightProgressMask.totalFrames));
         }
         else
         {
            this._rightProgressMask.gotoAndStop(0);
         }
      }
      
      protected function updateRangeThumbs() : void
      {
         var _loc1_:Number = track.width - (this._trackHorizontalPadding << 1) - RENDERER_LINE_SIZE;
         var _loc2_:Number = _maximum - _minimum;
         var _loc3_:Number = this._trackEdge + offsetLeft - (thumb.width >> 1);
         this.leftThumb.x = (this._leftValue - _minimum) / _loc2_ * _loc1_ + _loc3_ + this._trackHorizontalPadding ^ 0;
         this.rightThumb.x = (this._rightValue - _minimum) / _loc2_ * _loc1_ + _loc3_ + this._trackHorizontalPadding ^ 0;
         var _loc4_:Number = (this._leftValue - _minimum) / (_maximum - _minimum);
         this._leftProgressMask.gotoAndStop(Math.round(_loc4_ * this._leftProgressMask.totalFrames) + this._leftProgressMaskOffset);
         _loc4_ = (this._rightValue - _minimum) / (_maximum - _minimum);
         var _loc5_:int = Math.round(_loc4_ * this._rightProgressMask.totalFrames) + this._progressMaskOffset;
         this._rightProgressMask.gotoAndStop(_loc5_);
      }
      
      private function updateTrackRange() : void
      {
         track.width = this._traceWidth + (this._trackHorizontalPadding << 1) + RENDERER_LINE_SIZE;
         track.x = this._trackEdge - this._trackHorizontalPadding;
      }
      
      private function updateDivisionScale() : void
      {
         var _loc1_:ISliderKeyPoint = null;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         this.clearDivisionScale();
         this.line.width = width;
         var _loc2_:Number = this._actualWidth;
         if(this._rangeMax - this._rangeMin > 0)
         {
            _loc4_ = Math.abs(this._rangeMax - this._rangeMin);
            _loc5_ = this._rangeMin;
         }
         else
         {
            _loc4_ = Math.abs(_maximum - _minimum);
            _loc5_ = _minimum;
         }
         var _loc6_:Class = App.utils.classFactory.getClass(this._divisionPointRenderer);
         var _loc7_:int = _loc4_ / this._divisionStep;
         var _loc8_:Number = _loc2_ / _loc7_;
         _loc3_ = 0;
         while(_loc3_ <= _loc7_)
         {
            _loc1_ = App.utils.classFactory.getComponent(this._divisionPointRenderer,_loc6_);
            _loc9_ = _loc5_ + _loc3_ * this._divisionStep;
            _loc10_ = _loc9_ % this._divisionLabelStep == 0;
            _loc1_.x = _loc3_ * _loc8_ ^ 0;
            _loc1_.index = _loc3_;
            _loc1_.label = !!_loc10_ ? _loc9_ + this._divisionLabelPostfix : "";
            if(this._clickableRenderer && _loc9_ >= minimum && _loc9_ <= maximum)
            {
               _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.trackPress);
               _loc1_.clickable = true;
            }
            this.divisionScaleContainer.addChild(DisplayObject(_loc1_));
            _loc3_++;
         }
      }
      
      private function clearDivisionScale() : void
      {
         var _loc1_:ISliderKeyPoint = null;
         while(this.divisionScaleContainer.numChildren > 0)
         {
            _loc1_ = ISliderKeyPoint(this.divisionScaleContainer.removeChildAt(0));
            if(_loc1_.clickable)
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.trackPress);
            }
            _loc1_.dispose();
         }
      }
      
      private function updateMode() : void
      {
         thumb.visible = !this._rangeMode;
         this.leftThumb.visible = this._rangeMode;
         this.rightThumb.visible = this._rangeMode;
         this._leftProgressMask.visible = this._rangeMode;
      }
      
      private function dispatchChangeEvent() : void
      {
         dispatchEvent(new RangeSliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value,this._leftValue,this._rightValue));
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         alpha = !!param1 ? Number(ENABLE_ALPHA_VALUE) : Number(DISABLED_ALPHA_VALUE);
         mouseEnabled = param1;
         mouseChildren = param1;
         invalidate(INVALID_MODE);
         super.enabled = param1;
      }
      
      override public function set minimum(param1:Number) : void
      {
         super.minimum = param1;
         invalidate(INVALID_RANGE);
      }
      
      override public function set maximum(param1:Number) : void
      {
         super.maximum = param1;
         invalidate(INVALID_RANGE);
      }
      
      [Inspectable(defaultValue="0")]
      override public function get value() : Number
      {
         return !!this._rangeMode ? Number(this.rightValue) : Number(super.value);
      }
      
      override public function set value(param1:Number) : void
      {
         if(this._rangeMode)
         {
            this.rightValue = param1 <= this._leftValue ? Number(this._leftValue) : Number(param1);
         }
         else
         {
            super.value = param1;
         }
      }
      
      public function get progressMaskOffset() : int
      {
         return this._progressMaskOffset;
      }
      
      public function set progressMaskOffset(param1:int) : void
      {
         this._progressMaskOffset = param1;
      }
      
      public function get leftProgressMaskOffset() : int
      {
         return this._leftProgressMaskOffset;
      }
      
      public function set leftProgressMaskOffset(param1:int) : void
      {
         this._leftProgressMaskOffset = param1;
      }
      
      [Inspectable(defaultValue="true",type="Boolean")]
      public function get rangeMode() : Boolean
      {
         return this._rangeMode;
      }
      
      public function set rangeMode(param1:Boolean) : void
      {
         this._rangeMode = param1;
         invalidate(INVALID_MODE);
      }
      
      [Inspectable(defaultValue="SliderDivisionPointUI",name="divisionPointRenderer")]
      public function get divisionPointRenderer() : String
      {
         return this._divisionPointRenderer;
      }
      
      public function set divisionPointRenderer(param1:String) : void
      {
         this._divisionPointRenderer = param1;
         invalidate(INVALID_DIVISION_POINT_RENDERER);
      }
      
      [Inspectable(defaultValue="5",type="Number")]
      public function get divisionStep() : Number
      {
         return this._divisionStep;
      }
      
      public function set divisionStep(param1:Number) : void
      {
         this._divisionStep = param1;
         invalidate(INVALID_DIVISION_SCALE);
      }
      
      [Inspectable(defaultValue="10",type="Number")]
      public function get divisionLabelStep() : Number
      {
         return this._divisionLabelStep;
      }
      
      public function set divisionLabelStep(param1:Number) : void
      {
         this._divisionLabelStep = param1;
         invalidate(INVALID_DIVISION_SCALE);
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get minRangeDistance() : Number
      {
         return this._minRangeDistance;
      }
      
      public function set minRangeDistance(param1:Number) : void
      {
         this._minRangeDistance = param1;
      }
      
      [Inspectable(defaultValue="",name="divisionLabelPostfix")]
      public function get divisionLabelPostfix() : String
      {
         return this._divisionLabelPostfix;
      }
      
      public function set divisionLabelPostfix(param1:String) : void
      {
         this._divisionLabelPostfix = param1;
         invalidate(INVALID_DIVISION_SCALE);
      }
      
      [Inspectable(defaultValue="0",type="Number")]
      public function get leftValue() : Number
      {
         return this._leftValue;
      }
      
      public function set leftValue(param1:Number) : void
      {
         if(this._leftValue != param1)
         {
            this._leftValue = param1;
            this.dispatchChangeEvent();
            this.updateRangeThumbs();
         }
      }
      
      [Inspectable(defaultValue="10",type="Number")]
      public function get rightValue() : Number
      {
         return this._rightValue;
      }
      
      public function set rightValue(param1:Number) : void
      {
         if(this._rightValue != param1)
         {
            this._rightValue = param1 > maximum ? Number(maximum) : Number(param1);
            this.dispatchChangeEvent();
            this.updateRangeThumbs();
         }
      }
      
      public function get rangeMin() : Number
      {
         return this._rangeMin;
      }
      
      public function set rangeMin(param1:Number) : void
      {
         this._rangeMin = param1;
         invalidate(INVALID_RANGE);
      }
      
      public function get rangeMax() : Number
      {
         return this._rangeMax;
      }
      
      public function set rangeMax(param1:Number) : void
      {
         this._rangeMax = param1;
         invalidate(INVALID_RANGE);
      }
      
      public function get trackHorizontalPadding() : Number
      {
         return this._trackHorizontalPadding;
      }
      
      public function set trackHorizontalPadding(param1:Number) : void
      {
         this._trackHorizontalPadding = param1;
      }
      
      public function get clickableRenderer() : Boolean
      {
         return this._clickableRenderer;
      }
      
      public function set clickableRenderer(param1:Boolean) : void
      {
         this._clickableRenderer = param1;
         invalidate(INVALID_DIVISION_POINT_RENDERER);
      }
      
      override protected function trackPress(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:MouseEvent = null;
         if(this._rangeMode && App.utils.commons.isLeftButton(param1))
         {
            _trackPressed = true;
            track.focused = _focused;
            _loc2_ = this.getValueByPosition(param1);
            _loc3_ = Math.abs(this._leftValue - _loc2_);
            _loc4_ = Math.abs(this._rightValue - _loc2_);
            _loc5_ = lockValue(_loc2_);
            if(_loc3_ < _loc4_ && _loc5_ != this.leftValue || _loc5_ <= this.leftValue)
            {
               if(_loc5_ + this.minRangeDistance <= this.rightValue)
               {
                  this.leftValue = _loc5_;
                  this._draggingThumb = this.leftThumb;
               }
            }
            else if(_loc5_ - this.minRangeDistance >= this.leftValue)
            {
               this.rightValue = _loc5_;
               this._draggingThumb = this.rightThumb;
            }
            _trackDragMouseIndex = 0;
            _dragOffset = {"x":0};
            if(this._draggingThumb)
            {
               _loc6_ = new MouseEvent(MouseEvent.MOUSE_DOWN,false,true);
               _loc6_.localX = this._draggingThumb.mouseX;
               _loc6_.localY = this._draggingThumb.mouseY;
               this._draggingThumb.dispatchEvent(_loc6_);
            }
         }
         else
         {
            super.trackPress(param1);
         }
      }
      
      override protected function onScrollWheel(param1:MouseEvent) : void
      {
         if(!this._rangeMode)
         {
            super.onScrollWheel(param1);
         }
      }
      
      override protected function beginDrag(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(App.utils.commons.isLeftButton(param1))
         {
            this._draggingThumb = param1.currentTarget as Button;
            App.utils.asserter.assertNotNull(this._draggingThumb,"_draggingThumb" + Errors.CANT_NULL);
            this._draggingThumb.selected = true;
            _thumbPressed = true;
            _loc2_ = globalToLocal(new Point(param1.stageX,param1.stageY));
            _dragOffset = {"x":_loc2_.x - this._draggingThumb.x - (this._draggingThumb.width >> 1)};
            App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.doDrag,false,0,true);
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.endDrag,false,0,true);
         }
      }
      
      override protected function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Number = lockValue(this.getValueByPosition(param1));
         if(this._draggingThumb == thumb && thumb.visible)
         {
            if(this.value != _loc2_)
            {
               _value = _loc2_;
               this.updateThumb();
               if(liveDragging)
               {
                  dispatchEvent(new SliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value));
               }
            }
         }
         else if(this._draggingThumb == this.leftThumb && _loc2_ <= this._rightValue && Math.abs(this._rightValue - _loc2_) >= this._minRangeDistance)
         {
            this.leftValue = _loc2_;
         }
         else if(this._draggingThumb == this.rightThumb && _loc2_ >= this._leftValue && Math.abs(_loc2_ - this._leftValue) >= this._minRangeDistance)
         {
            this.rightValue = _loc2_;
         }
      }
      
      override protected function endDrag(param1:MouseEvent) : void
      {
         this._draggingThumb.selected = false;
         super.endDrag(param1);
      }
      
      private function getValueByPosition(param1:MouseEvent) : Number
      {
         var _loc2_:Number = track.width - offsetLeft - offsetRight - RENDERER_LINE_SIZE;
         var _loc3_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
         return Number((_loc3_.x - offsetLeft - this._trackEdge) / _loc2_ * (_maximum - _minimum) + _minimum);
      }
      
      private function onLeftThumbDoubleClickHandler(param1:MouseEvent) : void
      {
         this.rightValue = this.leftValue + this.minRangeDistance;
      }
      
      private function onRightThumbDoubleClickHandler(param1:MouseEvent) : void
      {
         this.leftValue = this.rightValue - this.minRangeDistance;
      }
   }
}
