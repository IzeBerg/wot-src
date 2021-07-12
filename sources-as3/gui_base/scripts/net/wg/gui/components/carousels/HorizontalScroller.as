package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import scaleform.clik.constants.InvalidationType;
   
   public class HorizontalScroller extends TwoWayDirectionScroller implements IScroller
   {
       
      
      private var _measuredTypicalItemRendererWidth:int;
      
      private var _expectTargetPosition:Number = 0;
      
      public function HorizontalScroller()
      {
         super();
      }
      
      override public function startScrollToBegin() : void
      {
         var _loc1_:Number = NaN;
         if(this.availableScrollLeft)
         {
            if(!scrollToBegin)
            {
               this._expectTargetPosition = horizontalScrollPosition - pageWidth;
            }
            else
            {
               this._expectTargetPosition -= pageWidth;
            }
            _loc1_ = horizontalScrollPosition / pageWidth;
            throwToHorizontalPosition(minHorizontalScrollPosition,pageThrowDuration * _loc1_);
         }
         super.startScrollToBegin();
      }
      
      override public function startScrollToEnd() : void
      {
         var _loc1_:Number = NaN;
         if(this.availableScrollRight)
         {
            if(!scrollToEnd)
            {
               this._expectTargetPosition = horizontalScrollPosition + pageWidth;
            }
            else
            {
               this._expectTargetPosition += pageWidth;
            }
            _loc1_ = (maxHorizontalScrollPosition - horizontalScrollPosition) / pageWidth;
            throwToHorizontalPosition(maxHorizontalScrollPosition,pageThrowDuration * _loc1_);
         }
         super.startScrollToEnd();
      }
      
      override public function stopScroll() : void
      {
         if(scrollToBegin)
         {
            if(this._expectTargetPosition > horizontalScrollPosition)
            {
               throwToHorizontalPosition(roundDownToNearest(horizontalScrollPosition,pageWidth),pageThrowDuration);
            }
            else
            {
               throwToHorizontalPosition(roundDownToNearest(this._expectTargetPosition,pageWidth),pageThrowDuration);
            }
            equableScrolling = false;
            scrollToBegin = false;
         }
         if(scrollToEnd)
         {
            if(this._expectTargetPosition < horizontalScrollPosition)
            {
               throwToHorizontalPosition(roundUpToNearest(horizontalScrollPosition,pageWidth),pageThrowDuration);
            }
            else
            {
               throwToHorizontalPosition(roundUpToNearest(this._expectTargetPosition,pageWidth),pageThrowDuration);
            }
            equableScrolling = false;
            scrollToEnd = false;
         }
      }
      
      override protected function layoutChildren() : void
      {
         var _loc1_:int = 0;
         super.layoutChildren();
         if(scrollbarRef != null && dataProvider != null && isInvalid(InvalidationType.DATA,InvalidationType.SIZE,INVALIDATION_TYPE_SCROLLBAR))
         {
            _loc1_ = Math.ceil(dataProvider.length / columnCount) * this._measuredTypicalItemRendererWidth - width - horizontalGap;
            if(usesLayoutController())
            {
               _loc1_ = maxHorizontalScrollPosition;
            }
            scrollbarRef.setScrollProperties(width,0,_loc1_,this._measuredTypicalItemRendererWidth);
         }
         if(scrollbarRef != null && !scrollBarHandlingInProgress)
         {
            ignoreScrollBarHandler = true;
            scrollbarRef.position = horizontalScrollPosition;
            ignoreScrollBarHandler = false;
         }
         scrollBarHandlingInProgress = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         dStartDragX = D_START_DRAG;
         dStartDragY = Number.MAX_VALUE;
      }
      
      override protected function updateScrollPosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         if(isInvalid(INVALID_GO_TO_INDEX))
         {
            if(goToIndex >= 0)
            {
               _loc1_ = int(width / pageWidth * goToOffset) * pageWidth;
               _loc2_ = (goToIndex / rowCount ^ 0) * pageWidth - _loc1_;
               if(_loc2_ > maxHorizontalScrollPosition)
               {
                  _loc2_ = maxHorizontalScrollPosition;
               }
               else if(_loc2_ < minHorizontalScrollPosition)
               {
                  _loc2_ = minHorizontalScrollPosition;
               }
               if(scrollImmediately)
               {
                  throwToHorizontalPosition(_loc2_,0);
               }
               else if(scrollIfRendererVisible || horizontalScrollPosition > _loc2_ || horizontalScrollPosition + width <= _loc2_)
               {
                  startScroll();
                  throwToHorizontalPosition(_loc2_,goToDuration);
               }
            }
         }
         super.updateScrollPosition();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.SIZE,InvalidationType.DATA,INVALIDATION_TYPE_LAYOUT,INVALIDATION_TYPE_PENDING_SCROLL))
         {
            _loc1_ = maxHorizontalScrollPosition != minHorizontalScrollPosition && dataProvider.length;
            cursorManager.enable = _loc1_;
            if(scrollbarRef != null)
            {
               scrollbarRef.visible = _loc1_;
            }
            if(hasEventListener(Event.RESIZE))
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function horizontalTweenEase(param1:Number) : Number
      {
         if(equableScrolling)
         {
            return ACCELERATION * param1;
         }
         return super.horizontalTweenEase(param1);
      }
      
      override protected function initTouchScroll() : void
      {
         if(maxHorizontalScrollPosition != minHorizontalScrollPosition)
         {
            super.initTouchScroll();
         }
      }
      
      override protected function refreshDataViewPortProperties() : void
      {
         super.refreshDataViewPortProperties();
         dataViewPort.rowCount = rowCount;
         this._measuredTypicalItemRendererWidth = dataViewPort.rendererWidth + dataViewPort.horizontalGap;
      }
      
      override protected function onEndScrollBarDrag() : void
      {
         finishHorizontalScroll();
      }
      
      override protected function onEndScrollBarScroll() : void
      {
         throwToHorizontalPosition(scrollbarRef.position,0);
      }
      
      override public function get viewPortClass() : Class
      {
         return HorizontalScrollerViewPort;
      }
      
      [Inspectable(name="horizontalScrollStep",type="Number")]
      override public function get horizontalScrollStep() : Number
      {
         var _loc1_:Number = super.horizontalScrollStep;
         if(snapScrollPositionToItemRendererSize && _loc1_ !== _loc1_)
         {
            _loc1_ = this._measuredTypicalItemRendererWidth;
         }
         return _loc1_;
      }
      
      override public function get availableScrollLeft() : Boolean
      {
         return horizontalScrollPosition > minHorizontalScrollPosition;
      }
      
      override public function get availableScrollRight() : Boolean
      {
         return horizontalScrollPosition < maxHorizontalScrollPosition;
      }
   }
}
