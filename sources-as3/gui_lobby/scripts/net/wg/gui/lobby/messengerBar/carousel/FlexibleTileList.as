package net.wg.gui.lobby.messengerBar.carousel
{
   import flash.events.Event;
   import net.wg.gui.components.controls.TileList;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class FlexibleTileList extends TileList
   {
       
      
      public var maxRendererWidth:uint = 130;
      
      public var minRendererWidth:uint = 90;
      
      public function FlexibleTileList()
      {
         super();
      }
      
      public static function getAvailableItemWidth(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:uint = param1 * param3;
         if(_loc6_ > param4)
         {
            _loc7_ = param1 * param2;
            if(_loc7_ > param4)
            {
               _loc8_ = param4 / param2;
               _loc5_ = param4 / _loc8_ >> 0;
            }
            else
            {
               _loc5_ = param4 / param1 >> 0;
            }
         }
         else
         {
            _loc5_ = param3;
         }
         return _loc5_;
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         super.calculateRendererTotal(param1,param2);
         _totalRows = availableHeight / (rowHeight + paddingBottom) >> 0;
         var _loc3_:Number = availableWidth;
         _autoColumnWidth = getAvailableItemWidth(Boolean(_dataProvider) ? int(_dataProvider.length) : int(0),this.minRendererWidth,this.maxRendererWidth,_loc3_);
         _totalColumns = _loc3_ / _autoColumnWidth >> 0;
         _totalRenderers = _totalRows * _totalColumns;
         return _totalRenderers;
      }
      
      override protected function handleDataChange(param1:Event) : void
      {
         super.handleDataChange(param1);
         invalidateSize();
      }
      
      override protected function drawLayout() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = Boolean(_renderers) ? uint(_renderers.length) : uint(0);
         var _loc2_:Boolean = isInvalid(InvalidationType.DATA);
         if(_loc1_ > 0)
         {
            _loc3_ = rowHeight;
            _loc4_ = 0;
            _loc5_ = margin + padding.left;
            _loc6_ = _loc1_ - int(availableWidth - _loc1_ * _autoColumnWidth);
            _loc7_ = 0;
            while(_loc7_ < _loc1_)
            {
               _loc8_ = getRendererAt(_loc7_);
               if(_autoColumnWidth < this.maxRendererWidth && _loc7_ >= _loc6_)
               {
                  _loc4_ = _autoColumnWidth + 1;
               }
               else
               {
                  _loc4_ = _autoColumnWidth;
               }
               _loc8_.width = _loc4_;
               if(direction == DirectionMode.HORIZONTAL)
               {
                  _loc8_.y = _loc7_ % _totalRows * (_loc3_ + paddingBottom + padding.bottom) + margin + padding.top;
                  _loc8_.x = _loc5_;
                  _loc5_ += _loc4_;
               }
               if(!_loc2_)
               {
                  _loc8_.validateNow();
               }
               _loc7_++;
            }
         }
         drawScrollBar();
      }
   }
}
