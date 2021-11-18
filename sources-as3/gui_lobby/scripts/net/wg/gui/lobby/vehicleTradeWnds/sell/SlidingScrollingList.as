package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.interfaces.ISaleItemBlockRenderer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.interfaces.IScrollBar;
   import scaleform.clik.utils.Padding;
   
   public class SlidingScrollingList extends ScrollingList
   {
      
      private static const DOWN_MARGIN:int = 9;
      
      private static const SB_PADDING_X:int = 0;
      
      private static const SB_PADDING_Y:int = 10;
       
      
      public var lowerContainer:MovieClip = null;
      
      public var upperContainer:MovieClip = null;
      
      private var _listVisibleHeight:Number = 0;
      
      private var _scrRect:Rectangle = null;
      
      private var _stepSize:Number = 5;
      
      private var _totalHeight:Number = 0;
      
      public function SlidingScrollingList()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.destroyScrollBar();
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel);
         removeEventListener(InputEvent.INPUT,handleInput);
         this.lowerContainer = null;
         this.upperContainer = null;
         this._scrRect = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         if(container == null)
         {
            container = new Sprite();
            addChild(container);
         }
         tabEnabled = _focusable && enabled;
         tabChildren = false;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel,true,0,true);
         addEventListener(InputEvent.INPUT,handleInput,false,0,true);
         if(padding == null)
         {
            padding = new Padding();
         }
         if(_itemRenderer == null && !_usingExternalRenderers)
         {
            itemRendererName = _itemRendererName;
         }
         this.useHandCursor = false;
         this._scrRect = new Rectangle(0,0,_width,_height + DOWN_MARGIN >> 0);
         this.scrollRect = this._scrRect;
         this.upperContainer.mouseEnabled = false;
         this._listVisibleHeight = _height + DOWN_MARGIN;
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IListItemRenderer = null;
         var _loc4_:DisplayObject = null;
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
         }
         if(isInvalid(InvalidationType.RENDERERS))
         {
            _autoRowHeight = NaN;
         }
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            updateSelectedIndex();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               _newFrame = null;
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
                  _loc4_ = DisplayObject(_loc3_);
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
         if(!_usingExternalRenderers && (isInvalid(InvalidationType.SIZE) || isInvalid(InvalidationType.DATA)))
         {
            this.lowerContainer.removeChild(container);
            setActualSize(_width,_height);
            container.scaleX = 1 / scaleX;
            container.scaleY = 1 / scaleY;
            _totalRenderers = dataProvider.length;
            this.lowerContainer.addChild(container);
            invalidateData();
         }
         if(!_usingExternalRenderers && isInvalid(InvalidationType.RENDERERS,InvalidationType.SIZE))
         {
            drawRenderers(_totalRenderers);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            refreshData();
            this.updateScrollBar();
         }
      }
      
      override protected function updateScrollBar() : void
      {
         this._stepSize = Math.round(20 * this.height / this._totalHeight);
         var _loc1_:Number = Math.round(this.height / this._totalHeight * 100);
         if(_scrollBar == null)
         {
            return;
         }
         if(_scrollBar is ScrollIndicator)
         {
            (_scrollBar as ScrollIndicator).setScrollProperties(_loc1_,0,100,this._stepSize);
         }
         _scrollBar.position = _scrollPosition;
         _scrollBar.validateNow();
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
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = _scrollPosition + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_;
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
         this.drawLayout();
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function drawLayout() : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = 8;
         this._totalHeight = 0;
         var _loc3_:Number = margin + padding.left;
         var _loc4_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc1_)
         {
            _loc5_ = getRendererAt(_loc6_);
            _loc5_.x = _loc3_;
            if(_loc6_ == 0)
            {
               _loc5_.y = 0;
            }
            else
            {
               _loc5_.y = getRendererAt(_loc6_ - 1).y + getRendererAt(_loc6_ - 1).height + _loc2_;
            }
            this._totalHeight = _loc5_.y + _loc5_.height;
            if(!_loc4_)
            {
               _loc5_.validateNow();
            }
            _loc6_++;
         }
         if(this._totalHeight < this.height)
         {
            this.destroyScrollBar();
            _autoScrollBar = false;
            this._listVisibleHeight = this._totalHeight + DOWN_MARGIN;
            this._scrRect = new Rectangle(0,0,_width,this._listVisibleHeight);
            this.scrollRect = this._scrRect;
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.handleMouseWheel);
         }
         else
         {
            if(this._totalHeight > 0)
            {
               this._totalHeight += DOWN_MARGIN;
            }
            this.drawScrollBar();
         }
         if(this._totalHeight == 0)
         {
            this._listVisibleHeight = 0;
         }
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc5_ = getRendererAt(_loc7_);
            UIComponent(_loc5_).setSize(this.availableWidth,_loc5_.height);
            _loc7_++;
         }
         this.upperContainer.height = this._listVisibleHeight;
         dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.LIST_WAS_DRAWN,this._listVisibleHeight));
      }
      
      override protected function createScrollBar() : void
      {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         this.destroyScrollBar();
         if(!_scrollBarValue || _scrollBarValue == "")
         {
            return;
         }
         _autoScrollBar = false;
         if(_scrollBarValue is String)
         {
            if(parent != null)
            {
               _loc1_ = parent.getChildByName(_scrollBarValue.toString()) as IScrollBar;
            }
            if(_loc1_ == null)
            {
               _loc2_ = App.utils.classFactory.getClass(_scrollBarValue.toString());
               if(_loc2_)
               {
                  _loc1_ = App.utils.classFactory.getComponent(_scrollBarValue.toString(),IScrollBar) as IScrollBar;
               }
               if(_loc1_)
               {
                  _autoScrollBar = true;
                  _loc3_ = _loc1_ as Object;
                  if(_loc3_ && thumbOffset)
                  {
                     _loc3_.offsetTop = thumbOffset.top;
                     _loc3_.offsetBottom = thumbOffset.bottom;
                  }
                  _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,blockMouseWheel,false,0,true);
                  this.upperContainer.addChild(DisplayObject(_loc1_));
               }
            }
         }
         else if(_scrollBarValue is Class)
         {
            _loc1_ = IScrollBar(new (_scrollBarValue as Class)());
            _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,blockMouseWheel,false,0,true);
            if(_loc1_ != null)
            {
               _autoScrollBar = true;
               Object(_loc1_).offsetTop = thumbOffset.top;
               Object(_loc1_).offsetBottom = thumbOffset.bottom;
               this.upperContainer.addChild(DisplayObject(_loc1_));
            }
         }
         else
         {
            _loc1_ = _scrollBarValue as IScrollBar;
         }
         _scrollBar = _loc1_;
         invalidateSize();
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(Event.SCROLL,handleScroll,false,0,true);
            _loc1_.addEventListener(Event.CHANGE,handleScroll,false,0,true);
            _loc1_.focusTarget = this;
            _loc1_.tabEnabled = false;
         }
      }
      
      override protected function drawScrollBar() : void
      {
         if(!_autoScrollBar)
         {
            return;
         }
         _scrollBar.x = _width - _scrollBar.width - SB_PADDING_X;
         _scrollBar.y = SB_PADDING_Y;
         _scrollBar.height = availableHeight - (SB_PADDING_Y << 1);
         _scrollBar.validateNow();
      }
      
      override protected function scrollList(param1:int) : void
      {
         if(_scrollBar == null)
         {
            return;
         }
         _scrollBar.position -= param1 * this._stepSize;
         _scrollBar.validateNow();
      }
      
      public function getRenderers() : Vector.<ISaleItemBlockRenderer>
      {
         var _loc2_:IListItemRenderer = null;
         var _loc3_:Vector.<ISaleItemBlockRenderer> = null;
         var _loc4_:ISaleItemBlockRenderer = null;
         var _loc1_:Vector.<ISaleItemBlockRenderer> = new Vector.<ISaleItemBlockRenderer>();
         for each(_loc2_ in _renderers)
         {
            _loc3_ = SellDialogListItemRenderer(_loc2_).getRenderers();
            for each(_loc4_ in _loc3_)
            {
               _loc1_.push(_loc4_);
            }
         }
         return _loc1_;
      }
      
      private function destroyScrollBar() : void
      {
         var _loc1_:DisplayObject = null;
         if(_scrollBar)
         {
            _scrollBar.removeEventListener(Event.SCROLL,handleScroll,false);
            _scrollBar.removeEventListener(Event.CHANGE,handleScroll,false);
            _scrollBar.removeEventListener(MouseEvent.MOUSE_WHEEL,blockMouseWheel,false);
            _scrollBar.focusTarget = null;
            _loc1_ = DisplayObject(_scrollBar);
            if(this.upperContainer.contains(_loc1_))
            {
               _scrollBar.dispose();
               this.upperContainer.removeChild(_loc1_);
            }
            _scrollBar = null;
         }
      }
      
      override public function get availableWidth() : Number
      {
         return Math.round(_width) - (margin << 1) - (!!_autoScrollBar ? Math.round(_scrollBar.width + SB_PADDING_X) : 0);
      }
      
      override public function get scrollPosition() : Number
      {
         return _scrollPosition;
      }
      
      override public function set scrollPosition(param1:Number) : void
      {
         var _loc3_:IListItemRenderer = null;
         var _loc4_:Vector.<ISaleItemBlockRenderer> = null;
         var _loc5_:ISaleItemBlockRenderer = null;
         var _loc2_:Number = Math.round((this._totalHeight - this._height) / 100 * param1);
         container.y = -_loc2_;
         for each(_loc3_ in _renderers)
         {
            _loc4_ = SellDialogListItemRenderer(_loc3_).getRenderers();
            for each(_loc5_ in _loc4_)
            {
               SaleItemBlockRenderer(_loc5_).ddm.close();
            }
         }
      }
      
      override protected function handleMouseWheel(param1:MouseEvent) : void
      {
         if(App.contextMenuMgr.isShown())
         {
            return;
         }
         if(!(param1.target is DropdownMenu))
         {
            this.scrollList(param1.delta > 0 ? int(1) : int(-1));
            param1.stopImmediatePropagation();
         }
      }
   }
}
