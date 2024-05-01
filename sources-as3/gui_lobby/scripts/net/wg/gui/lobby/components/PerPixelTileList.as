package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.TileList;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Padding;
   
   public class PerPixelTileList extends TileList
   {
      
      private static const SCROLL_SIZE_INV:String = "invalidateScrollSize";
       
      
      private var _mask:Sprite = null;
      
      private var _maskPadding:Padding = null;
      
      private var _maxSize:int = 0;
      
      private var _maxDifSize:int = 0;
      
      private var _scrollStepFactor:int = 0;
      
      private var _visibleRows:int = 0;
      
      private var _visibleColumns:int = 0;
      
      private var _isResetScrollPositionAfterUpdateData:Boolean = true;
      
      public function PerPixelTileList()
      {
         super();
      }
      
      override public function getRendererAt(param1:uint, param2:int = 0) : IListItemRenderer
      {
         if(_renderers == null)
         {
            return null;
         }
         if(param1 >= _renderers.length)
         {
            return null;
         }
         return _renderers[param1] as IListItemRenderer;
      }
      
      override public function scrollToIndex(param1:uint) : void
      {
         if(_totalRenderers == 0)
         {
            return;
         }
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         if(_direction == DirectionMode.HORIZONTAL)
         {
            _loc2_ = columnWidth + padding.right;
            _loc3_ = param1 / this._visibleRows >> 0;
            _loc4_ = this._visibleColumns * _loc2_;
         }
         else
         {
            _loc2_ = rowHeight + padding.bottom;
            _loc3_ = param1 / this._visibleColumns >> 0;
            _loc4_ = this._visibleRows * _loc2_;
         }
         var _loc5_:Number = _loc3_ * _loc2_;
         if(_loc5_ - scrollPosition >= 0 && _loc5_ - scrollPosition < _loc4_)
         {
            return;
         }
         if(_loc5_ - scrollPosition < 0)
         {
            this.scrollPosition = _loc5_;
         }
         else
         {
            this.scrollPosition = _loc5_ - _loc4_ + _loc2_;
         }
      }
      
      override protected function draw() : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:IListItemRenderer = null;
         var _loc7_:DisplayObject = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
         }
         var _loc1_:Boolean = isInvalid(InvalidationType.RENDERERS);
         var _loc2_:Boolean = isInvalid(InvalidationType.SIZE);
         if(_loc1_)
         {
            _autoRowHeight = NaN;
            _autoColumnWidth = NaN;
            if(_usingExternalRenderers)
            {
               _totalColumns = externalColumnCount == 0 ? uint(1) : uint(externalColumnCount);
               _totalRows = Math.ceil(_renderers.length / _totalColumns);
            }
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.updateSelectedIndex();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
            }
            if(_baseDisposed)
            {
               return;
            }
         }
         var _loc3_:Boolean = isInvalid(InvalidationType.DATA);
         if(_loc3_ || !_usingExternalRenderers && _loc1_)
         {
            if(_renderers != null)
            {
               _loc5_ = _renderers.length;
               _loc4_ = 0;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = this.getRendererAt(_loc4_);
                  cleanUpRenderer(_loc6_);
                  _loc7_ = _loc6_ as DisplayObject;
                  App.utils.asserter.assertNotNull(_loc7_,"displayObject" + Errors.CANT_NULL);
                  if(container.contains(_loc7_))
                  {
                     container.removeChild(_loc7_);
                  }
                  _loc4_++;
               }
            }
            _renderers = new Vector.<IListItemRenderer>();
            _loc3_ = true;
         }
         if(_loc3_ || !_usingExternalRenderers && _loc2_)
         {
            removeChild(container);
            setActualSize(_width,_height);
            container.scaleX = 1 / scaleX;
            container.scaleY = 1 / scaleY;
            _totalRenderers = this.calculateRendererTotal(availableWidth,availableHeight);
            addChild(container);
            invalidateData();
         }
         if(isInvalid(SCROLL_SIZE_INV))
         {
            this.calculateMaxSize();
            if(!_loc3_)
            {
               this.updateScrollBar();
            }
         }
         if(_loc3_ || !_usingExternalRenderers && (_loc1_ || _loc2_))
         {
            drawRenderers(_totalRenderers);
            drawLayout();
            this.refreshData();
         }
         if(_loc3_)
         {
            this.updateScrollBar();
         }
         if(background)
         {
            background.visible = showBackground;
         }
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         _totalRenderers = Boolean(dataProvider) ? uint(dataProvider.length) : uint(0);
         if(_totalRenderers)
         {
            this._visibleRows = (availableHeight + (padding.vertical << 1)) / (rowHeight + padding.bottom) >> 0;
            this._visibleColumns = (availableWidth + (padding.horizontal << 1)) / (columnWidth + padding.right) >> 0;
            if(_direction == DirectionMode.VERTICAL)
            {
               _totalColumns = this._visibleColumns;
               _totalRows = Math.ceil(_totalRenderers / _totalColumns);
            }
            else
            {
               _totalRows = this._visibleRows;
               _totalColumns = Math.ceil(_totalRenderers / _totalRows);
            }
         }
         else
         {
            _totalColumns = 0;
            _totalRows = 0;
         }
         invalidate(SCROLL_SIZE_INV);
         return _totalRenderers;
      }
      
      override protected function refreshData() : void
      {
         selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex);
         this.updateSelectedIndex();
         _dataProvider.requestItemRange(0,_totalRenderers,this.populateData);
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:ListData = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(_baseDisposed)
            {
               return;
            }
            _loc5_ = this.getRendererAt(_loc4_);
            _loc6_ = new ListData(_loc4_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc4_);
            _loc5_.setListData(_loc6_);
            _loc5_.setData(param1[_loc4_]);
            if(_loc4_ >= _loc2_)
            {
               _loc5_.enabled = false;
            }
            else if(param1[_loc4_].hasOwnProperty("enabled"))
            {
               _loc5_.enabled = param1[_loc4_].enabled;
            }
            else
            {
               _loc5_.enabled = true;
            }
            _loc5_.validateNow();
            if(!showEmptyItems)
            {
               UIComponent(_loc5_).visible = param1[_loc4_] != null;
            }
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function updateScrollBar() : void
      {
         var _loc2_:ScrollIndicator = null;
         if(_scrollBar == null)
         {
            return;
         }
         var _loc1_:int = _dataProvider.length;
         if(smartScrollBar)
         {
            DisplayObject(_scrollBar).visible = this._maxDifSize > 0;
         }
         else
         {
            DisplayObject(_scrollBar).visible = _loc1_ > 0;
         }
         if(_scrollBar is ScrollIndicator)
         {
            _loc2_ = _scrollBar as ScrollIndicator;
            _loc2_.setScrollProperties(this._maxSize,0,this._maxDifSize,this._scrollStepFactor);
         }
         if(this._isResetScrollPositionAfterUpdateData)
         {
            this.scrollPosition = 0;
         }
         else
         {
            _scrollPosition = Math.max(0,Math.min(this._maxDifSize,Math.round(scrollPosition)));
            this.updateListPosition();
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._mask)
         {
            this.mask = null;
            this._mask = null;
         }
         this._maskPadding = null;
         super.onDispose();
      }
      
      override protected function scrollList(param1:int) : void
      {
         super.scrollList(param1 * this._scrollStepFactor);
      }
      
      override protected function updateSelectedIndex() : void
      {
         if(_selectedIndex == _newSelectedIndex)
         {
            return;
         }
         if(_totalRenderers == 0)
         {
            return;
         }
         var _loc1_:IListItemRenderer = this.getRendererAt(_selectedIndex,scrollPosition);
         if(_loc1_ != null)
         {
            if(!_loc1_.selectable)
            {
               return;
            }
            _loc1_.selected = false;
            _loc1_.validateNow();
         }
         _selectedIndex = _newSelectedIndex;
         dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE,true,false,_selectedIndex,-1,-1,this.getRendererAt(_selectedIndex),dataProvider.requestItemAt(_selectedIndex)));
         if(_selectedIndex < 0 || _selectedIndex >= _dataProvider.length)
         {
            return;
         }
         _loc1_ = this.getRendererAt(_selectedIndex,scrollPosition);
         if(_loc1_ != null)
         {
            _loc1_.selected = true;
            _loc1_.validateNow();
            this.scrollToIndex(_selectedIndex);
         }
      }
      
      override protected function createScrollBar() : void
      {
         super.createScrollBar();
         if(_scrollBar == null)
         {
            return;
         }
         _scrollBar.isSmooth = true;
      }
      
      public function resetScrollBarPosition() : void
      {
         this.scrollPosition = 0;
      }
      
      public function setMask(param1:Sprite, param2:Padding) : void
      {
         this._mask = param1;
         this.mask = this._mask;
         this._mask.mouseEnabled = false;
         this._mask.mouseChildren = false;
         this._maskPadding = param2;
         invalidate(SCROLL_SIZE_INV);
      }
      
      private function calculateMaxSize() : void
      {
         if(this._mask)
         {
            if(_direction == DirectionMode.HORIZONTAL)
            {
               this._maxSize = _totalColumns * (columnWidth + padding.horizontal) + margin + padding.horizontal;
               this._maxDifSize = this._maxSize - (this._mask.width - this._maskPadding.horizontal);
               this._scrollStepFactor = columnWidth >> 1;
            }
            else
            {
               this._maxSize = _totalRows * (rowHeight + padding.vertical) + margin - padding.vertical;
               this._maxDifSize = this._maxSize - (this._mask.height - this._maskPadding.vertical);
               this._scrollStepFactor = rowHeight >> 1;
            }
         }
      }
      
      private function updateListPosition() : void
      {
         if(_direction == DirectionMode.HORIZONTAL)
         {
            container.x = -_scrollPosition;
         }
         else
         {
            container.y = -_scrollPosition;
         }
         this.updateScrollPosition();
      }
      
      private function updateScrollPosition() : void
      {
         _scrollBar.position = _scrollPosition;
         _scrollBar.validateNow();
      }
      
      override public function set scrollPosition(param1:Number) : void
      {
         param1 = Math.max(0,Math.min(this._maxDifSize,Math.round(param1)));
         if(_scrollPosition == param1)
         {
            return;
         }
         _scrollPosition = param1;
         this.updateListPosition();
      }
      
      public function set isResetScrollPositionAfterUpdateData(param1:Boolean) : void
      {
         this._isResetScrollPositionAfterUpdateData = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:IListItemRenderer = this.getRendererAt(_selectedIndex,_scrollPosition);
         if(_loc2_ != null)
         {
            _loc2_.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         var _loc3_:InputDetails = param1.details;
         var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
         var _loc5_:int = int.MIN_VALUE;
         var _loc6_:String = _loc3_.navEquivalent;
         if(_direction == DirectionMode.HORIZONTAL)
         {
            switch(_loc6_)
            {
               case NavigationCode.RIGHT:
                  _loc5_ = _selectedIndex + this._visibleRows;
                  break;
               case NavigationCode.LEFT:
                  _loc5_ = _selectedIndex - this._visibleRows;
                  break;
               case NavigationCode.UP:
                  _loc5_ = _selectedIndex - 1;
                  break;
               case NavigationCode.DOWN:
                  _loc5_ = _selectedIndex + 1;
            }
         }
         else
         {
            switch(_loc6_)
            {
               case NavigationCode.DOWN:
                  _loc5_ = _selectedIndex + this._visibleColumns;
                  break;
               case NavigationCode.UP:
                  _loc5_ = _selectedIndex - this._visibleColumns;
                  break;
               case NavigationCode.LEFT:
                  _loc5_ = _selectedIndex - 1;
                  break;
               case NavigationCode.RIGHT:
                  _loc5_ = _selectedIndex + 1;
            }
         }
         if(_loc5_ == int.MIN_VALUE)
         {
            switch(_loc6_)
            {
               case NavigationCode.HOME:
                  _loc5_ = 0;
                  break;
               case NavigationCode.END:
                  _loc5_ = _dataProvider.length - 1;
                  break;
               case NavigationCode.PAGE_DOWN:
                  _loc5_ = Math.min(_dataProvider.length - 1,_selectedIndex + this._visibleColumns * this._visibleRows);
                  break;
               case NavigationCode.PAGE_UP:
                  _loc5_ = Math.max(0,_selectedIndex - this._visibleColumns * this._visibleRows);
            }
         }
         if(_loc5_ != int.MIN_VALUE)
         {
            if(!_loc4_)
            {
               param1.handled = true;
               return;
            }
            if(_loc5_ >= 0 && _loc5_ < dataProvider.length)
            {
               selectedIndex = Math.max(0,Math.min(_dataProvider.length - 1,_loc5_));
               param1.handled = true;
            }
            else if(wrapping == WrappingMode.STICK)
            {
               _loc5_ = Math.max(0,Math.min(_dataProvider.length - 1,_loc5_));
               if(selectedIndex != _loc5_)
               {
                  selectedIndex = _loc5_;
               }
               param1.handled = true;
            }
            else if(wrapping == WrappingMode.WRAP)
            {
               selectedIndex = _loc5_ < 0 ? int(_dataProvider.length - 1) : (selectedIndex < _dataProvider.length - 1 ? int(_dataProvider.length - 1) : int(0));
               param1.handled = true;
            }
         }
      }
   }
}
