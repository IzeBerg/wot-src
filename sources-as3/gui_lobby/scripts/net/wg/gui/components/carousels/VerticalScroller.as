package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import net.wg.data.constants.Cursors;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import scaleform.clik.constants.InvalidationType;
   
   public class VerticalScroller extends TwoWayDirectionScroller implements IScroller
   {
       
      
      private var _measuredTypicalItemRendererHeight:int;
      
      public function VerticalScroller()
      {
         super();
      }
      
      override protected function layoutChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.layoutChildren();
         if(scrollbarRef != null && dataProvider != null && isInvalid(InvalidationType.DATA,InvalidationType.SIZE,INVALIDATION_TYPE_SCROLLBAR))
         {
            _loc1_ = this._measuredTypicalItemRendererHeight + verticalGap;
            _loc2_ = Math.ceil(dataProvider.length / columnCount) * _loc1_ - height - verticalGap + paddingTop + paddingBottom;
            scrollbarRef.setScrollProperties(height,0,_loc2_,_loc1_);
         }
         if(scrollbarRef != null && !scrollBarHandlingInProgress)
         {
            ignoreScrollBarHandler = true;
            scrollbarRef.position = verticalScrollPosition;
            ignoreScrollBarHandler = false;
         }
         scrollBarHandlingInProgress = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         dStartDragX = Number.MAX_VALUE;
         dStartDragY = D_START_DRAG;
         App.cursor.unRegisterDragging(cursorManager);
         App.cursor.registerDragging(cursorManager,Cursors.DRAG_CLOSE);
      }
      
      override protected function updateScrollPosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         if(isInvalid(INVALID_GO_TO_INDEX))
         {
            if(goToIndex >= 0)
            {
               _loc1_ = int(height / pageHeight * goToOffset) * pageHeight;
               _loc2_ = (goToIndex / columnCount ^ 0) * pageHeight - _loc1_;
               if(_loc2_ > maxVerticalScrollPosition)
               {
                  _loc2_ = maxVerticalScrollPosition;
               }
               else if(_loc2_ < minVerticalScrollPosition)
               {
                  _loc2_ = minVerticalScrollPosition;
               }
               if(scrollImmediately)
               {
                  setVerticalScrollPositionImmidiatly(_loc2_);
               }
               else if(scrollIfRendererVisible || verticalScrollPosition > _loc2_ || verticalScrollPosition + height <= _loc2_)
               {
                  startScroll();
                  throwToVerticalPosition(_loc2_,goToDuration);
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
            _loc1_ = maxVerticalScrollPosition != minVerticalScrollPosition && dataProvider.length;
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
      
      override protected function verticalTweenEase(param1:Number) : Number
      {
         if(equableScrolling)
         {
            return ACCELERATION * param1;
         }
         return super.verticalTweenEase(param1);
      }
      
      override protected function initTouchScroll() : void
      {
         if(maxVerticalScrollPosition != minVerticalScrollPosition)
         {
            super.initTouchScroll();
         }
      }
      
      override protected function refreshDataViewPortProperties() : void
      {
         super.refreshDataViewPortProperties();
         dataViewPort.columnCount = columnCount;
         this._measuredTypicalItemRendererHeight = dataViewPort.rendererHeight;
      }
      
      override protected function onEndScrollBarDrag() : void
      {
         finishVerticalScroll();
      }
      
      override protected function onEndScrollBarScroll() : void
      {
         throwToVerticalPosition(scrollbarRef.position,0);
      }
      
      override public function get viewPortClass() : Class
      {
         return VerticalScrollerViewPort;
      }
      
      [Inspectable(name="verticalScrollStep",type="Number")]
      override public function get verticalScrollStep() : Number
      {
         var _loc1_:Number = super.verticalScrollStep;
         if(snapScrollPositionToItemRendererSize && _loc1_ !== _loc1_)
         {
            _loc1_ = this._measuredTypicalItemRendererHeight;
         }
         return _loc1_;
      }
      
      override public function get availableScrollUp() : Boolean
      {
         return verticalScrollPosition > minVerticalScrollPosition;
      }
      
      override public function get availableScrollDown() : Boolean
      {
         return verticalScrollPosition < maxVerticalScrollPosition;
      }
   }
}
