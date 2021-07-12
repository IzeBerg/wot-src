package net.wg.gui.components.controls.scroller
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import net.wg.data.constants.Time;
   import net.wg.gui.components.carousels.interfaces.IScrollerBase;
   import net.wg.gui.components.carousels.interfaces.IScrollerLayoutController;
   import net.wg.gui.components.carousels.interfaces.IScrollerViewPortBase;
   import net.wg.gui.components.controls.events.ScrollEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class ScrollerBase extends UIComponentEx implements IScrollerBase
   {
      
      protected static const INVALIDATION_TYPE_CLIPPING:String = "clippingInvalid";
      
      protected static const INVALIDATION_TYPE_SCROLL:String = "scrollInvalid";
      
      protected static const INVALIDATION_TYPE_PENDING_SCROLL:String = "pendingScrollInvalid";
      
      protected static const INVALIDATION_TYPE_STYLES:String = "stylesInvalid";
      
      protected static const INVALIDATION_TYPE_LAYOUT:String = "layoutInvalid";
      
      protected static const INVALIDATION_TYPE_INTERACTION_MODE:String = "interactionModeInvalid";
      
      private static const VELOCITY_BUFFER_MAX_SIZE:int = 5;
      
      private static const CONTAINER_NAME:String = "container";
      
      private static const INTERVAL_SPEED:Number = 16.66666666666667;
       
      
      private var _pageThrowDuration:Number = 0.5;
      
      private var _container:DisplayObjectContainer = null;
      
      private var _paddingLeft:int = 0;
      
      private var _paddingRight:int = 0;
      
      private var _paddingTop:int = 0;
      
      private var _paddingBottom:int = 0;
      
      private var _viewPortOffsetLeft:Number = 0;
      
      private var _viewPortOffsetRight:Number = 0;
      
      private var _viewPortOffsetTop:Number = 0;
      
      private var _viewPortOffsetBottom:Number = 0;
      
      private var _maskOffsetLeft:Number = 0;
      
      private var _maskOffsetRight:Number = 0;
      
      private var _maskOffsetTop:Number = 0;
      
      private var _maskOffsetBottom:Number = 0;
      
      private var _horizontalScrollPosition:Number = 0;
      
      private var _minHorizontalScrollPosition:Number = 0;
      
      private var _maxHorizontalScrollPosition:Number = 0;
      
      private var _verticalScrollPosition:Number = 0;
      
      private var _minVerticalScrollPosition:Number = 0;
      
      private var _maxVerticalScrollPosition:Number = 0;
      
      private var _horizontalScrollStep:Number = NaN;
      
      private var _verticalScrollStep:Number = NaN;
      
      private var _pendingHorizontalScrollPosition:Number = NaN;
      
      private var _pendingVerticalScrollPosition:Number = NaN;
      
      private var _pendingHorizontalScrollDuration:Number = NaN;
      
      private var _pendingVerticalScrollDuration:Number = NaN;
      
      private var _viewPort:IScrollerViewPortBase = null;
      
      private var _cropContent:Boolean = false;
      
      private var _isScrolling:Boolean = false;
      
      private var _hasHorizontalElasticEdges:Boolean = false;
      
      private var _hasVerticalElasticEdges:Boolean = false;
      
      private var _snapScrollPositionToPixels:Boolean = true;
      
      private var _mouseWheelDirection:String = "vertical";
      
      private var _velocityBufferX:Vector.<Number>;
      
      private var _velocityBufferY:Vector.<Number>;
      
      private var _velocityLength:int = 0;
      
      private var _startTouchX:Number = NaN;
      
      private var _startTouchY:Number = NaN;
      
      private var _previousTouchX:Number = NaN;
      
      private var _previousTouchY:Number = NaN;
      
      private var _previousTouchTime:int = 0;
      
      private var _isDraggingHorizontally:Boolean = false;
      
      private var _isDraggingVertically:Boolean = false;
      
      private var _decelerationRate:Number = 0.995;
      
      private var _logDecelerationRate:Number = -0.005012541823544286;
      
      private var _startHorizontalScrollPosition:Number = NaN;
      
      private var _startVerticalScrollPosition:Number = NaN;
      
      private var _targetHorizontalScrollPosition:Number = NaN;
      
      private var _targetVerticalScrollPosition:Number = NaN;
      
      private var _horizontalTweenEndValue:Number = NaN;
      
      private var _verticalTweenEndValue:Number = NaN;
      
      private var _horizontalTweenTime:Number = NaN;
      
      private var _horizontalTweenDuration:Number = NaN;
      
      private var _verticalTweenTime:Number = NaN;
      
      private var _verticalTweenDuration:Number = NaN;
      
      private var _tweensHorizontally:Boolean = false;
      
      private var _tweensVertically:Boolean = false;
      
      private var _touchEnabled:Boolean = true;
      
      private var _isTouching:Boolean = false;
      
      private var _snapToPages:Boolean = false;
      
      private var _pageWidth:Number = 0;
      
      private var _pageHeight:Number = 0;
      
      private var _explicitPageWidth:Number = NaN;
      
      private var _explicitPageHeight:Number = NaN;
      
      private var _startDragX:Number = 0;
      
      private var _startDragY:Number = 0;
      
      private var _dStartDragX:Number = 0;
      
      private var _dStartDragY:Number = 0;
      
      private var _velocityWeight:Number = 0;
      
      private var _scrollConfig:ScrollConfig = null;
      
      private var _useTimer:Boolean = false;
      
      private var _timer:Timer = null;
      
      private var _layoutController:IScrollerLayoutController = null;
      
      public function ScrollerBase()
      {
         this._velocityBufferX = new Vector.<Number>(VELOCITY_BUFFER_MAX_SIZE + 1,true);
         this._velocityBufferY = new Vector.<Number>(VELOCITY_BUFFER_MAX_SIZE + 1,true);
         super();
         this._scrollConfig = new ScrollConfig();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
         this._velocityWeight = this._scrollConfig.velocityWeight;
         if(this._container == null)
         {
            this._container = new Sprite();
            this._container.mouseEnabled = false;
            this._container.name = CONTAINER_NAME;
            addChild(this._container);
         }
         _deferredDispose = true;
      }
      
      override protected function onBeforeDispose() : void
      {
         this.killHorizontalScrollTween();
         this.killVerticalScrollTween();
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this.removeDragUpdateHandlerListener();
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._velocityBufferX.fixed = false;
         this._velocityBufferX.splice(0,this._velocityBufferX.length);
         this._velocityBufferX = null;
         this._velocityBufferY.fixed = false;
         this._velocityBufferY.splice(0,this._velocityBufferY.length);
         this._velocityBufferY = null;
         if(this._viewPort)
         {
            this._viewPort.removeEventListener(Event.RESIZE,this.onViewPortResizeHandler);
            this._container.removeChild(DisplayObject(this._viewPort));
            this._viewPort = null;
         }
         if(this._container)
         {
            removeChild(this._container);
            this._container = null;
         }
         this._scrollConfig = null;
         if(this._timer != null)
         {
            this._timer.stop();
            this._timer = null;
         }
         this._layoutController = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(INVALIDATION_TYPE_INTERACTION_MODE))
         {
            this.refreshInteractionMode();
         }
         if(isInvalid(INVALIDATION_TYPE_STYLES))
         {
            this.calculateViewPortOffsets();
         }
         var _loc1_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc2_:Boolean = isInvalid(INVALIDATION_TYPE_LAYOUT);
         var _loc3_:Boolean = isInvalid(INVALIDATION_TYPE_PENDING_SCROLL);
         if(_loc1_ || isInvalid(InvalidationType.SIZE) || _loc3_ || _loc2_)
         {
            this.refreshViewPortBounds();
            this._viewPort.validateNow();
            this.refreshScrollValues();
         }
         if(_loc3_)
         {
            this.handlePendingScroll();
         }
         this.updateScrollPosition();
         var _loc4_:Boolean = isInvalid(INVALIDATION_TYPE_SCROLL);
         if(_loc4_ && hasEventListener(Event.SCROLL))
         {
            dispatchEvent(new Event(Event.SCROLL));
         }
         var _loc5_:Boolean = isInvalid(InvalidationType.SIZE);
         if(_loc1_ || _loc5_ || _loc4_ || _loc3_ || _loc2_)
         {
            this.layoutChildren();
         }
         if(isInvalid(INVALIDATION_TYPE_CLIPPING) || _loc5_)
         {
            this.createMask();
         }
         if(_loc5_ && hasEventListener(ScrollEvent.UPDATE_SIZE))
         {
            dispatchEvent(new ScrollEvent(ScrollEvent.UPDATE_SIZE));
         }
      }
      
      public function moveToHorizontalScrollPosition(param1:int) : void
      {
         this.killHorizontalScrollTween();
         this.horizontalScrollPosition = param1;
      }
      
      public function scrollInDirection(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Number = 0;
         if(this._mouseWheelDirection == DirectionMode.HORIZONTAL)
         {
            if(this._hasHorizontalElasticEdges && !isNaN(this._targetHorizontalScrollPosition))
            {
               _loc3_ = this._targetHorizontalScrollPosition;
            }
            else
            {
               _loc3_ = this._horizontalScrollPosition;
            }
            _loc4_ = this._horizontalScrollStep;
            if(_loc4_ !== _loc4_)
            {
               _loc4_ = this._pageWidth * this._scrollConfig.mouseWheelScrollPercent;
            }
            _loc3_ -= param1 * _loc4_;
            if(_loc3_ <= this._minHorizontalScrollPosition)
            {
               _loc3_ = this._minHorizontalScrollPosition;
               _loc2_ = this._scrollConfig.mouseWheelScrollDuration;
            }
            else if(_loc3_ >= this._maxHorizontalScrollPosition)
            {
               _loc3_ = this._maxHorizontalScrollPosition;
               _loc2_ = this._scrollConfig.mouseWheelScrollDuration;
            }
            else if(this._scrollConfig.mouseWheelScrollDuration != 0)
            {
               _loc2_ = this.calculateDynamicThrowDurationFromDistance(Math.abs(_loc3_) - Math.abs(this._horizontalScrollPosition));
            }
            this.throwToHorizontalPosition(_loc3_,_loc2_);
         }
         else if(this._mouseWheelDirection == DirectionMode.VERTICAL)
         {
            if(this._hasVerticalElasticEdges && !isNaN(this._targetVerticalScrollPosition))
            {
               _loc5_ = this._targetVerticalScrollPosition;
            }
            else
            {
               _loc5_ = this._verticalScrollPosition;
            }
            _loc6_ = this._verticalScrollStep;
            if(_loc6_ !== _loc6_)
            {
               _loc6_ = this._pageHeight * this._scrollConfig.mouseWheelScrollPercent;
            }
            _loc5_ -= param1 * _loc6_;
            if(_loc5_ <= this._minVerticalScrollPosition)
            {
               _loc5_ = this._minVerticalScrollPosition;
               _loc2_ = this._scrollConfig.mouseWheelScrollDuration;
            }
            else if(_loc5_ >= this._maxVerticalScrollPosition)
            {
               _loc5_ = this._maxVerticalScrollPosition;
               _loc2_ = this._scrollConfig.mouseWheelScrollDuration;
            }
            else if(this._scrollConfig.mouseWheelScrollDuration != 0)
            {
               _loc2_ = this.calculateDynamicThrowDurationFromDistance(Math.abs(_loc5_) - Math.abs(this._verticalScrollPosition));
            }
            this.throwToVerticalPosition(_loc5_,_loc2_);
         }
      }
      
      public function scrollToHorizontalPosition(param1:Number, param2:Number) : void
      {
         this.savePendingHorizontalScrollValues(param1,param2,true);
      }
      
      public final function scrollToPosition(param1:Number, param2:Number, param3:Number = NaN) : void
      {
         this.scrollToHorizontalPosition(param1,param3);
         this.scrollToVerticalPosition(param2,param3);
      }
      
      public function scrollToVerticalPosition(param1:Number, param2:Number) : void
      {
         this.savePendingVerticalScrollValues(param1,param2,true);
      }
      
      public function setLayoutController(param1:IScrollerLayoutController) : void
      {
         this._layoutController = param1;
         if(this._viewPort == null)
         {
            return;
         }
         this._viewPort.setLayoutController(param1);
      }
      
      public function usesLayoutController() : Boolean
      {
         return this._viewPort != null && this._viewPort.usesLayoutController();
      }
      
      protected function createMask() : void
      {
         var _loc3_:Shape = null;
         var _loc1_:Number = _width - this._maskOffsetRight - this._maskOffsetLeft;
         var _loc2_:Number = _height - this._maskOffsetBottom - this._maskOffsetTop;
         if(this._cropContent)
         {
            if(this._container.mask == null)
            {
               _loc3_ = new Shape();
               _loc3_.name = "mask";
               _loc3_.graphics.beginFill(0,0);
               _loc3_.graphics.drawRect(0,0,2,2);
               _loc3_.graphics.endFill();
               _loc3_.x = this._maskOffsetLeft;
               _loc3_.y = this._maskOffsetTop;
               this._container.addChildAt(_loc3_,0);
               this._container.mask = _loc3_;
            }
            this._container.mask.width = _loc1_;
            this._container.mask.height = _loc2_;
         }
         else if(this._container.mask)
         {
            this._container.removeChild(this._container.mask);
            this._container.mask = null;
         }
      }
      
      protected function calculateViewPortOffsets() : void
      {
         this._viewPortOffsetLeft = this._paddingLeft;
         this._viewPortOffsetRight = this._paddingRight;
         this._viewPortOffsetTop = this._paddingTop;
         this._viewPortOffsetBottom = this._paddingBottom;
      }
      
      protected function refreshViewPortBounds() : void
      {
         var _loc1_:Number = this._viewPortOffsetLeft + this._viewPortOffsetRight;
         var _loc2_:Number = this._viewPortOffsetTop + this._viewPortOffsetBottom;
         this._viewPort.visibleWidth = _width - _loc1_;
         this._viewPort.visibleHeight = _height - _loc2_;
      }
      
      protected function updateScrollPosition() : void
      {
         this._viewPort.horizontalScrollPosition = this._horizontalScrollPosition;
         this._viewPort.verticalScrollPosition = this._verticalScrollPosition;
      }
      
      protected function refreshInteractionMode() : void
      {
         if(this._touchEnabled)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            this.completeTouchScroll();
         }
         if(_mouseWheelEnabled)
         {
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         }
      }
      
      protected function refreshScrollValues() : void
      {
         var _loc1_:Number = this._maxHorizontalScrollPosition;
         var _loc2_:Number = this._maxVerticalScrollPosition;
         this.refreshMinAndMaxScrollValues();
         if(_loc1_ !== this._maxHorizontalScrollPosition)
         {
            if(this._tweensHorizontally)
            {
               this.refreshHorizontalTweenEndValue();
            }
            else if(!this._isDraggingHorizontally)
            {
               this.horizontalScrollPosition = this._targetHorizontalScrollPosition = this.clampScrollPosition(this._horizontalScrollPosition,this._minHorizontalScrollPosition,this._maxHorizontalScrollPosition,this.horizontalScrollStep,false);
            }
         }
         if(_loc2_ !== this._maxVerticalScrollPosition)
         {
            if(this._tweensVertically)
            {
               this.refreshVerticalTweenEndValue();
            }
            else if(!this._isDraggingVertically)
            {
               this.setVerticalScrollPositionImmidiatly(this.clampScrollPosition(this._verticalScrollPosition,this._minVerticalScrollPosition,this._maxVerticalScrollPosition,this.verticalScrollStep,false));
            }
         }
         this.refreshComponentsScrollValues();
      }
      
      protected function refreshMinAndMaxScrollValues() : void
      {
         var _loc3_:Point = null;
         var _loc1_:Number = this.width - this._viewPortOffsetLeft - this._viewPortOffsetRight;
         var _loc2_:Number = this.height - this._viewPortOffsetTop - this._viewPortOffsetBottom;
         this._minHorizontalScrollPosition = 0;
         this._minVerticalScrollPosition = 0;
         this._maxHorizontalScrollPosition = this._minHorizontalScrollPosition + this._viewPort.validWidth - _loc1_;
         this._maxVerticalScrollPosition = this._minVerticalScrollPosition + this._viewPort.validHeight - _loc2_;
         if(this.usesLayoutController())
         {
            _loc3_ = this._layoutController.getMaxExtents();
            this._maxHorizontalScrollPosition = Math.max(0,_loc3_.x - _loc1_);
            this._maxVerticalScrollPosition = Math.max(_loc3_.y - _loc2_);
         }
         if(this._maxHorizontalScrollPosition < this._minHorizontalScrollPosition)
         {
            this._maxHorizontalScrollPosition = this._minHorizontalScrollPosition;
         }
         if(this._maxVerticalScrollPosition < this._minVerticalScrollPosition)
         {
            this._maxVerticalScrollPosition = this._minVerticalScrollPosition;
         }
         if(this._explicitPageWidth !== this._explicitPageWidth)
         {
            this._pageWidth = _loc1_;
         }
         if(this._explicitPageHeight !== this._explicitPageHeight)
         {
            this._pageHeight = _loc2_;
         }
      }
      
      protected function refreshComponentsScrollValues() : void
      {
      }
      
      protected function refreshHorizontalTweenEndValue() : void
      {
         var _loc1_:Number = NaN;
         if(this._targetHorizontalScrollPosition < this._minHorizontalScrollPosition)
         {
            _loc1_ = this._targetHorizontalScrollPosition - this._minHorizontalScrollPosition;
         }
         else if(this._targetHorizontalScrollPosition > this._maxHorizontalScrollPosition)
         {
            _loc1_ = this._targetHorizontalScrollPosition - this._maxHorizontalScrollPosition;
         }
         if(_loc1_ === _loc1_)
         {
            this._horizontalTweenEndValue = this._targetHorizontalScrollPosition - _loc1_ + (!!this._hasHorizontalElasticEdges ? _loc1_ * this._scrollConfig.throwElasticity : 0);
         }
         else
         {
            this._horizontalTweenEndValue = this._targetHorizontalScrollPosition;
         }
      }
      
      protected function refreshVerticalTweenEndValue() : void
      {
         var _loc1_:Number = NaN;
         if(this._targetVerticalScrollPosition < this._minVerticalScrollPosition)
         {
            _loc1_ = this._targetVerticalScrollPosition - this._minVerticalScrollPosition;
         }
         else if(this._targetVerticalScrollPosition > this._maxVerticalScrollPosition)
         {
            _loc1_ = this._targetVerticalScrollPosition - this._maxVerticalScrollPosition;
         }
         if(_loc1_ === _loc1_)
         {
            this._verticalTweenEndValue = this._targetVerticalScrollPosition - _loc1_ + (!!this._hasVerticalElasticEdges ? _loc1_ * this._scrollConfig.throwElasticity : 0);
         }
         else
         {
            this._verticalTweenEndValue = this._targetVerticalScrollPosition;
         }
      }
      
      protected function layoutChildren() : void
      {
         this._viewPort.x = this._viewPortOffsetLeft - this._horizontalScrollPosition;
         this._viewPort.y = this._viewPortOffsetTop - this._verticalScrollPosition;
      }
      
      protected function savePendingHorizontalScrollValues(param1:Number, param2:Number = NaN, param3:Boolean = true) : void
      {
         this.assertNotNaN(param1,"targetHorizontalPosition");
         if(this._pendingHorizontalScrollPosition === param1)
         {
            return;
         }
         if(param2 !== param2)
         {
            param2 = this.calculateDynamicThrowDurationFromDistance(param1 - this._horizontalScrollPosition);
         }
         this._pendingHorizontalScrollPosition = param1;
         this._pendingHorizontalScrollDuration = param2;
         if(param3)
         {
            invalidate(INVALIDATION_TYPE_PENDING_SCROLL);
         }
      }
      
      protected function clearPendingHorizontalScrollValues() : void
      {
         this._pendingHorizontalScrollPosition = NaN;
         this._pendingHorizontalScrollDuration = NaN;
      }
      
      protected function savePendingVerticalScrollValues(param1:Number, param2:Number = NaN, param3:Boolean = true) : void
      {
         this.assertNotNaN(param1,"targetVerticalPosition");
         if(this._pendingVerticalScrollPosition === param1)
         {
            return;
         }
         if(param2 !== param2)
         {
            param2 = this.calculateDynamicThrowDurationFromDistance(param1 - this._verticalScrollPosition);
         }
         this._pendingVerticalScrollPosition = param1;
         this._pendingVerticalScrollDuration = param2;
         if(param3)
         {
            invalidate(INVALIDATION_TYPE_PENDING_SCROLL);
         }
      }
      
      protected function clearPendingVerticalScrollValues() : void
      {
         this._pendingVerticalScrollPosition = NaN;
         this._pendingVerticalScrollDuration = NaN;
      }
      
      protected function handlePendingScroll() : void
      {
         if(this._pendingHorizontalScrollPosition === this._pendingHorizontalScrollPosition)
         {
            this.throwToHorizontalPosition(this._pendingHorizontalScrollPosition,this._pendingHorizontalScrollDuration);
            this.clearPendingHorizontalScrollValues();
         }
         if(this._pendingVerticalScrollPosition === this._pendingVerticalScrollPosition)
         {
            this.throwToVerticalPosition(this._pendingVerticalScrollPosition,this._pendingVerticalScrollDuration);
            this.clearPendingVerticalScrollValues();
         }
      }
      
      protected function startScroll() : void
      {
         if(this._isScrolling)
         {
            return;
         }
         this._isScrolling = true;
         if(hasEventListener(ScrollEvent.SCROLL_START))
         {
            dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_START));
         }
      }
      
      protected function completeScroll() : void
      {
         if(!this._isScrolling)
         {
            return;
         }
         this._isScrolling = false;
         if(hasEventListener(ScrollEvent.SCROLL_COMPLETE))
         {
            dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_COMPLETE));
         }
      }
      
      protected function finishHorizontalScroll() : void
      {
         var _loc1_:Number = NaN;
         if(this._horizontalScrollPosition <= this._minHorizontalScrollPosition || this._horizontalScrollPosition >= this._maxHorizontalScrollPosition)
         {
            this.completeHorizontalScroll();
         }
         else if(this._snapToPages)
         {
            _loc1_ = this.roundToNearest(this._horizontalScrollPosition,this._pageWidth);
            if(_loc1_ != this._horizontalScrollPosition)
            {
               this.throwToHorizontalPosition(_loc1_,this.pageThrowDuration);
            }
            else
            {
               this.completeScroll();
            }
         }
         else
         {
            this.completeScroll();
         }
      }
      
      protected function finishVerticalScroll() : void
      {
         var _loc1_:Number = NaN;
         if(this._verticalScrollPosition <= this._minVerticalScrollPosition || this._verticalScrollPosition >= this._maxVerticalScrollPosition)
         {
            this.completeVerticalScroll();
         }
         else if(this._snapToPages)
         {
            _loc1_ = this.roundToNearest(this._verticalScrollPosition,this._pageHeight);
            if(_loc1_ != this._verticalScrollPosition)
            {
               this.throwToVerticalPosition(_loc1_,this.pageThrowDuration);
            }
            else
            {
               this.completeScroll();
            }
         }
         else
         {
            this.completeScroll();
         }
      }
      
      protected function completeHorizontalScroll() : void
      {
         var _loc1_:Number = NaN;
         if(this._horizontalScrollPosition <= this._minHorizontalScrollPosition)
         {
            _loc1_ = this._minHorizontalScrollPosition;
         }
         else if(this._horizontalScrollPosition >= this._maxHorizontalScrollPosition)
         {
            _loc1_ = this._maxHorizontalScrollPosition;
         }
         this._isDraggingHorizontally = false;
         if(_loc1_ !== _loc1_)
         {
            this.completeScroll();
         }
         else if(Math.abs(_loc1_ - this._horizontalScrollPosition) < 1)
         {
            this.horizontalScrollPosition = this._targetHorizontalScrollPosition = _loc1_;
            this.completeScroll();
         }
         else
         {
            this.throwToHorizontalPosition(_loc1_,this._scrollConfig.elasticSnapDuration);
         }
      }
      
      protected function completeVerticalScroll() : void
      {
         var _loc1_:Number = NaN;
         if(this._verticalScrollPosition <= this._minVerticalScrollPosition)
         {
            _loc1_ = this._minVerticalScrollPosition;
         }
         else if(this._verticalScrollPosition >= this._maxVerticalScrollPosition)
         {
            _loc1_ = this._maxVerticalScrollPosition;
         }
         this._isDraggingVertically = false;
         if(_loc1_ !== _loc1_)
         {
            this.completeScroll();
         }
         else if(Math.abs(_loc1_ - this._verticalScrollPosition) < 1)
         {
            this.setVerticalScrollPositionImmidiatly(_loc1_);
            this.completeScroll();
         }
         else
         {
            this.throwToVerticalPosition(_loc1_,this._scrollConfig.elasticSnapDuration);
         }
      }
      
      protected function throwToHorizontalPosition(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         if(this.assertNotNaN(param1,"targetHorizontalScrollPosition") || this.assertNotNaN(param2,"duration"))
         {
            this.completeHorizontalScroll();
            return;
         }
         var _loc3_:Number = this.horizontalScrollStep;
         if(_loc3_ === _loc3_)
         {
            _loc4_ = this.roundToNearest(param1,_loc3_);
            if(_loc4_ != param1)
            {
               param1 = _loc4_;
               if(param1 < this._minHorizontalScrollPosition)
               {
                  param1 = this._minHorizontalScrollPosition;
               }
               else if(param1 > this._maxHorizontalScrollPosition)
               {
                  param1 = this._maxHorizontalScrollPosition;
               }
            }
         }
         this.killHorizontalScrollTween();
         if(this._horizontalScrollPosition != param1)
         {
            if(param2 == 0)
            {
               this.horizontalScrollPosition = this._targetHorizontalScrollPosition = param1;
               this.completeScroll();
            }
            else
            {
               this._tweensHorizontally = true;
               this._horizontalTweenTime = getTimer();
               this._horizontalTweenDuration = param2 * Time.MILLISECOND_IN_SECOND;
               this._startHorizontalScrollPosition = this._horizontalScrollPosition;
               this._targetHorizontalScrollPosition = param1;
               if(this._useTimer)
               {
                  this._timer.addEventListener(TimerEvent.TIMER,this.onUpdateHorizontalScrollTweenHandler);
                  this._timer.start();
               }
               else
               {
                  App.stage.addEventListener(Event.ENTER_FRAME,this.onUpdateHorizontalScrollTweenHandler);
               }
               this.refreshHorizontalTweenEndValue();
            }
         }
         else
         {
            this.completeHorizontalScroll();
         }
      }
      
      protected function throwToVerticalPosition(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         if(this.assertNotNaN(param1,"targetVerticalScrollPosition") || this.assertNotNaN(param2,"duration"))
         {
            this.completeVerticalScroll();
            return;
         }
         var _loc3_:Number = this.verticalScrollStep;
         if(_loc3_ === _loc3_)
         {
            _loc4_ = this.roundToNearest(param1,_loc3_);
            if(_loc4_ != param1)
            {
               param1 = _loc4_;
               if(param1 < this._minVerticalScrollPosition)
               {
                  param1 = this._minVerticalScrollPosition;
               }
               else if(param1 > this._maxVerticalScrollPosition)
               {
                  param1 = this._maxVerticalScrollPosition;
               }
            }
         }
         this.killVerticalScrollTween();
         if(this._verticalScrollPosition != param1)
         {
            if(param2 == 0)
            {
               this.setVerticalScrollPositionImmidiatly(param1);
               this.completeScroll();
            }
            else
            {
               this._tweensVertically = true;
               this._verticalTweenTime = getTimer();
               this._verticalTweenDuration = param2 * Time.MILLISECOND_IN_SECOND;
               this._startVerticalScrollPosition = this._verticalScrollPosition;
               this._targetVerticalScrollPosition = param1;
               if(this._useTimer)
               {
                  this._timer.addEventListener(TimerEvent.TIMER,this.onUpdateVerticalScrollTweenHandler);
                  this._timer.start();
               }
               else
               {
                  App.stage.addEventListener(Event.ENTER_FRAME,this.onUpdateVerticalScrollTweenHandler);
               }
               this.refreshVerticalTweenEndValue();
            }
         }
         else
         {
            this.completeVerticalScroll();
         }
      }
      
      protected function killHorizontalScrollTween() : void
      {
         if(this._tweensHorizontally)
         {
            this._tweensHorizontally = false;
            if(this._useTimer)
            {
               this._timer.removeEventListener(TimerEvent.TIMER,this.onUpdateHorizontalScrollTweenHandler);
               this._timer.stop();
            }
            else
            {
               App.stage.removeEventListener(Event.ENTER_FRAME,this.onUpdateHorizontalScrollTweenHandler);
            }
         }
      }
      
      protected function killVerticalScrollTween() : void
      {
         if(this._tweensVertically)
         {
            this._tweensVertically = false;
            if(this._useTimer)
            {
               this._timer.removeEventListener(TimerEvent.TIMER,this.onUpdateVerticalScrollTweenHandler);
               this._timer.stop();
            }
            else
            {
               App.stage.removeEventListener(Event.ENTER_FRAME,this.onUpdateVerticalScrollTweenHandler);
            }
         }
      }
      
      protected function throwHorizontallyWithVelocity(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this._snapToPages && Math.abs(param1) > this._scrollConfig.minThrowVelocityPerMs)
         {
            if(param1 > 0)
            {
               _loc2_ = this.roundDownToNearest(this._horizontalScrollPosition + this.calculateThrowDistance(param1),this._pageWidth);
            }
            else
            {
               _loc2_ = this.roundUpToNearest(this._horizontalScrollPosition + this.calculateThrowDistance(param1),this._pageWidth);
            }
            if(_loc2_ < this._minHorizontalScrollPosition)
            {
               _loc2_ = this._minHorizontalScrollPosition;
            }
            else if(_loc2_ > this._maxHorizontalScrollPosition)
            {
               _loc2_ = this._maxHorizontalScrollPosition;
            }
            this.throwToHorizontalPosition(_loc2_,this.calculateDynamicThrowDuration(param1));
         }
         else if(!this._snapToPages && Math.abs(param1) > this._scrollConfig.minVelocityPerMs)
         {
            this.throwToHorizontalPosition(this._horizontalScrollPosition + this.calculateThrowDistance(param1),this.calculateDynamicThrowDuration(param1));
         }
         else
         {
            this.finishHorizontalScroll();
         }
      }
      
      protected function throwVerticallyWithVelocity(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this._snapToPages && Math.abs(param1) > this._scrollConfig.minThrowVelocityPerMs)
         {
            if(param1 > 0)
            {
               _loc2_ = this.roundDownToNearest(this._verticalScrollPosition + this.calculateThrowDistance(param1),this._pageHeight);
            }
            else
            {
               _loc2_ = this.roundUpToNearest(this._verticalScrollPosition + this.calculateThrowDistance(param1),this._pageHeight);
            }
            if(_loc2_ < this._minVerticalScrollPosition)
            {
               _loc2_ = this._minVerticalScrollPosition;
            }
            else if(_loc2_ > this._maxVerticalScrollPosition)
            {
               _loc2_ = this._maxVerticalScrollPosition;
            }
            this.throwToVerticalPosition(_loc2_,this.calculateDynamicThrowDuration(param1));
         }
         else if(!this._snapToPages && Math.abs(param1) > this._scrollConfig.minVelocityPerMs)
         {
            this.throwToVerticalPosition(this._verticalScrollPosition + this.calculateThrowDistance(param1),this.calculateDynamicThrowDuration(param1));
         }
         else
         {
            this.finishVerticalScroll();
         }
      }
      
      protected function calculateDynamicThrowDurationFromDistance(param1:Number) : Number
      {
         var _loc2_:Number = param1 * this._logDecelerationRate;
         if(Math.abs(_loc2_) > this._scrollConfig.minVelocityPerMs)
         {
            return this.calculateDynamicThrowDuration(_loc2_);
         }
         return 0;
      }
      
      protected function calculateDynamicThrowDuration(param1:Number) : Number
      {
         return Math.log(this._scrollConfig.minVelocityPerMs / Math.abs(param1)) / this._logDecelerationRate / Time.MILLISECOND_IN_SECOND;
      }
      
      protected function calculateThrowDistance(param1:Number) : Number
      {
         return param1 / this._logDecelerationRate;
      }
      
      protected function isViewPortUnderMouse() : Boolean
      {
         return this.isViewPortUnderPoint(this._container.mouseX,this._container.mouseY);
      }
      
      protected function isViewPortUnderPoint(param1:Number, param2:Number) : Boolean
      {
         return param1 >= 0 && param1 < this._viewPort.visibleWidth + this._viewPortOffsetLeft + this._viewPortOffsetRight && param2 >= 0 && param2 < this._viewPort.visibleHeight + this._viewPortOffsetTop + this._viewPortOffsetBottom;
      }
      
      protected function startTouchScroll() : void
      {
         if(this._isTouching)
         {
            return;
         }
         this._isTouching = true;
         this._startHorizontalScrollPosition = this._horizontalScrollPosition;
         this._startVerticalScrollPosition = this._verticalScrollPosition;
         this._startTouchX = this._previousTouchX = this.mouseX;
         this._startTouchY = this._previousTouchY = this.mouseY;
         this._previousTouchTime = getTimer();
         this._velocityLength = 0;
         if(this._tweensHorizontally)
         {
            this.killHorizontalScrollTween();
            this._isDraggingHorizontally = true;
         }
         if(this._tweensVertically)
         {
            this.killVerticalScrollTween();
            this._isDraggingVertically = true;
         }
         this.startScroll();
      }
      
      protected function completeTouchScroll() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         if(!this._isTouching)
         {
            return;
         }
         this.removeDragUpdateHandlerListener();
         this._isTouching = false;
         var _loc1_:Boolean = false;
         if(this._tweensHorizontally && (this._horizontalScrollPosition <= this._minHorizontalScrollPosition || this._horizontalScrollPosition >= this._maxHorizontalScrollPosition))
         {
            _loc1_ = true;
            this.completeHorizontalScroll();
         }
         var _loc2_:Boolean = false;
         if(this._tweensVertically && (this._verticalScrollPosition <= this._minVerticalScrollPosition || this._verticalScrollPosition >= this._maxVerticalScrollPosition))
         {
            _loc2_ = true;
            this.completeVerticalScroll();
         }
         var _loc3_:Boolean = !_loc1_ && this._isDraggingHorizontally;
         var _loc4_:Boolean = !_loc2_ && this._isDraggingVertically;
         if(_loc3_ || _loc4_)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = 0;
            while(_loc8_ < this._velocityLength)
            {
               _loc9_ = 1 + (this._velocityLength - _loc8_) * this.velocityWeight;
               _loc5_ += this._velocityBufferX[_loc8_] * _loc9_;
               _loc6_ += this._velocityBufferY[_loc8_] * _loc9_;
               _loc7_ += _loc9_;
               _loc8_++;
            }
            if(_loc3_)
            {
               this.throwHorizontallyWithVelocity(_loc5_ / _loc7_);
            }
            if(_loc4_)
            {
               this.throwVerticallyWithVelocity(_loc6_ / _loc7_);
            }
         }
      }
      
      protected function horizontalTweenEase(param1:Number) : Number
      {
         return Ease.instance.easeOut(param1);
      }
      
      protected function verticalTweenEase(param1:Number) : Number
      {
         return Ease.instance.easeOut(param1);
      }
      
      protected function roundToNearest(param1:Number, param2:Number) : Number
      {
         return Math.round(param1 / param2) * param2;
      }
      
      protected function roundDownToNearest(param1:Number, param2:Number) : Number
      {
         return (param1 / param2 >> 0) * param2;
      }
      
      protected function roundUpToNearest(param1:Number, param2:Number) : Number
      {
         return Math.ceil(param1 / param2) * param2;
      }
      
      protected function initTouchScroll() : void
      {
         if(!this.isViewPortUnderMouse())
         {
            this.killHorizontalScrollTween();
            this.killVerticalScrollTween();
            return;
         }
         this.startTouchScroll();
         if(this._useTimer)
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.onDragUpdateHandler);
            this._timer.start();
         }
         else
         {
            addEventListener(Event.ENTER_FRAME,this.onDragUpdateHandler);
         }
      }
      
      protected function onStartDragging(param1:Number, param2:Number) : void
      {
         if(!this._touchEnabled)
         {
            return;
         }
         this._startDragX = param1;
         this._startDragY = param2;
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
      }
      
      protected function setVerticalScrollPositionImmidiatly(param1:Number) : void
      {
         this.verticalScrollPosition = this._targetVerticalScrollPosition = param1;
      }
      
      private function clampScrollPosition(param1:Number, param2:Number, param3:Number, param4:Number = NaN, param5:Boolean = true, param6:Number = 2147483647) : Number
      {
         if(param4 === param4)
         {
            param1 = this.roundToNearest(param1,param4);
         }
         if(param1 < param2)
         {
            if(param5)
            {
               param1 -= (param1 - param2) * (1 - this._scrollConfig.elasticity);
               if(param1 < param2 - param6)
               {
                  param1 = param2 - param6;
               }
            }
            else
            {
               param1 = param2;
            }
         }
         else if(param1 > param3)
         {
            if(param5)
            {
               param1 -= (param1 - param3) * (1 - this._scrollConfig.elasticity);
               if(param1 > param3 + param6)
               {
                  param1 = param3 + param6;
               }
            }
            else
            {
               param1 = param3;
            }
         }
         return param1;
      }
      
      private function assertNotNaN(param1:Number, param2:String) : Boolean
      {
         var _loc3_:Boolean = param1 !== param1;
         App.utils.asserter.assert(!_loc3_,param2 + " cannot be NaN.");
         return _loc3_;
      }
      
      private function removeDragUpdateHandlerListener() : void
      {
         if(this._useTimer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onDragUpdateHandler);
            this._timer.stop();
         }
         else
         {
            removeEventListener(Event.ENTER_FRAME,this.onDragUpdateHandler);
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(this._viewPort)
         {
            this._viewPort.enabled = param1;
         }
         super.enabled = param1;
      }
      
      public function get pageWidth() : Number
      {
         return this._pageWidth;
      }
      
      public function set pageWidth(param1:Number) : void
      {
         if(param1 == this._explicitPageWidth)
         {
            return;
         }
         this._explicitPageWidth = param1;
         if(param1 === param1)
         {
            this._pageWidth = param1;
         }
         else
         {
            this._pageWidth = 0;
         }
      }
      
      public function get pageHeight() : Number
      {
         return this._pageHeight;
      }
      
      public function set pageHeight(param1:Number) : void
      {
         if(param1 == this._explicitPageHeight)
         {
            return;
         }
         this._explicitPageHeight = param1;
         if(param1 === param1)
         {
            this._pageHeight = param1;
         }
         else
         {
            this._pageHeight = 0;
         }
      }
      
      public function get snapToPages() : Boolean
      {
         return this._snapToPages;
      }
      
      public function set snapToPages(param1:Boolean) : void
      {
         if(param1 == this._snapToPages)
         {
            return;
         }
         this._snapToPages = param1;
         invalidate(INVALIDATION_TYPE_SCROLL);
      }
      
      public function get touchScrollEnabled() : Boolean
      {
         return this._touchEnabled;
      }
      
      public function set touchScrollEnabled(param1:Boolean) : void
      {
         if(param1 == this._touchEnabled)
         {
            return;
         }
         if(!param1)
         {
            this.completeScroll();
         }
         this._touchEnabled = param1;
         invalidate(INVALIDATION_TYPE_INTERACTION_MODE);
      }
      
      public function get viewPort() : IScrollerViewPortBase
      {
         return this._viewPort;
      }
      
      public function set viewPort(param1:IScrollerViewPortBase) : void
      {
         if(param1 == this._viewPort)
         {
            return;
         }
         if(this._viewPort)
         {
            this._viewPort.removeEventListener(Event.RESIZE,this.onViewPortResizeHandler);
            this._container.removeChild(DisplayObject(this._viewPort));
         }
         this._viewPort = param1;
         if(this._viewPort)
         {
            this._viewPort.enabled = this.enabled;
            this._viewPort.addEventListener(Event.RESIZE,this.onViewPortResizeHandler);
            this._container.addChild(DisplayObject(this._viewPort));
            if(this._layoutController != null)
            {
               this._viewPort.setLayoutController(this._layoutController);
            }
         }
         invalidate(InvalidationType.SIZE);
      }
      
      [Inspectable(name="cropContent",type="Boolean")]
      public function get cropContent() : Boolean
      {
         return this._cropContent;
      }
      
      public function set cropContent(param1:Boolean) : void
      {
         if(param1 == this._cropContent)
         {
            return;
         }
         this._cropContent = param1;
         invalidate(INVALIDATION_TYPE_CLIPPING);
      }
      
      [Inspectable(name="snapScrollPositionToPixels",type="Boolean")]
      public function get snapScrollPositionToPixels() : Boolean
      {
         return this._snapScrollPositionToPixels;
      }
      
      public function set snapScrollPositionToPixels(param1:Boolean) : void
      {
         if(param1 == this._snapScrollPositionToPixels)
         {
            return;
         }
         this._snapScrollPositionToPixels = param1;
         if(param1)
         {
            this.horizontalScrollPosition = this.horizontalScrollPosition;
            this.verticalScrollPosition = this.verticalScrollPosition;
         }
      }
      
      [Inspectable(name="hasHorizontalElasticEdges",type="Boolean")]
      public function get hasHorizontalElasticEdges() : Boolean
      {
         return this._hasHorizontalElasticEdges;
      }
      
      public function set hasHorizontalElasticEdges(param1:Boolean) : void
      {
         this._hasHorizontalElasticEdges = param1;
      }
      
      [Inspectable(name="hasVerticalElasticEdges",type="Boolean")]
      public function get hasVerticalElasticEdges() : Boolean
      {
         return this._hasVerticalElasticEdges;
      }
      
      public function set hasVerticalElasticEdges(param1:Boolean) : void
      {
         this._hasVerticalElasticEdges = param1;
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._horizontalScrollPosition;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         if(this._snapScrollPositionToPixels)
         {
            param1 = Math.round(param1);
         }
         if(this.assertNotNaN(param1,"horizontalScrollPosition"))
         {
            param1 = 0;
         }
         if(param1 == this._horizontalScrollPosition)
         {
            return;
         }
         this._horizontalScrollPosition = param1;
         invalidate(INVALIDATION_TYPE_SCROLL);
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         if(this._snapScrollPositionToPixels)
         {
            param1 = Math.round(param1);
         }
         if(this.assertNotNaN(param1,"verticalScrollPosition"))
         {
            param1 = 0;
         }
         if(param1 == this._verticalScrollPosition)
         {
            return;
         }
         this._verticalScrollPosition = param1;
         invalidate(INVALIDATION_TYPE_SCROLL);
      }
      
      public function get minHorizontalScrollPosition() : Number
      {
         return this._minHorizontalScrollPosition;
      }
      
      public function get minVerticalScrollPosition() : Number
      {
         return this._minVerticalScrollPosition;
      }
      
      public function get maxHorizontalScrollPosition() : Number
      {
         return this._maxHorizontalScrollPosition;
      }
      
      public function get maxVerticalScrollPosition() : Number
      {
         return this._maxVerticalScrollPosition;
      }
      
      [Inspectable(name="paddingTop",type="int")]
      public function get paddingTop() : int
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:int) : void
      {
         if(param1 == this._paddingTop)
         {
            return;
         }
         this._paddingTop = param1;
         invalidate(INVALIDATION_TYPE_STYLES);
      }
      
      [Inspectable(name="paddingLeft",type="int")]
      public function get paddingLeft() : int
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:int) : void
      {
         if(param1 == this._paddingLeft)
         {
            return;
         }
         this._paddingLeft = param1;
         invalidate(INVALIDATION_TYPE_STYLES);
      }
      
      [Inspectable(name="paddingRight",type="int")]
      public function get paddingRight() : int
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:int) : void
      {
         if(param1 == this._paddingRight)
         {
            return;
         }
         this._paddingRight = param1;
         invalidate(INVALIDATION_TYPE_STYLES);
      }
      
      [Inspectable(name="paddingBottom",type="int")]
      public function get paddingBottom() : int
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:int) : void
      {
         if(param1 == this._paddingBottom)
         {
            return;
         }
         this._paddingBottom = param1;
         invalidate(INVALIDATION_TYPE_STYLES);
      }
      
      [Inspectable(name="horizontalScrollStep",type="Number")]
      public function get horizontalScrollStep() : Number
      {
         return this._horizontalScrollStep;
      }
      
      public function set horizontalScrollStep(param1:Number) : void
      {
         if(param1 <= 0)
         {
            param1 = NaN;
         }
         if(param1 == this._horizontalScrollStep)
         {
            return;
         }
         this._horizontalScrollStep = param1;
         invalidate(INVALIDATION_TYPE_STYLES);
      }
      
      [Inspectable(name="verticalScrollStep",type="Number")]
      public function get verticalScrollStep() : Number
      {
         return this._verticalScrollStep;
      }
      
      public function set verticalScrollStep(param1:Number) : void
      {
         if(param1 <= 0)
         {
            param1 = NaN;
         }
         if(param1 == this._verticalScrollStep)
         {
            return;
         }
         this._verticalScrollStep = param1;
         invalidate(INVALIDATION_TYPE_STYLES);
      }
      
      public function get decelerationRate() : Number
      {
         return this._decelerationRate;
      }
      
      public function set decelerationRate(param1:Number) : void
      {
         if(param1 == this._decelerationRate)
         {
            return;
         }
         this._decelerationRate = param1;
         this._logDecelerationRate = Math.log(param1);
      }
      
      public function get mouseWheelDirection() : String
      {
         return this._mouseWheelDirection;
      }
      
      public function set mouseWheelDirection(param1:String) : void
      {
         this._mouseWheelDirection = param1;
      }
      
      public function get pageThrowDuration() : Number
      {
         return this._pageThrowDuration;
      }
      
      public function set pageThrowDuration(param1:Number) : void
      {
         this._pageThrowDuration = param1;
      }
      
      public function get velocityWeight() : Number
      {
         return this._velocityWeight;
      }
      
      public function set velocityWeight(param1:Number) : void
      {
         this._velocityWeight = param1;
      }
      
      public function get scrollConfig() : ScrollConfig
      {
         return this._scrollConfig;
      }
      
      public function set scrollConfig(param1:ScrollConfig) : void
      {
         this._scrollConfig = param1;
         this._velocityWeight = this._scrollConfig.velocityWeight;
         invalidate();
      }
      
      public function get maskOffsetLeft() : Number
      {
         return this._maskOffsetLeft;
      }
      
      public function set maskOffsetLeft(param1:Number) : void
      {
         this._maskOffsetLeft = param1;
      }
      
      public function get maskOffsetRight() : Number
      {
         return this._maskOffsetRight;
      }
      
      public function set maskOffsetRight(param1:Number) : void
      {
         this._maskOffsetRight = param1;
      }
      
      public function get maskOffsetTop() : Number
      {
         return this._maskOffsetTop;
      }
      
      public function set maskOffsetTop(param1:Number) : void
      {
         this._maskOffsetTop = param1;
      }
      
      public function get maskOffsetBottom() : Number
      {
         return this._maskOffsetBottom;
      }
      
      public function set maskOffsetBottom(param1:Number) : void
      {
         this._maskOffsetBottom = param1;
      }
      
      public function get useTimer() : Boolean
      {
         return this._useTimer;
      }
      
      public function set useTimer(param1:Boolean) : void
      {
         if(this._useTimer != param1)
         {
            this._useTimer = param1;
            if(param1)
            {
               this._timer = new Timer(INTERVAL_SPEED);
            }
            else
            {
               this._timer.stop();
               this._timer = null;
            }
         }
      }
      
      public function get mouseWheelEnabled() : Boolean
      {
         return _mouseWheelEnabled;
      }
      
      public function set mouseWheelEnabled(param1:Boolean) : void
      {
         _mouseWheelEnabled = param1;
         invalidate(INVALIDATION_TYPE_INTERACTION_MODE);
      }
      
      protected function get actualHorizontalScrollStep() : Number
      {
         var _loc1_:Number = this.horizontalScrollStep;
         if(_loc1_ !== _loc1_)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      protected function get actualVerticalScrollStep() : Number
      {
         var _loc1_:Number = this.verticalScrollStep;
         if(_loc1_ !== _loc1_)
         {
            _loc1_ = 1;
         }
         return _loc1_;
      }
      
      protected function get viewPortOffsetLeft() : int
      {
         return this._viewPortOffsetLeft;
      }
      
      protected function set viewPortOffsetLeft(param1:int) : void
      {
         this._viewPortOffsetLeft = param1;
      }
      
      protected function get viewPortOffsetRight() : int
      {
         return this._viewPortOffsetRight;
      }
      
      protected function set viewPortOffsetRight(param1:int) : void
      {
         this._viewPortOffsetRight = param1;
      }
      
      protected function get viewPortOffsetTop() : int
      {
         return this._viewPortOffsetTop;
      }
      
      protected function set viewPortOffsetTop(param1:int) : void
      {
         this._viewPortOffsetTop = param1;
      }
      
      protected function get viewPortOffsetBottom() : int
      {
         return this._viewPortOffsetBottom;
      }
      
      protected function set viewPortOffsetBottom(param1:int) : void
      {
         this._viewPortOffsetBottom = param1;
      }
      
      protected function get container() : DisplayObjectContainer
      {
         return this._container;
      }
      
      protected function get dStartDragX() : Number
      {
         return this._dStartDragX;
      }
      
      protected function set dStartDragX(param1:Number) : void
      {
         this._dStartDragX = param1;
      }
      
      protected function get dStartDragY() : Number
      {
         return this._dStartDragY;
      }
      
      protected function set dStartDragY(param1:Number) : void
      {
         this._dStartDragY = param1;
      }
      
      private function onUpdateHorizontalScrollTweenHandler(param1:Event) : void
      {
         var _loc6_:Number = NaN;
         var _loc2_:Number = getTimer() - this._horizontalTweenTime;
         var _loc3_:Number = _loc2_ / this._horizontalTweenDuration;
         _loc3_ = this.horizontalTweenEase(_loc3_);
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         var _loc4_:Number = this._startHorizontalScrollPosition + (this._targetHorizontalScrollPosition - this._startHorizontalScrollPosition) * _loc3_;
         var _loc5_:Boolean = !this._cropContent;
         if(_loc5_)
         {
            _loc6_ = this.horizontalScrollStep;
            if(_loc6_ === _loc6_)
            {
               _loc4_ = this.roundToNearest(_loc4_,_loc6_);
            }
         }
         this.horizontalScrollPosition = _loc4_;
         if(_loc4_ > this._startHorizontalScrollPosition && _loc4_ >= this._horizontalTweenEndValue || _loc4_ < this._startHorizontalScrollPosition && _loc4_ <= this._horizontalTweenEndValue)
         {
            if(!this._hasHorizontalElasticEdges)
            {
               if(this._horizontalScrollPosition < this._minHorizontalScrollPosition)
               {
                  this._horizontalScrollPosition = this._minHorizontalScrollPosition;
               }
               else if(this._horizontalScrollPosition > this._maxHorizontalScrollPosition)
               {
                  this._horizontalScrollPosition = this._maxHorizontalScrollPosition;
               }
            }
            this.killHorizontalScrollTween();
            this.finishHorizontalScroll();
         }
      }
      
      private function onUpdateVerticalScrollTweenHandler(param1:Event) : void
      {
         var _loc6_:Number = NaN;
         var _loc2_:Number = getTimer() - this._verticalTweenTime;
         var _loc3_:Number = _loc2_ / this._verticalTweenDuration;
         _loc3_ = this.verticalTweenEase(_loc3_);
         if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         var _loc4_:Number = this._startVerticalScrollPosition + (this._targetVerticalScrollPosition - this._startVerticalScrollPosition) * _loc3_;
         var _loc5_:Boolean = !this._cropContent;
         if(_loc5_)
         {
            _loc6_ = this.verticalScrollStep;
            if(_loc6_ === _loc6_)
            {
               _loc4_ = this.roundToNearest(_loc4_,_loc6_);
            }
         }
         this.verticalScrollPosition = _loc4_;
         if(_loc4_ > this._startVerticalScrollPosition && _loc4_ >= this._verticalTweenEndValue || _loc4_ < this._startVerticalScrollPosition && _loc4_ <= this._verticalTweenEndValue)
         {
            if(!this._hasVerticalElasticEdges)
            {
               if(this._verticalScrollPosition < this._minVerticalScrollPosition)
               {
                  this._verticalScrollPosition = this._minVerticalScrollPosition;
               }
               else if(this._verticalScrollPosition > this._maxVerticalScrollPosition)
               {
                  this._verticalScrollPosition = this._maxVerticalScrollPosition;
               }
            }
            this.killVerticalScrollTween();
            this.finishVerticalScroll();
         }
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         this.startScroll();
         this.handleMouseWheelEvent(param1);
      }
      
      private function handleMouseWheelEvent(param1:MouseEvent) : void
      {
         if(!this.isViewPortUnderMouse())
         {
            return;
         }
         var _loc2_:Number = param1.delta;
         if(this._scrollConfig.normalizeWheelScrollDelta)
         {
            _loc2_ = _loc2_ > 0 ? Number(1) : Number(-1);
         }
         this.scrollInDirection(_loc2_);
      }
      
      private function onViewPortResizeHandler(param1:Event) : void
      {
         invalidate(InvalidationType.SIZE);
      }
      
      private function onDragUpdateHandler(param1:Event) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(!this._touchEnabled)
         {
            return;
         }
         var _loc2_:int = getTimer();
         var _loc3_:Number = this.mouseX;
         var _loc4_:Number = this.mouseY;
         var _loc5_:int = _loc2_ - this._previousTouchTime;
         if(_loc5_ > 0)
         {
            _loc8_ = (_loc3_ - this._previousTouchX) / _loc5_;
            _loc9_ = (_loc4_ - this._previousTouchY) / _loc5_;
            _loc10_ = this._velocityLength;
            while(_loc10_ > 0)
            {
               this._velocityBufferX[_loc10_] = this._velocityBufferX[_loc10_ - 1];
               this._velocityBufferY[_loc10_] = this._velocityBufferY[_loc10_ - 1];
               _loc10_--;
            }
            this._velocityBufferX[0] = _loc8_;
            this._velocityBufferY[0] = _loc9_;
            ++this._velocityLength;
            if(this._velocityLength > VELOCITY_BUFFER_MAX_SIZE)
            {
               this._velocityLength = VELOCITY_BUFFER_MAX_SIZE;
            }
            this._previousTouchX = _loc3_;
            this._previousTouchY = _loc4_;
            this._previousTouchTime = _loc2_;
         }
         var _loc6_:Number = _loc3_ - this._startTouchX;
         var _loc7_:Number = _loc4_ - this._startTouchY;
         if(!this._isDraggingHorizontally && this._minHorizontalScrollPosition != this._maxHorizontalScrollPosition && Math.abs(_loc6_) > this._scrollConfig.minDragDistance)
         {
            this._startTouchX = _loc3_;
            this._isDraggingHorizontally = true;
         }
         if(!this._isDraggingVertically && this._minVerticalScrollPosition != this._maxVerticalScrollPosition && Math.abs(_loc7_) > this._scrollConfig.minDragDistance)
         {
            this._startTouchY = _loc4_;
            this._isDraggingVertically = true;
         }
         if(this._isDraggingHorizontally)
         {
            _loc11_ = this.clampScrollPosition(this._startHorizontalScrollPosition - _loc6_,this._minHorizontalScrollPosition,this._maxHorizontalScrollPosition,this.horizontalScrollStep,this._hasHorizontalElasticEdges,this._scrollConfig.elasticMaxDelta);
            this.horizontalScrollPosition += (_loc11_ - this.horizontalScrollPosition) / this._scrollConfig.throwAccelerationRate;
         }
         if(this._isDraggingVertically)
         {
            _loc12_ = this.clampScrollPosition(this._startVerticalScrollPosition - _loc7_,this._minVerticalScrollPosition,this._maxVerticalScrollPosition,this.verticalScrollStep,this._hasVerticalElasticEdges,this._scrollConfig.elasticMaxDelta);
            this.verticalScrollPosition += (_loc12_ - this.verticalScrollPosition) / this._scrollConfig.throwAccelerationRate;
         }
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            this.onStartDragging(param1.stageX,param1.stageY);
         }
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         if(this._isTouching)
         {
            this.completeTouchScroll();
         }
         else
         {
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         }
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         if(Math.abs(this._startDragX - param1.stageX) >= this._dStartDragX || Math.abs(this._startDragY - param1.stageY) >= this._dStartDragY)
         {
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
            this.initTouchScroll();
         }
      }
   }
}
