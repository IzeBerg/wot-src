package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   
   public class VerticalScrollerViewPort extends ScrollerViewPort
   {
       
      
      public function VerticalScrollerViewPort()
      {
         super();
      }
      
      override protected function resize() : void
      {
         super.resize();
         var _loc1_:Number = typicalRendererHeight * (dataCount / columnCount) - verticalGap;
         if(_height !== _loc1_ || _width !== visibleWidth)
         {
            _height = _loc1_;
            _width = visibleWidth;
            if(hasEventListener(Event.RESIZE))
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function getLeftIndex() : int
      {
         var _loc1_:int = (verticalScrollPosition / typicalRendererHeight ^ 0) * columnCount;
         return Math.max(0,_loc1_);
      }
      
      override protected function getRightIndex(param1:int = 0) : int
      {
         var _loc2_:int = param1 + Math.ceil((visibleHeight + verticalGap) / typicalRendererHeight) * columnCount + columnCount;
         return Math.min(dataCount,_loc2_);
      }
      
      override protected function updateDataCount() : void
      {
         super.updateDataCount();
         var _loc1_:int = Math.ceil((visibleHeight + verticalGap) / typicalRendererHeight) * columnCount;
         if(dataProvider != null && dataProvider.length > _loc1_)
         {
            dataCount = dataProvider.length;
         }
         else
         {
            dataCount = _loc1_;
         }
         var _loc2_:int = dataCount % columnCount;
         if(_loc2_ != 0)
         {
            dataCount += columnCount - _loc2_;
         }
      }
      
      override protected function layoutRenderer(param1:IScrollerItemRenderer) : void
      {
         super.layoutRenderer(param1);
         param1.x = (columnCount + param1.index) % columnCount * typicalRendererWidth;
         param1.y = startGap + (param1.index / columnCount ^ 0) * typicalRendererHeight;
      }
      
      override public function set verticalScrollPosition(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 != verticalScrollPosition)
         {
            super.verticalScrollPosition = param1;
            _loc2_ = param1 / typicalRendererHeight ^ 0;
            if(leftVisibleIndex != _loc2_)
            {
               leftVisibleIndex = _loc2_;
               invalidate(INVALIDATE_LAYOUT_RENDERER);
            }
         }
      }
      
      override public function get validHeight() : Number
      {
         var _loc1_:uint = 0;
         if(dataProvider != null && dataProvider.length > 0)
         {
            _loc1_ = Math.ceil(dataProvider.length / columnCount);
            return startGap + (rendererHeight + verticalGap) * _loc1_ - verticalGap + endGap;
         }
         return height;
      }
   }
}
