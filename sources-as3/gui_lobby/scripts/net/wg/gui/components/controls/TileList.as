package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.controls.TileList;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.utils.Padding;
   
   public class TileList extends scaleform.clik.controls.TileList
   {
       
      
      [Inspectable(defaultValue="true")]
      public var showEmptyItems:Boolean;
      
      [Inspectable(defaultValue="true")]
      public var showBackground:Boolean = true;
      
      public var background:Sprite = null;
      
      [Inspectable(type="Number")]
      public var paddingBottom:Number = 0;
      
      [Inspectable(type="Number")]
      public var paddingRight:Number = 0;
      
      protected var _scrollBarPadding:Padding;
      
      private var _smartScrollBar:Boolean = true;
      
      public function TileList()
      {
         super();
         componentInspectorSetting = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.scrollBarPadding == null)
         {
            this.scrollBarPadding = new Padding();
         }
      }
      
      override protected function updateSelectedIndex() : void
      {
         var _loc1_:IListItemRenderer = getRendererAt(_newSelectedIndex,scrollPosition);
         if(_loc1_ != null)
         {
            if(!_loc1_.selectable)
            {
               return;
            }
         }
         super.updateSelectedIndex();
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:uint = 0;
         var _loc7_:ListData = null;
         var _loc2_:uint = param1.length;
         var _loc3_:uint = _renderers.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(_baseDisposed)
            {
               return;
            }
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _scrollPosition * (_direction == DirectionMode.HORIZONTAL ? _totalRows : _totalColumns) + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.setListData(_loc7_);
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
            if(!this.showEmptyItems)
            {
               UIComponent(_loc5_).visible = param1[_loc4_] != null;
            }
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function drawLayout() : void
      {
         var _loc6_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = columnWidth;
         var _loc4_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc1_)
         {
            _loc6_ = getRendererAt(_loc5_);
            if(direction == DirectionMode.HORIZONTAL)
            {
               _loc6_.y = _loc5_ % _totalRows * (_loc2_ + padding.bottom) + margin + padding.top;
               _loc6_.x = (_loc5_ / _totalRows >> 0) * (_loc3_ + padding.right) + margin + padding.left;
            }
            else
            {
               _loc6_.x = _loc5_ % _totalColumns * (_loc3_ + padding.right) + margin + padding.left;
               _loc6_.y = (_loc5_ / _totalColumns >> 0) * (_loc2_ + padding.bottom) + margin + padding.top;
            }
            if(!_loc4_)
            {
               _loc6_.validateNow();
            }
            _loc5_++;
         }
         this.drawScrollBar();
      }
      
      override protected function drawScrollBar() : void
      {
         var _loc1_:ScrollIndicator = null;
         if(!_autoScrollBar)
         {
            return;
         }
         _loc1_ = _scrollBar as ScrollIndicator;
         App.utils.asserter.assertNotNull(_loc1_,"sb" + Errors.CANT_NULL);
         _loc1_.direction = _direction;
         if(_direction == DirectionMode.VERTICAL)
         {
            _loc1_.rotation = 0;
            _loc1_.x = _width - _loc1_.width - this.scrollBarPadding.right;
            _loc1_.y = this.scrollBarPadding.top;
            _loc1_.height = availableHeight - this.scrollBarPadding.vertical;
         }
         else
         {
            _loc1_.rotation = -90;
            _loc1_.x = this.scrollBarPadding.left;
            _loc1_.y = _height - this.scrollBarPadding.bottom;
            _loc1_.width = availableWidth + this.scrollBarPadding.horizontal;
         }
         _scrollBar.validateNow();
      }
      
      override protected function onDispose() : void
      {
         this.background = null;
         this._scrollBarPadding = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            createScrollBar();
         }
         if(isInvalid(InvalidationType.RENDERERS))
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
         if(!_usingExternalRenderers && isInvalid(InvalidationType.RENDERERS))
         {
            if(_renderers != null)
            {
               _loc2_ = _renderers.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = getRendererAt(_loc1_);
                  cleanUpRenderer(_loc3_);
                  _loc4_ = _loc3_ as DisplayObject;
                  App.utils.asserter.assertNotNull(_loc4_,"displayObject" + Errors.CANT_NULL);
                  if(container.contains(_loc4_))
                  {
                     container.removeChild(_loc4_);
                  }
                  _loc1_++;
               }
            }
            _renderers = new Vector.<IListItemRenderer>();
            invalidateData();
         }
         if(!_usingExternalRenderers && isInvalid(InvalidationType.SIZE))
         {
            removeChild(container);
            setActualSize(_width,_height);
            container.scaleX = 1 / scaleX;
            container.scaleY = 1 / scaleY;
            _totalRenderers = this.calculateRendererTotal(availableWidth,availableHeight);
            addChild(container);
            invalidateData();
         }
         if(!_usingExternalRenderers && isInvalid(InvalidationType.RENDERERS,InvalidationType.SIZE))
         {
            drawRenderers(_totalRenderers);
            this.drawLayout();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            refreshData();
            if(_baseDisposed)
            {
               return;
            }
            this.updateScrollBar();
         }
         if(this.background)
         {
            this.background.visible = this.showBackground;
         }
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         super.calculateRendererTotal(param1,param2);
         _totalRows = (availableHeight + 2 * padding.vertical) / (rowHeight + padding.bottom) >> 0;
         _totalColumns = (availableWidth + 2 * padding.horizontal) / (columnWidth + padding.right) >> 0;
         _totalRenderers = _totalRows * _totalColumns;
         return _totalRenderers;
      }
      
      override protected function updateScrollBar() : void
      {
         var _loc2_:Number = NaN;
         if(_scrollBar == null)
         {
            return;
         }
         super.updateScrollBar();
         var _loc1_:int = _dataProvider.length;
         if(direction == DirectionMode.HORIZONTAL)
         {
            _loc2_ = Math.ceil(_loc1_ / _totalRows) - _totalColumns;
         }
         else
         {
            _loc2_ = Math.ceil(_loc1_ / _totalColumns) - _totalRows;
         }
         if(this._smartScrollBar)
         {
            DisplayObject(_scrollBar).visible = _loc2_ > 0;
         }
         else
         {
            DisplayObject(_scrollBar).visible = _loc1_ > 0;
         }
         if(_loc2_ > 0)
         {
            if(_scrollBar is ScrollIndicator)
            {
               ScrollIndicator(_scrollBar).setScrollProperties(_direction == DirectionMode.HORIZONTAL ? Number(_totalColumns) : Number(_totalRows),0,_loc2_);
            }
            _scrollBar.position = _scrollPosition;
            _scrollBar.validateNow();
         }
      }
      
      public function get scrollBarPadding() : Padding
      {
         return this._scrollBarPadding;
      }
      
      public function set scrollBarPadding(param1:Padding) : void
      {
         this._scrollBarPadding = param1;
         invalidateSize();
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="scrollBarPadding")]
      public function set inspectableScrollBarPadding(param1:Object) : void
      {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.scrollBarPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      public function get smartScrollBar() : Boolean
      {
         return this._smartScrollBar;
      }
      
      public function set smartScrollBar(param1:Boolean) : void
      {
         this._smartScrollBar = param1;
      }
   }
}
