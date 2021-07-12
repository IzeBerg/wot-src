package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.gui.components.controls.listselection.ListSelectionDirection;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.controls.ScrollIndicator;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.interfaces.IScrollBar;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Padding;
   
   [Event(name="itemReleaseOutside",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemDragOut",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemDragOver",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemDoubleClick",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemRollOut",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemRollOver",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemPress",type="net.wg.gui.events.ListEventEx")]
   [Event(name="itemClick",type="net.wg.gui.events.ListEventEx")]
   [Event(name="change",type="flash.events.Event")]
   public class ScrollingListEx extends CoreListEx
   {
       
      
      [Inspectable(defaultValue="stick",enumeration="normal,stick,wrap")]
      public var wrapping:String = "stick";
      
      public var thumbOffset:Object = null;
      
      public var thumbSizeFactor:Number = 1;
      
      [Inspectable(defaultValue="0",name="gap",type="Number",verbose="1")]
      public var _gap:Number = 0;
      
      protected var _rowHeight:Number = NaN;
      
      protected var _autoRowHeight:Number = NaN;
      
      protected var _scrollPosition:uint = 0;
      
      protected var _scrollBarValue:Object;
      
      protected var _margin:Number = 0;
      
      protected var _padding:Padding;
      
      protected var _widthAutoResize:Boolean = true;
      
      protected var _scrollBar:IScrollBar;
      
      private var _autoScrollBar:Boolean = false;
      
      private var _sbPadding:Padding;
      
      private var _smartScrollBar:Boolean = false;
      
      private var _selectionNavigator:AbstractListSelectionNavigator = null;
      
      private var _enableKeyboardInput:Boolean = true;
      
      public function ScrollingListEx()
      {
         super();
         if(this.sbPadding == null)
         {
            this.sbPadding = new Padding(0,0,0,0);
         }
      }
      
      override public function scrollToIndex(param1:uint) : void
      {
         if(_totalRenderers == 0)
         {
            return;
         }
         if(param1 >= this._scrollPosition && param1 < this._scrollPosition + _totalRenderers)
         {
            return;
         }
         if(param1 < this._scrollPosition)
         {
            this.scrollPosition = param1;
         }
         else
         {
            this.scrollPosition = param1 - (_totalRenderers - 1);
         }
      }
      
      override public function toString() : String
      {
         return "[WG ScrollingListEx " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.padding == null)
         {
            this.padding = new Padding();
         }
         if(_itemRenderer == null && !_usingExternalRenderers)
         {
            itemRendererName = _itemRendererName;
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.createScrollBar();
            this.updateVisibleScrollBar();
         }
         if(isInvalid(InvalidationType.RENDERERS))
         {
            this._autoRowHeight = NaN;
         }
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateScrollBar();
         }
      }
      
      override protected function drawLayout() : void
      {
         var _loc8_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = this.rowHeight;
         var _loc3_:Number = this.availableWidth - this.padding.horizontal;
         var _loc4_:Number = this.margin + this.padding.left;
         var _loc5_:Number = this.margin + this.padding.top;
         var _loc6_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc8_ = getRendererAt(_loc7_);
            _loc8_.x = Math.round(_loc4_);
            _loc8_.y = Math.round(_loc5_ + _loc7_ * _loc2_);
            _loc8_.width = _loc3_;
            if(this._gap == 0)
            {
               _loc8_.height = _loc2_;
            }
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         this.drawScrollBar();
      }
      
      override protected function changeFocus() : void
      {
         super.changeFocus();
         var _loc1_:IListItemRenderer = getRendererAt(_selectedIndex,this._scrollPosition);
         if(_loc1_ != null)
         {
            _loc1_.displayFocus = focused > 0;
            _loc1_.validateNow();
         }
      }
      
      override protected function refreshData() : void
      {
         this._scrollPosition = Math.min(Math.max(0,_dataProvider.length - _totalRenderers),this._scrollPosition);
         _dataProvider.requestItemRange(this._scrollPosition,Math.min(_dataProvider.length - 1,this._scrollPosition + _totalRenderers - 1),this.populateData);
         if(_baseDisposed)
         {
            return;
         }
         this.selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex);
         this.updateSelectedIndex();
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
         var _loc1_:IListItemRenderer = getRendererAt(_selectedIndex,this.scrollPosition);
         if(_loc1_ != null)
         {
            this.selectedRenderer(_loc1_,false);
         }
         super.selectedIndex = _newSelectedIndex;
         if(_dataProvider == null || _selectedIndex < 0 || _selectedIndex >= _dataProvider.length)
         {
            return;
         }
         _loc1_ = getRendererAt(_selectedIndex,this._scrollPosition);
         if(_loc1_ != null)
         {
            this.selectedRenderer(_loc1_,true);
         }
         else
         {
            this.scrollToIndex(_selectedIndex);
            _loc1_ = getRendererAt(_selectedIndex,this.scrollPosition);
            this.selectedRenderer(_loc1_,true);
         }
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         var _loc3_:IListItemRenderer = null;
         if(isNaN(this._rowHeight) && isNaN(this._autoRowHeight))
         {
            _loc3_ = createRenderer(0);
            this._autoRowHeight = Math.round(_loc3_.height - this._gap);
            cleanUpRenderer(_loc3_);
         }
         return (this.availableHeight - this.padding.vertical) / this.rowHeight >> 0;
      }
      
      override protected function scrollList(param1:int) : void
      {
         this.scrollPosition -= param1;
      }
      
      override protected function onDispose() : void
      {
         this._scrollBarValue = null;
         this._padding = null;
         this._sbPadding = null;
         this.destroyScrollBar();
         if(this._selectionNavigator != null)
         {
            this._selectionNavigator.dispose();
            this._selectionNavigator = null;
         }
         this.thumbOffset = null;
         super.onDispose();
      }
      
      public function getSelectedVO() : Object
      {
         var _loc1_:Object = null;
         if(_selectedIndex > -1)
         {
            _loc1_ = _dataProvider.requestItemAt(_selectedIndex);
         }
         return _loc1_;
      }
      
      public function setSelectionNavigator(param1:AbstractListSelectionNavigator) : void
      {
         if(this._selectionNavigator == param1)
         {
            return;
         }
         this._selectionNavigator = param1;
         if(this._selectionNavigator)
         {
            this._selectionNavigator.dataProvider = _dataProvider;
         }
      }
      
      protected function updateVisibleScrollBar() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:IListItemRenderer = null;
         if(this._scrollBar)
         {
            _loc1_ = DisplayObject(this._scrollBar);
            if(this._smartScrollBar)
            {
               if(_dataProvider && _dataProvider.length > 0)
               {
                  _loc1_.visible = _dataProvider.length > _totalRenderers;
               }
               else
               {
                  _loc1_.visible = false;
               }
               if(this._widthAutoResize)
               {
                  _loc2_ = isInvalid(InvalidationType.DATA);
                  if(_loc1_.visible)
                  {
                     _loc3_ = this.availableWidth;
                  }
                  else
                  {
                     _loc3_ = Math.round(_width) - (this.margin << 1) - this.padding.horizontal;
                  }
                  for each(_loc4_ in _renderers)
                  {
                     _loc4_.width = _loc3_;
                     if(!_loc2_)
                     {
                        _loc4_.validateNow();
                     }
                  }
               }
               if(_loc1_ && container.contains(_loc1_))
               {
                  container.setChildIndex(_loc1_,container.numChildren - 1);
               }
            }
            else
            {
               _loc1_.visible = true;
            }
         }
      }
      
      protected function createScrollBar() : void
      {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         this.destroyScrollBar();
         if(!this._scrollBarValue || this._scrollBarValue == "")
         {
            return;
         }
         this._autoScrollBar = false;
         if(this._scrollBarValue is String)
         {
            if(parent != null)
            {
               _loc1_ = parent.getChildByName(this._scrollBarValue.toString()) as IScrollBar;
            }
            if(_loc1_ == null)
            {
               _loc2_ = App.utils.classFactory.getClass(this._scrollBarValue.toString());
               if(_loc2_)
               {
                  _loc1_ = IScrollBar(App.utils.classFactory.getComponent(this._scrollBarValue.toString(),IScrollBar));
               }
               if(_loc1_)
               {
                  this._autoScrollBar = true;
                  _loc3_ = _loc1_ as Object;
                  if(_loc3_ && this.thumbOffset)
                  {
                     _loc3_.offsetTop = this.thumbOffset.top;
                     _loc3_.offsetBottom = this.thumbOffset.bottom;
                  }
                  _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollMouseWheelHandler,false,0,true);
                  container.addChild(DisplayObject(_loc1_));
               }
            }
         }
         else if(this._scrollBarValue is Class)
         {
            _loc1_ = IScrollBar(new Class(this._scrollBarValue)());
            _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollMouseWheelHandler,false,0,true);
            this._autoScrollBar = true;
            Object(_loc1_).offsetTop = this.thumbOffset.top;
            Object(_loc1_).offsetBottom = this.thumbOffset.bottom;
            container.addChild(DisplayObject(_loc1_));
         }
         else
         {
            _loc1_ = this._scrollBarValue as IScrollBar;
         }
         this._scrollBar = _loc1_;
         invalidateSize();
         if(this._scrollBar == null)
         {
            return;
         }
         this._scrollBar.addEventListener(Event.SCROLL,this.onScrollBarChangeHandler,false,0,true);
         this._scrollBar.addEventListener(Event.CHANGE,this.onScrollBarChangeHandler,false,0,true);
         this._scrollBar.focusTarget = this;
         this._scrollBar.tabEnabled = false;
      }
      
      protected function drawScrollBar() : void
      {
         if(!this._autoScrollBar)
         {
            return;
         }
         this._scrollBar.x = _width - this._scrollBar.width - this.margin - this.sbPadding.left;
         this._scrollBar.y = this.margin + this.sbPadding.top;
         this._scrollBar.height = this.availableHeight - this.sbPadding.vertical;
         this._scrollBar.validateNow();
         this.updateVisibleScrollBar();
      }
      
      protected function updateScrollBar() : void
      {
         var _loc1_:ScrollIndicator = null;
         if(this._scrollBar == null)
         {
            return;
         }
         if(_dataProvider && this._scrollBar is ScrollIndicator)
         {
            _loc1_ = ScrollIndicator(this._scrollBar);
            if(_dataProvider.length > _totalRenderers)
            {
               _loc1_.setScrollProperties(_totalRenderers,0,_dataProvider.length - _totalRenderers);
            }
            else
            {
               _loc1_.setScrollProperties(_dataProvider.length - _totalRenderers,0,_dataProvider.length - _totalRenderers);
            }
         }
         this._scrollBar.position = this._scrollPosition;
         this._scrollBar.validateNow();
         this.updateVisibleScrollBar();
      }
      
      protected function selectedRenderer(param1:IListItemRenderer, param2:Boolean) : void
      {
         param1.selected = param2;
         param1.validateNow();
      }
      
      protected function populateData(param1:Array) : void
      {
         var _loc5_:IListItemRenderer = null;
         var _loc6_:int = 0;
         var _loc7_:ListData = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = _renderers.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_baseDisposed)
            {
               return;
            }
            _loc5_ = getRendererAt(_loc4_);
            _loc6_ = this._scrollPosition + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ < _loc2_;
            _loc5_.setListData(_loc7_);
            this.externalSetupRenderer(_loc5_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      protected function externalSetupRenderer(param1:IListItemRenderer) : void
      {
      }
      
      protected function navigateSelection(param1:int, param2:ListSelectionDirection) : void
      {
         if(this._selectionNavigator == null)
         {
            this.selectedIndex = param1;
         }
         else
         {
            param1 = this._selectionNavigator.navigate(param1,param2,this.isKeyScrollingRecurrent());
            if(param1 != -1)
            {
               this.selectedIndex = param1;
            }
         }
      }
      
      protected function isKeyScrollingRecurrent() : Boolean
      {
         return this.wrapping == WrappingMode.WRAP;
      }
      
      private function destroyScrollBar() : void
      {
         var _loc1_:DisplayObject = null;
         if(this._scrollBar)
         {
            this._scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarChangeHandler,false);
            this._scrollBar.removeEventListener(Event.CHANGE,this.onScrollBarChangeHandler,false);
            this._scrollBar.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onScrollMouseWheelHandler,false);
            this._scrollBar.focusTarget = null;
            _loc1_ = DisplayObject(this._scrollBar);
            if(container.contains(_loc1_))
            {
               this._scrollBar.dispose();
               container.removeChild(_loc1_);
            }
            this._scrollBar = null;
         }
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         }
         super.dataProvider = param1;
         if(this._selectionNavigator != null)
         {
            this._selectionNavigator.dataProvider = param1;
         }
         if(_dataProvider)
         {
            _dataProvider.addEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         }
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         if(param1 == _selectedIndex || param1 == _newSelectedIndex)
         {
            return;
         }
         _newSelectedIndex = param1;
         invalidateSelectedIndex();
      }
      
      override public function get availableWidth() : Number
      {
         return Math.round(_width) - (this.margin << 1) - (!!this._autoScrollBar ? Math.round(this._scrollBar.width) + this.sbPadding.horizontal : 0);
      }
      
      override public function get availableHeight() : Number
      {
         return Math.round(_height) - (this.margin << 1);
      }
      
      [Inspectable(defaultValue="true",name="buttonModeEnabled",type="Boolean")]
      public function get buttonModeEnabled() : Boolean
      {
         return true;
      }
      
      public function set buttonModeEnabled(param1:Boolean) : void
      {
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="sbPadding")]
      public function set inspectableSbPadding(param1:Object) : void
      {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.sbPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      [Inspectable(defaultValue="0")]
      public function get margin() : Number
      {
         return this._margin;
      }
      
      public function set margin(param1:Number) : void
      {
         this._margin = param1;
         invalidateSize();
      }
      
      public function get padding() : Padding
      {
         return this._padding;
      }
      
      public function set padding(param1:Padding) : void
      {
         this._padding = param1;
         invalidateSize();
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="padding")]
      public function set inspectablePadding(param1:Object) : void
      {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.padding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      [Inspectable(type="String")]
      public function get scrollBar() : Object
      {
         return this._scrollBar;
      }
      
      public function set scrollBar(param1:Object) : void
      {
         this._scrollBarValue = param1;
         invalidate(InvalidationType.SCROLL_BAR);
      }
      
      [Inspectable(defaultValue="false",name="smartScrollBar")]
      public function get smartScrollBar() : Boolean
      {
         return this._smartScrollBar;
      }
      
      public function set smartScrollBar(param1:Boolean) : void
      {
         this._smartScrollBar = param1;
         this.updateVisibleScrollBar();
      }
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         param1 = Boolean(_dataProvider) ? Number(Math.max(0,Math.min(_dataProvider.length - _totalRenderers,Math.round(param1)))) : Number(0);
         if(this._scrollPosition == param1)
         {
            return;
         }
         this._scrollPosition = param1;
         dispatchEvent(new Event(Event.SCROLL));
         invalidateData();
      }
      
      public function get rowCount() : uint
      {
         return _totalRenderers;
      }
      
      public function set rowCount(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         if(isNaN(this.rowHeight))
         {
            this.calculateRendererTotal(this.availableWidth,this.availableHeight);
         }
         _loc2_ = this.rowHeight;
         height = _loc2_ * param1 + (this.margin << 1) + this.padding.vertical;
      }
      
      [Inspectable(defaultValue="0")]
      public function get rowHeight() : Number
      {
         return !!isNaN(this._autoRowHeight) ? Number(this._rowHeight) : Number(this._autoRowHeight);
      }
      
      public function set rowHeight(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = NaN;
            if(_inspector)
            {
               return;
            }
         }
         this._rowHeight = param1;
         this._autoRowHeight = NaN;
         invalidateSize();
      }
      
      public function get renderersCount() : int
      {
         return Boolean(_renderers) ? int(_renderers.length) : int(-1);
      }
      
      public function get sbPadding() : Padding
      {
         return this._sbPadding;
      }
      
      public function set sbPadding(param1:Padding) : void
      {
         this._sbPadding = param1;
         invalidateSize();
      }
      
      public function get widthAutoResize() : Boolean
      {
         return this._widthAutoResize;
      }
      
      public function set widthAutoResize(param1:Boolean) : void
      {
         this._widthAutoResize = param1;
      }
      
      public function get enableKeyboardInput() : Boolean
      {
         return this._enableKeyboardInput;
      }
      
      public function set enableKeyboardInput(param1:Boolean) : void
      {
         this._enableKeyboardInput = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:IListItemRenderer = getRendererAt(_selectedIndex,this._scrollPosition);
         if(_loc2_ != null)
         {
            _loc2_.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         if(!this._enableKeyboardInput)
         {
            return;
         }
         var _loc3_:InputDetails = param1.details;
         var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.UP:
               if(selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     this.navigateSelection(this.scrollPosition + _totalRenderers - 1,ListSelectionDirection.UP);
                  }
               }
               else if(_selectedIndex > 0)
               {
                  if(_loc4_)
                  {
                     this.navigateSelection(selectedIndex - 1,ListSelectionDirection.UP);
                  }
               }
               else if(this.wrapping != WrappingMode.STICK)
               {
                  if(this.wrapping != WrappingMode.WRAP)
                  {
                     return;
                  }
                  if(_loc4_)
                  {
                     this.navigateSelection(_dataProvider.length - 1,ListSelectionDirection.UP);
                  }
               }
               break;
            case NavigationCode.DOWN:
               if(_selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     this.navigateSelection(this._scrollPosition,ListSelectionDirection.DOWN);
                  }
               }
               else if(_selectedIndex < _dataProvider.length - 1)
               {
                  if(_loc4_)
                  {
                     this.navigateSelection(selectedIndex + 1,ListSelectionDirection.DOWN);
                  }
               }
               else if(this.wrapping != WrappingMode.STICK)
               {
                  if(this.wrapping != WrappingMode.WRAP)
                  {
                     return;
                  }
                  if(_loc4_)
                  {
                     this.navigateSelection(0,ListSelectionDirection.DOWN);
                  }
               }
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  this.navigateSelection(_dataProvider.length - 1,ListSelectionDirection.UP);
               }
               break;
            case NavigationCode.HOME:
               if(!_loc4_)
               {
                  this.navigateSelection(0,ListSelectionDirection.DOWN);
               }
               break;
            case NavigationCode.PAGE_UP:
               if(_loc4_)
               {
                  this.navigateSelection(Math.max(0,_selectedIndex - _totalRenderers),ListSelectionDirection.UP);
               }
               break;
            case NavigationCode.PAGE_DOWN:
               if(_loc4_)
               {
                  this.navigateSelection(Math.min(_dataProvider.length - 1,_selectedIndex + _totalRenderers),ListSelectionDirection.DOWN);
               }
               break;
            default:
               return;
         }
         param1.handled = true;
      }
      
      override protected function handleMouseWheel(param1:MouseEvent) : void
      {
         if(App.contextMenuMgr.isShown())
         {
            return;
         }
         super.handleMouseWheel(param1);
         if(this._scrollBar && this._scrollBar.visible)
         {
            param1.stopPropagation();
         }
      }
      
      protected function onDataProviderUpdateItem(param1:ListDataProviderEvent) : void
      {
         var _loc3_:IListItemRenderer = null;
         var _loc2_:int = param1.index - this._scrollPosition;
         if(0 <= _loc2_ && _loc2_ < _renderers.length)
         {
            _loc3_ = getRendererAt(_loc2_);
            _loc3_.setData(param1.data);
            _loc3_.validateNow();
         }
      }
      
      private function onScrollBarChangeHandler(param1:Event) : void
      {
         this.scrollPosition = this._scrollBar.position;
      }
      
      private function onScrollMouseWheelHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function onDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         this.onDataProviderUpdateItem(param1);
      }
   }
}
