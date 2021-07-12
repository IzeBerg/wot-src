package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   
   public class HorizontalScrollerViewPort extends ScrollerViewPort
   {
       
      
      public function HorizontalScrollerViewPort()
      {
         super();
      }
      
      override protected function resize() : void
      {
         var _loc2_:Point = null;
         super.resize();
         var _loc1_:Number = typicalRendererWidth * (dataCount / rowCount) - horizontalGap;
         if(usesLayoutController())
         {
            _loc2_ = layoutController.getMaxExtents();
            _loc1_ = _loc2_.x;
         }
         if(_width !== _loc1_ || _height !== visibleHeight)
         {
            _width = _loc1_;
            _height = visibleHeight;
            if(hasEventListener(Event.RESIZE))
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function layoutRenderer(param1:IScrollerItemRenderer) : void
      {
         super.layoutRenderer(param1);
         param1.x = (param1.index / rowCount ^ 0) * typicalRendererWidth;
         param1.y = param1.index % rowCount * typicalRendererHeight;
      }
      
      override protected function getLeftIndex() : int
      {
         var _loc1_:int = (horizontalScrollPosition / typicalRendererWidth ^ 0) * rowCount;
         return Math.max(0,_loc1_);
      }
      
      override protected function getRightIndex(param1:int = 0) : int
      {
         if(usesLayoutController())
         {
            return layoutController.getRightIndex(param1);
         }
         var _loc2_:int = param1 + Math.ceil((visibleWidth + horizontalGap) / typicalRendererWidth) * rowCount + rowCount;
         return Math.min(dataCount,_loc2_);
      }
      
      override protected function updateDataCount() : void
      {
         super.updateDataCount();
         var _loc1_:int = Math.ceil((visibleWidth + horizontalGap) / typicalRendererWidth) * rowCount;
         if(dataProvider != null && dataProvider.length > _loc1_)
         {
            dataCount = dataProvider.length;
         }
         else
         {
            dataCount = _loc1_;
         }
         var _loc2_:int = dataCount % rowCount;
         if(_loc2_ != 0)
         {
            dataCount += rowCount - _loc2_;
         }
      }
      
      override public function set horizontalScrollPosition(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 != horizontalScrollPosition)
         {
            super.horizontalScrollPosition = param1;
            _loc2_ = param1 / typicalRendererWidth ^ 0;
            if(leftVisibleIndex != _loc2_)
            {
               leftVisibleIndex = _loc2_;
               invalidate(INVALIDATE_LAYOUT_RENDERER);
            }
         }
      }
      
      override public function get validWidth() : Number
      {
         var _loc1_:uint = 0;
         if(dataProvider != null && dataProvider.length > 0)
         {
            _loc1_ = Math.ceil(dataProvider.length / rowCount);
            return startGap + (rendererWidth + horizontalGap) * _loc1_ - horizontalGap + endGap;
         }
         return width;
      }
   }
}
