package net.wg.gui.components.controls
{
   import flash.events.Event;
   import net.wg.gui.events.ListEventEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ResizableTileList extends TileList
   {
      
      private static const ROTATION_VERTICAL:Number = 0;
      
      private static const ROTATION_HORIZONTAL:Number = -90;
       
      
      public function ResizableTileList()
      {
         super();
      }
      
      override protected function drawScrollBar() : void
      {
         if(!_autoScrollBar)
         {
            return;
         }
         var _loc1_:ScrollIndicator = _scrollBar as ScrollIndicator;
         _loc1_.direction = _direction;
         if(_direction == DirectionMode.VERTICAL)
         {
            _loc1_.rotation = ROTATION_VERTICAL;
            _loc1_.x = _width - _loc1_.width + margin;
            _loc1_.y = margin;
            _loc1_.height = availableHeight + padding.vertical;
         }
         else
         {
            _loc1_.rotation = ROTATION_HORIZONTAL;
            _loc1_.x = margin;
            _loc1_.y = _height - _loc1_.height + margin;
            _loc1_.width = availableWidth + padding.horizontal;
         }
         _scrollBar.validateNow();
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         var _loc5_:IListItemRenderer = null;
         var _loc3_:Boolean = isNaN(_rowHeight) && isNaN(_autoRowHeight);
         var _loc4_:Boolean = isNaN(_columnWidth) && isNaN(_autoColumnWidth);
         if(_loc3_ || _loc4_)
         {
            _loc5_ = createRenderer(0);
            if(_loc3_)
            {
               _autoRowHeight = _loc5_.height;
            }
            if(_loc4_)
            {
               _autoColumnWidth = _loc5_.width;
            }
            cleanUpRenderer(_loc5_);
         }
         _totalColumns = availableWidth / columnWidth >> 0;
         _totalRenderers = Boolean(_dataProvider) ? uint(_dataProvider.length) : uint(0);
         _totalRows = Math.ceil(_totalRenderers / _totalColumns);
         return _totalRenderers;
      }
      
      override protected function drawLayout() : void
      {
         var _loc1_:IListItemRenderer = null;
         super.drawLayout();
         if(_renderers != null && _renderers.length > 0)
         {
            _loc1_ = getRendererAt(_renderers.length - 1);
            removeChild(container);
            setActualSize(_width,_loc1_.height + _loc1_.y + margin + paddingBottom);
            container.scaleY = 1 / scaleY;
            addChild(container);
         }
         dispatchEvent(new Event(Event.RESIZE,true));
      }
      
      public function getActualRenderersCount() : uint
      {
         return _totalRenderers;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(_dataProvider == param1)
         {
            return;
         }
         super.dataProvider = param1;
         invalidateSize();
      }
      
      override protected function populateData(param1:Array) : void
      {
         super.populateData(param1);
         if(!_baseDisposed)
         {
            dispatchEvent(new ListEventEx(ListEventEx.UPDATE_COMPLETE));
         }
      }
   }
}
