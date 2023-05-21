package scaleform.clik.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.constants.WrappingMode;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.interfaces.IScrollBar;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Padding;
   
   [Event(name="itemDoubleClick",type="scaleform.clik.events.ListEvent")]
   [Event(name="itemRollOut",type="scaleform.clik.events.ListEvent")]
   [Event(name="itemRollOver",type="scaleform.clik.events.ListEvent")]
   [Event(name="itemPress",type="scaleform.clik.events.ListEvent")]
   [Event(name="itemClick",type="scaleform.clik.events.ListEvent")]
   [Event(name="change",type="flash.events.Event")]
   public class ScrollingList extends CoreList
   {
       
      
      [Inspectable(defaultValue="normal",enumeration="normal,stick,wrap")]
      public var wrapping:String = "normal";
      
      public var thumbOffset:Object;
      
      public var thumbSizeFactor:Number = 1;
      
      protected var _rowHeight:Number = NaN;
      
      protected var _autoRowHeight:Number = NaN;
      
      protected var _rowCount:Number = NaN;
      
      protected var _scrollPosition:uint = 0;
      
      protected var _autoScrollBar:Boolean = false;
      
      protected var _scrollBarValue:Object;
      
      protected var _margin:Number = 0;
      
      protected var _padding:Padding;
      
      private var isScrollBarCreated:Boolean = false;
      
      protected var _scrollBar:IScrollBar;
      
      public function ScrollingList()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
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
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         if(_dataProvider == null)
         {
            return;
         }
         param1 = Math.max(0,Math.min(_dataProvider.length - _totalRenderers,Math.round(param1)));
         if(this._scrollPosition == param1)
         {
            return;
         }
         this._scrollPosition = param1;
         invalidateData();
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
      
      public function get rowCount() : uint
      {
         return _totalRenderers;
      }
      
      public function set rowCount(param1:uint) : void
      {
         var _loc2_:Number = this.rowHeight;
         if(isNaN(this.rowHeight))
         {
            this.calculateRendererTotal(this.availableWidth,this.availableHeight);
         }
         _loc2_ = this.rowHeight;
         height = _loc2_ * param1 + this.margin * 2;
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
      
      override public function get availableWidth() : Number
      {
         return Math.round(_width) - this.margin * 2 - (!!this._autoScrollBar ? Math.round(this._scrollBar.width) : 0);
      }
      
      override public function get availableHeight() : Number
      {
         return Math.round(_height) - this.margin * 2;
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
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         if(_dataProvider == null)
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
         var _loc3_:InputDetails = param1.details;
         var _loc4_:Boolean = _loc3_.value == InputValue.KEY_DOWN || _loc3_.value == InputValue.KEY_HOLD;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.UP:
               if(selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     this.selectedIndex = this.scrollPosition + _totalRenderers - 1;
                  }
               }
               else if(_selectedIndex > 0)
               {
                  if(_loc4_)
                  {
                     --selectedIndex;
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
                     this.selectedIndex = _dataProvider.length - 1;
                  }
               }
               break;
            case NavigationCode.DOWN:
               if(_selectedIndex == -1)
               {
                  if(_loc4_)
                  {
                     this.selectedIndex = this._scrollPosition;
                  }
               }
               else if(_selectedIndex < _dataProvider.length - 1)
               {
                  if(_loc4_)
                  {
                     ++selectedIndex;
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
                     this.selectedIndex = 0;
                  }
               }
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  this.selectedIndex = _dataProvider.length - 1;
               }
               break;
            case NavigationCode.HOME:
               if(!_loc4_)
               {
                  this.selectedIndex = 0;
               }
               break;
            case NavigationCode.PAGE_UP:
               if(_loc4_)
               {
                  this.selectedIndex = Math.max(0,_selectedIndex - _totalRenderers);
               }
               break;
            case NavigationCode.PAGE_DOWN:
               if(_loc4_)
               {
                  this.selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex + _totalRenderers);
               }
               break;
            default:
               return;
         }
         param1.handled = true;
      }
      
      override public function toString() : String
      {
         return "[CLIK ScrollingList " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         if(this._scrollBar != null && this.isScrollBarCreated)
         {
            this._scrollBar.dispose();
            this._scrollBar = null;
         }
         this.thumbOffset = null;
         this._padding = null;
         super.onDispose();
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
         }
         if(isInvalid(InvalidationType.RENDERERS))
         {
            this._autoRowHeight = NaN;
         }
         super.draw();
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
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_ + _loc7_ * _loc2_;
            _loc8_.width = _loc3_;
            _loc8_.height = _loc2_;
            if(!_loc6_)
            {
               _loc8_.validateNow();
            }
            _loc7_++;
         }
         this.drawScrollBar();
      }
      
      protected function createScrollBar() : void
      {
         var _loc1_:IScrollBar = null;
         var _loc2_:Class = null;
         var _loc3_:Object = null;
         if(this._scrollBar)
         {
            this._scrollBar.removeEventListener(Event.SCROLL,this.handleScroll,false);
            this._scrollBar.removeEventListener(Event.CHANGE,this.handleScroll,false);
            this._scrollBar.focusTarget = null;
            if(container.contains(this._scrollBar as DisplayObject))
            {
               container.removeChild(this._scrollBar as DisplayObject);
            }
            if(this.isScrollBarCreated)
            {
               this._scrollBar.dispose();
            }
            this._scrollBar = null;
            this.isScrollBarCreated = false;
         }
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
               _loc2_ = App.utils.classFactory.getClass(this._scrollBarValue.toString(),loaderInfo);
               if(_loc2_)
               {
                  _loc1_ = App.utils.classFactory.getComponent(this._scrollBarValue.toString(),IScrollBar,null,loaderInfo) as IScrollBar;
               }
               if(_loc1_)
               {
                  this._autoScrollBar = true;
                  this.isScrollBarCreated = true;
                  _loc3_ = _loc1_ as Object;
                  if(_loc3_ && this.thumbOffset)
                  {
                     _loc3_.offsetTop = this.thumbOffset.top;
                     _loc3_.offsetBottom = this.thumbOffset.bottom;
                  }
                  _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.blockMouseWheel,false,0,true);
                  container.addChild(_loc1_ as DisplayObject);
               }
            }
         }
         else if(this._scrollBarValue is Class)
         {
            _loc1_ = new (this._scrollBarValue as Class)() as IScrollBar;
            if(_loc1_ != null)
            {
               this._autoScrollBar = true;
               this.isScrollBarCreated = true;
               _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.blockMouseWheel,false,0,true);
               (_loc1_ as Object).offsetTop = this.thumbOffset.top;
               (_loc1_ as Object).offsetBottom = this.thumbOffset.bottom;
               container.addChild(_loc1_ as DisplayObject);
            }
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
         this._scrollBar.addEventListener(Event.SCROLL,this.handleScroll,false,0,true);
         this._scrollBar.addEventListener(Event.CHANGE,this.handleScroll,false,0,true);
         this._scrollBar.focusTarget = this;
         this._scrollBar.tabEnabled = false;
      }
      
      protected function drawScrollBar() : void
      {
         if(!this._autoScrollBar)
         {
            return;
         }
         this._scrollBar.x = _width - this._scrollBar.width - this.margin;
         this._scrollBar.y = this.margin;
         this._scrollBar.height = this.availableHeight;
         this._scrollBar.validateNow();
      }
      
      protected function updateScrollBar() : void
      {
         var _loc2_:ScrollIndicator = null;
         if(this._scrollBar == null || _dataProvider == null)
         {
            return;
         }
         var _loc1_:Number = Math.max(0,_dataProvider.length - _totalRenderers);
         if(this._scrollBar is ScrollIndicator)
         {
            _loc2_ = this._scrollBar as ScrollIndicator;
            _loc2_.setScrollProperties(_dataProvider.length - _totalRenderers,0,_dataProvider.length - _totalRenderers);
         }
         this._scrollBar.position = this._scrollPosition;
         this._scrollBar.validateNow();
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
         if(_dataProvider != null)
         {
            this._scrollPosition = Math.min(Math.max(0,_dataProvider.length - _totalRenderers),this._scrollPosition);
            this.selectedIndex = Math.min(_dataProvider.length - 1,_selectedIndex);
            this.updateSelectedIndex();
            _dataProvider.requestItemRange(this._scrollPosition,Math.min(_dataProvider.length - 1,this._scrollPosition + _totalRenderers - 1),this.populateData);
         }
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
         if(_dataProvider == null)
         {
            return;
         }
         var _loc1_:IListItemRenderer = getRendererAt(_selectedIndex,this.scrollPosition);
         if(_loc1_ != null)
         {
            _loc1_.selected = false;
            _loc1_.validateNow();
         }
         super.selectedIndex = _newSelectedIndex;
         if(_selectedIndex < 0 || _selectedIndex >= _dataProvider.length)
         {
            return;
         }
         _loc1_ = getRendererAt(_selectedIndex,this._scrollPosition);
         if(_loc1_ != null)
         {
            _loc1_.selected = true;
            _loc1_.validateNow();
         }
         else
         {
            this.scrollToIndex(_selectedIndex);
            _loc1_ = getRendererAt(_selectedIndex,this.scrollPosition);
            _loc1_.selected = true;
            _loc1_.validateNow();
         }
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         var _loc3_:IListItemRenderer = null;
         if(isNaN(this._rowHeight) && isNaN(this._autoRowHeight))
         {
            _loc3_ = createRenderer(0);
            this._autoRowHeight = _loc3_.height;
            cleanUpRenderer(_loc3_);
         }
         return (this.availableHeight - this.padding.vertical) / this.rowHeight >> 0;
      }
      
      protected function handleScroll(param1:Event) : void
      {
         this.scrollPosition = this._scrollBar.position;
      }
      
      protected function populateData(param1:Array) : void
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
            _loc6_ = this._scrollPosition + _loc4_;
            _loc7_ = new ListData(_loc6_,itemToLabel(param1[_loc4_]),_selectedIndex == _loc6_);
            _loc5_.enabled = _loc4_ >= _loc2_ ? Boolean(false) : Boolean(true);
            _loc5_.setListData(_loc7_);
            _loc5_.setData(param1[_loc4_]);
            _loc5_.validateNow();
            _loc4_++;
         }
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function scrollList(param1:int) : void
      {
         this.scrollPosition -= param1;
      }
      
      protected function blockMouseWheel(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
   }
}
