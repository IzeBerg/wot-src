package net.wg.gui.lobby.vehicleCustomization
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.components.carousels.interfaces.IScrollerLayoutController;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselArrowVO;
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
      
      private static const GAP_WITH_SEPARATOR_MULTIPLIER:int = 3;
       
      
      private var _scrollList:IScroller = null;
      
      private var _itemLayouts:Vector.<Rectangle>;
      
      private var _bookmarkLayouts:Vector.<Rectangle>;
      
      private var _separatorsLayouts:Vector.<Point>;
      
      private var _itemLayoutSize:Vector.<Boolean>;
      
      private var _bookmarkData:Vector.<CustomizationCarouselBookmarkVO>;
      
      private var _arrowsData:Dictionary;
      
      private var _showSeparators:Boolean = false;
      
      private var _layoutValid:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function CustomizationCarouselLayoutController(param1:IScroller)
      {
         this._itemLayouts = new Vector.<Rectangle>();
         this._bookmarkLayouts = new Vector.<Rectangle>();
         this._separatorsLayouts = new Vector.<Point>();
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
         this._separatorsLayouts.splice(0,this._separatorsLayouts.length);
         this._separatorsLayouts = null;
         this._scrollList = null;
         this._itemLayoutSize = null;
         this._bookmarkData = null;
         this._arrowsData = null;
      }
      
      public function generateLayout() : void
      {
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:CustomizationCarouselArrowVO = null;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         this._itemLayouts.splice(0,this._itemLayouts.length);
         this._bookmarkLayouts.splice(0,this._bookmarkLayouts.length);
         this._separatorsLayouts.splice(0,this._separatorsLayouts.length);
         if(this._itemLayoutSize == null)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = this._scrollList.horizontalGap;
         var _loc3_:int = -_loc2_;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Point = null;
         var _loc7_:uint = this._itemLayoutSize.length;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = _loc8_ > 0;
            _loc10_ = this._itemLayoutSize[_loc8_];
            _loc4_ = CustomizationShared.computeItemSize(_loc10_,App.appHeight < MIN_RESOLUTION);
            _loc11_ = this.testForBookmark(_loc8_,_loc1_);
            if(_loc11_)
            {
               _loc5_ = this.computeBookmarkItem(_loc3_,_loc4_.width,_loc9_);
               this._bookmarkLayouts.push(_loc5_);
               if(this._showSeparators && _loc9_)
               {
                  _loc6_ = this.computeSeparatorItem(_loc3_);
                  this._separatorsLayouts.push(_loc6_);
               }
               _loc3_ += this.getBookmarkGap(_loc9_);
               _loc1_++;
            }
            _loc4_.offset(_loc3_,0);
            this._itemLayouts.push(_loc4_);
            _loc12_ = this.testForArrow(_loc8_);
            if(_loc12_)
            {
               _loc12_.position = this.computeArrowItem(_loc4_.right,_loc4_.height);
            }
            _loc3_ = _loc4_.right + _loc2_;
            _loc8_++;
         }
         _loc3_ -= _loc2_;
         if(this._itemLayouts.length > 0)
         {
            _loc13_ = _loc3_ - this._itemLayouts[0].x;
            if(_loc13_ < this._scrollList.width)
            {
               _loc14_ = (this._scrollList.width - _loc13_ >> 1) - this._itemLayouts[0].x;
               if(_loc14_ > FILTER_OFFSET_X)
               {
                  _loc14_ -= FILTER_OFFSET_X;
               }
               for each(_loc4_ in this._itemLayouts)
               {
                  _loc4_.offset(_loc14_,0);
               }
               for each(_loc5_ in this._bookmarkLayouts)
               {
                  _loc5_.offset(_loc14_,0);
               }
               for each(_loc6_ in this._separatorsLayouts)
               {
                  _loc6_.offset(_loc14_,0);
               }
               for each(_loc12_ in this._arrowsData)
               {
                  _loc12_.position.offset(_loc14_,0);
               }
            }
         }
         this._layoutValid = true;
      }
      
      public function getArrowsLayout() : Dictionary
      {
         if(!this._layoutValid)
         {
            this.generateLayout();
         }
         return this._arrowsData;
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
      
      public function getSeparatorsLayout() : Vector.<Point>
      {
         if(!this._layoutValid)
         {
            this.generateLayout();
         }
         return this._separatorsLayouts;
      }
      
      public function invalidateData() : void
      {
         this._layoutValid = false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setData(param1:CustomizationCarouselDataVO) : void
      {
         this._itemLayoutSize = param1.itemLayoutSize;
         this._bookmarkData = param1.bookmarks;
         this._arrowsData = param1.arrows;
         this._showSeparators = param1.showSeparators;
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
      
      private function testForArrow(param1:int) : CustomizationCarouselArrowVO
      {
         if(this._arrowsData && this._arrowsData[param1])
         {
            return this._arrowsData[param1];
         }
         return null;
      }
      
      private function computeBookmarkItem(param1:Number, param2:int, param3:Boolean) : Rectangle
      {
         var _loc4_:Rectangle = new Rectangle();
         _loc4_.width = param2 - BOOK_MARK_WIDTH_OFFSET;
         _loc4_.x = param1 + this.getBookmarkGap(param3) + BOOK_MARK_HORIZONTAL_SHIFT;
         _loc4_.y = BOOK_MARK_VERTICAL_SHIFT;
         return _loc4_;
      }
      
      private function computeSeparatorItem(param1:Number) : Point
      {
         var _loc2_:Point = new Point();
         _loc2_.x = param1 + this._scrollList.horizontalGap;
         return _loc2_;
      }
      
      private function computeArrowItem(param1:Number, param2:int) : Point
      {
         var _loc3_:Point = new Point();
         _loc3_.x = param1;
         _loc3_.y = param2 >> 1;
         return _loc3_;
      }
      
      private function getBookmarkGap(param1:Boolean = false) : int
      {
         var _loc2_:int = this._scrollList.horizontalGap;
         if(param1)
         {
            _loc2_ *= !!this._showSeparators ? GAP_WITH_SEPARATOR_MULTIPLIER : 1;
         }
         return _loc2_;
      }
   }
}
