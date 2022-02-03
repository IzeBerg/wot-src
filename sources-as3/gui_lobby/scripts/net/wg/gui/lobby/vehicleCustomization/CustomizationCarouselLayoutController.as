package net.wg.gui.lobby.vehicleCustomization
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.components.carousels.interfaces.IScrollerLayoutController;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselBookmarkVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselDataVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationCarouselLayoutController implements IScrollerLayoutController, IDisposable
   {
      
      private static const BOOK_MARK_WIDTH_OFFSET:int = -3;
      
      private static const FILTER_OFFSET_X:int = 40;
      
      private static const BOOK_MARK_HORIZONTAL_SHIFT:int = -3;
      
      private static const BOOK_MARK_VERTICAL_SHIFT:int = -23;
      
      private static const MIN_RESOLUTION:int = 900;
       
      
      private var _scrollList:IScroller = null;
      
      private var _itemLayouts:Vector.<Rectangle>;
      
      private var _bookmarkLayouts:Vector.<Rectangle>;
      
      private var _itemLayoutSize:Vector.<Boolean>;
      
      private var _bookmarkData:Vector.<CustomizationCarouselBookmarkVO>;
      
      private var _layoutValid:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function CustomizationCarouselLayoutController(param1:IScroller)
      {
         this._itemLayouts = new Vector.<Rectangle>();
         this._bookmarkLayouts = new Vector.<Rectangle>();
         this._itemLayoutSize = new Vector.<Boolean>();
         super();
         this._scrollList = param1;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._itemLayouts.splice(0,this._itemLayouts.length);
         this._itemLayouts = null;
         this._bookmarkLayouts.splice(0,this._bookmarkLayouts.length);
         this._bookmarkLayouts = null;
         this._scrollList = null;
         this._itemLayoutSize.splice(0,this._itemLayoutSize.length);
         this._itemLayoutSize = null;
         this._bookmarkData.splice(0,this._bookmarkData.length);
         this._bookmarkData = null;
      }
      
      public function generateLayout() : void
      {
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         this._itemLayouts.splice(0,this._itemLayouts.length);
         this._bookmarkLayouts.splice(0,this._bookmarkLayouts.length);
         if(this._itemLayoutSize == null)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = this._scrollList.horizontalGap;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:uint = this._itemLayoutSize.length;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = this._itemLayoutSize[_loc7_];
            _loc4_ = CustomizationShared.computeItemSize(_loc8_,App.appHeight < MIN_RESOLUTION);
            _loc9_ = this.testForBookmark(_loc7_,_loc1_);
            if(_loc9_)
            {
               _loc5_ = this.computeBookmarkItem(_loc2_,_loc4_.width);
               this._bookmarkLayouts.push(_loc5_);
               _loc2_ += _loc3_;
               _loc1_++;
            }
            _loc4_.offset(_loc2_,0);
            this._itemLayouts.push(_loc4_);
            _loc2_ = _loc4_.right + _loc3_;
            _loc7_++;
         }
         _loc2_ -= _loc3_;
         if(this._itemLayouts.length > 0)
         {
            _loc10_ = _loc2_ - this._itemLayouts[0].x;
            if(_loc10_ < this._scrollList.width)
            {
               _loc11_ = (this._scrollList.width - _loc10_ >> 1) - this._itemLayouts[0].x;
               if(_loc11_ > FILTER_OFFSET_X)
               {
                  _loc11_ -= FILTER_OFFSET_X;
               }
               for each(_loc4_ in this._itemLayouts)
               {
                  _loc4_.offset(_loc11_,0);
               }
               for each(_loc5_ in this._bookmarkLayouts)
               {
                  _loc5_.offset(_loc11_,0);
               }
            }
         }
         this._layoutValid = true;
      }
      
      public function getBookmarksLayout() : Vector.<Rectangle>
      {
         if(!this._layoutValid)
         {
            this.generateLayout();
         }
         return this._bookmarkLayouts;
      }
      
      public function getLayout() : Vector.<Rectangle>
      {
         if(!this._layoutValid)
         {
            this.generateLayout();
         }
         return this._itemLayouts;
      }
      
      public function getLeftIndex(param1:int) : int
      {
         if(this._itemLayoutSize == null)
         {
            return 0;
         }
         if(this._itemLayoutSize.length != this._itemLayouts.length || !this._layoutValid)
         {
            this.generateLayout();
         }
         if(this._itemLayouts.length <= 0)
         {
            return 0;
         }
         var _loc2_:int = Math.min(param1,this._itemLayouts.length - 1);
         var _loc3_:int = this._scrollList.viewPort.horizontalScrollPosition;
         while(_loc2_ > 0 && this._itemLayouts[_loc2_].right > _loc3_)
         {
            _loc2_--;
         }
         while(_loc2_ < this._itemLayouts.length - 1 && this._itemLayouts[_loc2_].right <= _loc3_)
         {
            _loc2_++;
         }
         return int(Math.max(0,_loc2_));
      }
      
      public function getMaxExtents() : Point
      {
         if(this._itemLayouts.length == 0)
         {
            return new Point(0,0);
         }
         var _loc1_:Rectangle = this._itemLayouts[this._itemLayouts.length - 1];
         var _loc2_:Point = new Point();
         _loc2_.x = _loc1_.right;
         _loc2_.y = _loc1_.bottom;
         return _loc2_;
      }
      
      public function getRightIndex(param1:int) : int
      {
         if(this._itemLayoutSize == null || this._itemLayoutSize.length != this._itemLayouts.length || this._itemLayouts.length == 0)
         {
            return -1;
         }
         var _loc2_:int = param1;
         var _loc3_:int = this._scrollList.viewPort.horizontalScrollPosition + this._scrollList.viewPort.visibleWidth;
         while(_loc2_ < this._itemLayouts.length && this._itemLayouts[_loc2_].left <= _loc3_)
         {
            _loc2_++;
         }
         return int(Math.min(this._itemLayouts.length,_loc2_ + 1));
      }
      
      public function invalidateData() : void
      {
         this._layoutValid = false;
      }
      
      public function setData(param1:CustomizationCarouselDataVO) : void
      {
         this._itemLayoutSize = param1.itemLayoutSize;
         this._bookmarkData = param1.bookmarks;
         this._layoutValid = false;
      }
      
      private function testForBookmark(param1:int, param2:int) : Boolean
      {
         if(param2 >= this._bookmarkData.length || this._bookmarkData.length < 2)
         {
            return false;
         }
         var _loc3_:CustomizationCarouselBookmarkVO = this._bookmarkData[param2];
         return _loc3_.bookmarkIndex == param1;
      }
      
      private function computeBookmarkItem(param1:Number, param2:int) : Rectangle
      {
         var _loc3_:Rectangle = new Rectangle();
         _loc3_.width = param2 - BOOK_MARK_WIDTH_OFFSET;
         _loc3_.x = param1 + this._scrollList.horizontalGap + BOOK_MARK_HORIZONTAL_SHIFT;
         _loc3_.y = BOOK_MARK_VERTICAL_SHIFT;
         return _loc3_;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
