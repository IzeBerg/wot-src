package net.wg.gui.components.controls
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.events.SortingEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   import scaleform.clik.utils.Padding;
   
   [InspectableList("rowWidthAutoResize")]
   public class SortableTable extends UIComponentEx implements ISortableTable
   {
      
      private static const INV_LIST_DATA:String = "InvListData";
      
      private static const INV_LIST_RENDERER:String = "InvListRenderer";
      
      private static const INV_LIST_VISIBLE:String = "InvListVisible";
      
      private static const INV_LIST_MOUSE_ENABLED:String = "InvListMouseEnabled";
      
      private static const INV_LIST_SELECTED_INDEX:String = "InvListSelectedIndex";
      
      private static const INV_LIST_SCROLL_TO_ITEM:String = "InvListScrollToItem";
      
      private static const INV_HEADER_DATA:String = "InvHeaderData";
      
      private static const INV_HEADER_SELECTED_INDEX:String = "InvHeaderSelectedIndex";
      
      private static const INV_HEADER_SORTABLE:String = "InvHeaderSortable";
      
      private static const INV_UNIQ_KEY:String = "InvUniqKey";
      
      private static const INV_SORTING:String = "InvSorting";
      
      private static const INV_SORT_FIELD:String = "InvSortField";
      
      private static const INV_HANDLERS:String = "InvHandlers";
      
      private static const INV_ROW_WIDTH:String = "InvRowWidth";
      
      private static const LEFT_PADDING:int = 2;
      
      private static const LIST_VIEW_NAME:String = "list";
       
      
      private var _header:SortableHeaderButtonBar = null;
      
      private var _upperShadow:Sprite = null;
      
      private var _lowerShadow:Sprite = null;
      
      private var _focusChain:Vector.<InteractiveObject> = null;
      
      private var _container:Sprite = null;
      
      private var _list:SortableTableList = null;
      
      private var _headerHeight:int = 48;
      
      private var _listLinkage:String = "SortableScrollingList_UI";
      
      private var _rendererLinkage:String = "TableRenderer_UI";
      
      private var _isSortable:Boolean = true;
      
      private var _headerDP:IDataProvider = null;
      
      private var _listDP:IDataProvider = null;
      
      private var _isRendererToggle:Boolean = false;
      
      private var _rowHeight:Number = 34;
      
      private var _useRightBtn:Boolean = false;
      
      private var _useSmartScrollbar:Boolean = true;
      
      private var _listSelectNavigator:AbstractListSelectionNavigator;
      
      private var _isListSelectable:Boolean = true;
      
      private var _isListMouseEnabled:Boolean = true;
      
      private var _scrollToKey:String = null;
      
      private var _scrollToValue:Object = null;
      
      private var _sortingID:String = null;
      
      private var _sortDir:String = null;
      
      private var _uniqKeyForAutoSelect:String = "";
      
      private var _headerSelectedIndex:int = -1;
      
      private var _listSelectedIndex:int = -1;
      
      private var _rowHeightFixed:Boolean = false;
      
      private var _scrollbarPadding:Padding = null;
      
      private var _listPadding:Padding = null;
      
      private var _rowWidthAutoResize:Boolean = true;
      
      private var _hitMc:Sprite = null;
      
      private var _classFactory:IClassFactory = null;
      
      private var _asserter:IAssertable = null;
      
      private var _listVisible:Boolean = true;
      
      private var _isTableDataEmpty:Boolean = true;
      
      public function SortableTable()
      {
         super();
         this._listPadding = new Padding(0);
         this._focusChain = new Vector.<InteractiveObject>();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._container == null)
         {
            this._container = new Sprite();
            addChild(this._container);
            this._hitMc = new Sprite();
            addChild(this._hitMc);
            this._container.hitArea = this._hitMc;
         }
         this.initComponents();
      }
      
      override protected function initialize() : void
      {
         this._classFactory = App.utils.classFactory;
         this._asserter = App.utils.asserter;
         this._headerDP = new DataProvider();
         this._listDP = new DataProvider();
         this._scrollbarPadding = new Padding(0);
         super.initialize();
      }
      
      override protected function onDispose() : void
      {
         this.cleanUpListHandlers();
         if(this._header)
         {
            this._header.dispose();
            this._header = null;
         }
         if(this._headerDP)
         {
            this._headerDP.cleanUp();
            this._headerDP = null;
         }
         if(this._list)
         {
            this._list.dispose();
            this._list = null;
         }
         if(this._scrollToValue)
         {
            App.utils.data.cleanupDynamicObject(this._scrollToValue);
            this._scrollToValue = null;
         }
         if(this._listDP)
         {
            this._listDP.removeEventListener(Event.CHANGE,this.onListDPChangeHandler);
            this._listDP.cleanUp();
            this._listDP = null;
         }
         if(this._container)
         {
            this._container.hitArea = null;
            this._container = null;
         }
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = null;
         this._hitMc = null;
         this._upperShadow = null;
         this._lowerShadow = null;
         this._scrollbarPadding = null;
         this._listPadding = null;
         this._classFactory = null;
         this._asserter = null;
         this._listSelectNavigator = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc3_:NormalSortingBtnVO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         var _loc1_:Boolean = false;
         if(isInvalid(INV_LIST_RENDERER))
         {
            this._list.itemRendererName = this._rendererLinkage;
         }
         if(isInvalid(INV_UNIQ_KEY))
         {
            this._list.uniqKeyForAutoSelect = this._uniqKeyForAutoSelect;
         }
         if(isInvalid(INV_ROW_WIDTH))
         {
            this._list.widthAutoResize = this._rowWidthAutoResize;
         }
         if(isInvalid(INV_LIST_DATA))
         {
            this._list.dataProvider = this._listDP;
            _loc1_ = true;
         }
         if(isInvalid(INV_LIST_VISIBLE))
         {
            this._list.visible = this._listVisible;
         }
         if(isInvalid(INV_LIST_MOUSE_ENABLED))
         {
            this._list.container.mouseEnabled = this._isListMouseEnabled;
         }
         if(this._sortingID && isInvalid(INV_SORTING))
         {
            this._list.sortByField(this._sortingID,this._sortDir == SortingInfo.ASCENDING_SORT);
            _loc1_ = true;
         }
         if(isInvalid(INV_LIST_SELECTED_INDEX))
         {
            this._list.selectedIndex = this._listSelectedIndex;
            _loc1_ = true;
         }
         if(this._scrollToKey && isInvalid(INV_LIST_SCROLL_TO_ITEM))
         {
            this._list.scrollToItemByUniqKey(this._scrollToKey,this._scrollToValue);
            _loc1_ = true;
            this._scrollToKey = null;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this._list.setSize(_width,_height - this._headerHeight);
            _loc1_ = true;
            this._upperShadow.width = _width;
            this._lowerShadow.width = _width;
            this._lowerShadow.y = _height;
            this._hitMc.width = _width;
            this._hitMc.height = _height;
         }
         if(isInvalid(INV_HANDLERS))
         {
            this.setupListHandlers();
         }
         if(_loc1_)
         {
            this._list.validateNow();
         }
         var _loc2_:Boolean = false;
         if(isInvalid(INV_HEADER_DATA))
         {
            this._header.dataProvider = this._headerDP;
            if(!this._isSortable)
            {
               this._header.selectedIndex = -1;
            }
            _loc2_ = true;
            if(this._list)
            {
               this._list.columnsData = this._header.dataProvider;
            }
            this._header.visible = this._header.dataProvider.length > 0;
         }
         if(this._header != null && isInvalid(INV_HEADER_SORTABLE))
         {
            this._header.updateButtonsEnabledState(this._isSortable && !this._isTableDataEmpty);
            if(!this._isSortable || this._isTableDataEmpty)
            {
               this._header.selectedIndex = -1;
            }
         }
         if(this._isSortable && !this._isTableDataEmpty && isInvalid(INV_HEADER_SELECTED_INDEX))
         {
            this._header.selectedIndex = this._headerSelectedIndex;
            _loc2_ = true;
         }
         if(this._sortingID && isInvalid(INV_SORT_FIELD))
         {
            if(this._isSortable && !this._isTableDataEmpty)
            {
               _loc4_ = this._header.dataProvider.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc3_ = NormalSortingBtnVO(this._header.dataProvider[_loc5_]);
                  if(_loc3_.id == this._sortingID)
                  {
                     this._header.selectedIndex = _loc5_;
                     this._header.sortDirection = this._sortDir;
                     _loc2_ = true;
                     break;
                  }
                  _loc5_++;
               }
            }
         }
         if(_loc2_)
         {
            this._header.validateNow();
         }
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         if(this._isSortable && this._header && this._header.hasEnabledRenderers())
         {
            return this._header;
         }
         if(this._list)
         {
            return this._list;
         }
         return this;
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         this._focusChain.splice(0,this._focusChain.length);
         if(this._header && this._header.hasEnabledRenderers())
         {
            this._focusChain.push(this._header);
         }
         if(this._list)
         {
            this._focusChain.push(this._list);
         }
         return this._focusChain;
      }
      
      public function getListSelectedItem() : Object
      {
         if(this._list)
         {
            return this._list.selectedItem;
         }
         return null;
      }
      
      public function getRendererAt(param1:int, param2:int) : IListItemRenderer
      {
         if(this._list)
         {
            return this._list.getRendererAt(param1,param2);
         }
         return null;
      }
      
      public function scrollListToItemByUniqKey(param1:String, param2:Object) : void
      {
         this._scrollToKey = param1;
         this._scrollToValue = param2;
         invalidate(INV_LIST_SCROLL_TO_ITEM);
      }
      
      public function setSelectedField(param1:String, param2:String) : void
      {
         this._sortingID = param1;
         this._sortDir = param2;
         invalidate(INV_SORT_FIELD);
      }
      
      public function sortByField(param1:String, param2:String) : void
      {
         this._sortingID = param1;
         this._sortDir = param2;
         invalidate(INV_SORTING,INV_SORT_FIELD);
      }
      
      private function updateAdditionalOptions(param1:IDataProvider) : void
      {
         var _loc3_:NormalSortingBtnVO = null;
         var _loc2_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = NormalSortingBtnVO(param1[_loc4_]);
            if(_loc3_)
            {
               _loc3_.buttonHeight = this._headerHeight;
               if(!this._isSortable)
               {
                  _loc3_.enabled = false;
               }
               _loc3_.showSeparator = this._isSortable;
            }
            _loc4_++;
         }
      }
      
      private function initComponents() : void
      {
         removeChild(this._container);
         setActualSize(_width,_height);
         this._container.scaleX = 1 / scaleX;
         this._container.scaleY = 1 / scaleY;
         addChild(this._container);
         this.initLists();
         this.initShadows();
         this.initHeaderButtonBar();
         invalidate(INV_HANDLERS);
         dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
      }
      
      private function initShadows() : void
      {
         this._asserter.assertNull(this._upperShadow,"_upperShadow" + Errors.MUST_NULL);
         this._asserter.assertNull(this._lowerShadow,"_lowerShadow" + Errors.MUST_NULL);
         this._upperShadow = this._classFactory.getComponent(Linkages.TABLE_SHADDOW_UI,Sprite);
         this._lowerShadow = this._classFactory.getComponent(Linkages.ROTATED_TABLE_SHADDOW_UI,Sprite);
         this._lowerShadow.mouseEnabled = this._upperShadow.mouseEnabled = false;
         this._lowerShadow.mouseChildren = this._upperShadow.mouseChildren = false;
         this._container.addChild(this._upperShadow);
         this._container.addChild(this._lowerShadow);
         this._lowerShadow.width = this._upperShadow.width = _width;
         this._upperShadow.y = this._headerHeight;
         this._lowerShadow.y = _height;
      }
      
      private function initHeaderButtonBar() : void
      {
         this._asserter.assertNull(this._header,"_header" + Errors.MUST_NULL);
         this._header = this._classFactory.getComponent(Linkages.SORTABLE_BUTTON_BAR_UI,SortableHeaderButtonBar);
         this._header.itemRendererName = Linkages.NORMAL_SORT_BTN_UI;
         this._header.x = LEFT_PADDING;
         this._header.width = _width;
         this._header.height = this._headerHeight;
         this._header.dataProvider = this._headerDP;
         this._container.addChild(this._header);
         if(this._list)
         {
            this._list.columnsData = this._header.dataProvider;
         }
         this._header.validateNow();
      }
      
      private function initLists() : void
      {
         this._asserter.assertNull(this._list,"_list" + Errors.MUST_NULL);
         var _loc1_:Number = _height - this._headerHeight;
         this._list = this._classFactory.getComponent(this._listLinkage,SortableTableList);
         this._list.name = LIST_VIEW_NAME;
         this._list.itemRendererName = this._rendererLinkage;
         this._list.smartScrollBar = this._useSmartScrollbar;
         this._list.setSelectionNavigator(this._listSelectNavigator);
         this._list.scrollBar = Linkages.SCROLL_BAR;
         this._list.isRowHeightFixed = this._rowHeightFixed;
         this._list.dataProvider = this._listDP;
         this._list.setSize(_width,_loc1_);
         this._list.isSelectable = this._isListSelectable;
         this._list.useRightButton = this._useRightBtn;
         this._list.widthAutoResize = this._rowWidthAutoResize;
         this._list.sbPadding = this._scrollbarPadding;
         this._list.rowHeight = this._rowHeight;
         this._list.x = this._listPadding.left;
         this._list.y = this._headerHeight + this._listPadding.top;
         this._list.visible = this._listVisible;
         this._container.addChild(this._list);
         this._list.validateNow();
      }
      
      private function setupListHandlers() : void
      {
         if(this._header)
         {
            this._header.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onHeaderSortDirectionChangedHandler,false,0,true);
         }
         if(this._list)
         {
            this._list.addEventListener(SortingEvent.SELECTED_DATA_CHANGED,this.onListSelectedDataChangedHandler);
            this._list.addEventListener(ListEvent.INDEX_CHANGE,this.onListEventHandler);
            this._list.addEventListener(ListEvent.ITEM_CLICK,this.onListEventHandler);
            this._list.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onListEventHandler);
            this._list.addEventListener(ListEvent.ITEM_PRESS,this.onListEventHandler);
            this._list.addEventListener(ListEvent.ITEM_ROLL_OVER,this.onListEventHandler);
            this._list.addEventListener(ListEvent.ITEM_ROLL_OUT,this.onListEventHandler);
         }
      }
      
      private function cleanUpListHandlers() : void
      {
         if(this._header)
         {
            this._header.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onHeaderSortDirectionChangedHandler,false);
         }
         if(this._list)
         {
            this._list.removeEventListener(SortingEvent.SELECTED_DATA_CHANGED,this.onListSelectedDataChangedHandler);
            this._list.removeEventListener(ListEvent.INDEX_CHANGE,this.onListEventHandler);
            this._list.removeEventListener(ListEvent.ITEM_CLICK,this.onListEventHandler);
            this._list.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onListEventHandler);
            this._list.removeEventListener(ListEvent.ITEM_PRESS,this.onListEventHandler);
            this._list.removeEventListener(ListEvent.ITEM_ROLL_OVER,this.onListEventHandler);
            this._list.removeEventListener(ListEvent.ITEM_ROLL_OUT,this.onListEventHandler);
         }
      }
      
      private function updateTableDataEmpty() : void
      {
         var _loc1_:Boolean = this._listDP.length == 0;
         if(this._isTableDataEmpty != _loc1_)
         {
            this._isTableDataEmpty = _loc1_;
            invalidate(INV_SORT_FIELD,INV_HEADER_SORTABLE);
         }
      }
      
      [Inspectable(defaultValue="true",name="isListSelectable")]
      public function get isListSelectable() : Boolean
      {
         return this._isListSelectable;
      }
      
      public function set isListSelectable(param1:Boolean) : void
      {
         if(this._isListSelectable == param1)
         {
            return;
         }
         this._isListSelectable = param1;
         if(this._list)
         {
            this._list.isSelectable = this._isListSelectable;
         }
      }
      
      public function get isListMouseEnabled() : Boolean
      {
         return this._isListMouseEnabled;
      }
      
      public function set isListMouseEnabled(param1:Boolean) : void
      {
         this._isListMouseEnabled = param1;
         invalidate(INV_LIST_MOUSE_ENABLED);
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="scrollbarPadding")]
      public function set scrollbarPadding(param1:Object) : void
      {
         this._scrollbarPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      public function set listPadding(param1:Padding) : void
      {
         this._listPadding = param1;
      }
      
      [Inspectable(defaultValue="34",name="rowHeight")]
      public function get rowHeight() : Number
      {
         return this._rowHeight;
      }
      
      public function set rowHeight(param1:Number) : void
      {
         this._rowHeight = param1;
      }
      
      [Inspectable(defaultValue="false",name="rowHeightFixed")]
      public function get rowHeightFixed() : Boolean
      {
         return this._rowHeightFixed;
      }
      
      public function set rowHeightFixed(param1:Boolean) : void
      {
         if(this._rowHeightFixed == param1)
         {
            return;
         }
         this._rowHeightFixed = param1;
         if(this._list)
         {
            this._list.isRowHeightFixed = this._rowHeightFixed;
         }
      }
      
      [Inspectable(defaultValue="48",name="headerHeight")]
      public function get headerHeight() : int
      {
         return this._headerHeight;
      }
      
      public function set headerHeight(param1:int) : void
      {
         this._headerHeight = param1;
      }
      
      [Inspectable(defaultValue="true",name="rowWidthAutoResize")]
      public function get rowWidthAutoResize() : Boolean
      {
         return this._rowWidthAutoResize;
      }
      
      public function set rowWidthAutoResize(param1:Boolean) : void
      {
         this._rowWidthAutoResize = param1;
         invalidate(INV_ROW_WIDTH);
      }
      
      [Inspectable(defaultValue="SortableScrollingList_UI",name="listLinkage")]
      public function get listLinkage() : String
      {
         return this._listLinkage;
      }
      
      public function set listLinkage(param1:String) : void
      {
         this._listLinkage = param1;
      }
      
      [Inspectable(defaultValue="TableRenderer_UI",name="rendererLinkage")]
      public function get rendererLinkage() : String
      {
         return this._rendererLinkage;
      }
      
      public function set rendererLinkage(param1:String) : void
      {
         this._rendererLinkage = param1;
         invalidate(INV_LIST_RENDERER);
      }
      
      [Inspectable(defaultValue="true",name="isSortable")]
      public function get isSortable() : Boolean
      {
         return this._isSortable;
      }
      
      public function set isSortable(param1:Boolean) : void
      {
         if(this._isSortable != param1)
         {
            this._isSortable = param1;
            invalidate(INV_SORT_FIELD,INV_HEADER_SORTABLE);
         }
      }
      
      [Inspectable(defaultValue="false",name="useRightBtn")]
      public function get useRightBtn() : Boolean
      {
         return this._useRightBtn;
      }
      
      public function set useRightBtn(param1:Boolean) : void
      {
         if(this._useRightBtn == param1)
         {
            return;
         }
         this._useRightBtn = param1;
         if(this._list)
         {
            this._list.useRightButton = this._useRightBtn;
         }
      }
      
      [Inspectable(defaultValue="true",name="useSmartScrollbar")]
      public function get useSmartScrollbar() : Boolean
      {
         return this._useSmartScrollbar;
      }
      
      public function set useSmartScrollbar(param1:Boolean) : void
      {
         if(this._useSmartScrollbar == param1)
         {
            return;
         }
         this._useSmartScrollbar = param1;
         if(this._list)
         {
            this._list.smartScrollBar = this._useSmartScrollbar;
         }
      }
      
      public function get listSelectNavigator() : AbstractListSelectionNavigator
      {
         return this._listSelectNavigator;
      }
      
      public function set listSelectNavigator(param1:AbstractListSelectionNavigator) : void
      {
         if(this._listSelectNavigator == param1)
         {
            return;
         }
         this._listSelectNavigator = param1;
         if(this._list)
         {
            this._list.setSelectionNavigator(this._listSelectNavigator);
         }
      }
      
      public function get headerDP() : IDataProvider
      {
         return this._headerDP;
      }
      
      public function set headerDP(param1:IDataProvider) : void
      {
         this.updateAdditionalOptions(param1);
         this._headerDP = param1;
         invalidate(INV_HEADER_DATA,INV_HEADER_SORTABLE);
         dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
      }
      
      [Inspectable(defaultValue="false",name="isRendererToggle")]
      public function get isRendererToggle() : Boolean
      {
         return this._isRendererToggle;
      }
      
      public function set isRendererToggle(param1:Boolean) : void
      {
         this._isRendererToggle = param1;
      }
      
      public function get listDP() : IDataProvider
      {
         return this._listDP;
      }
      
      public function set listDP(param1:IDataProvider) : void
      {
         if(this._listDP != param1)
         {
            if(this._listDP != null)
            {
               this._listDP.removeEventListener(Event.CHANGE,this.onListDPChangeHandler);
            }
            this._listDP = param1;
            this._listDP.addEventListener(Event.CHANGE,this.onListDPChangeHandler);
            this.updateTableDataEmpty();
            invalidate(INV_LIST_DATA);
         }
      }
      
      public function get headerSelectedIndex() : int
      {
         if(this._header)
         {
            return this._header.selectedIndex;
         }
         return -1;
      }
      
      public function set headerSelectedIndex(param1:int) : void
      {
         this._headerSelectedIndex = param1;
         invalidate(INV_HEADER_SELECTED_INDEX);
      }
      
      public function get listSelectedIndex() : int
      {
         if(this._list)
         {
            return this._list.selectedIndex;
         }
         return -1;
      }
      
      public function set listSelectedIndex(param1:int) : void
      {
         this._listSelectedIndex = param1;
         invalidate(INV_LIST_SELECTED_INDEX);
      }
      
      public function get scrollPosition() : Number
      {
         if(this._list)
         {
            return this._list.scrollPosition;
         }
         return 0;
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         if(this._list)
         {
            this._list.scrollPosition = param1;
         }
      }
      
      public function get totalRenderers() : int
      {
         if(this._list)
         {
            return this._list.renderersCount;
         }
         return 0;
      }
      
      public function get uniqKeyForAutoSelect() : String
      {
         return this._uniqKeyForAutoSelect;
      }
      
      public function set uniqKeyForAutoSelect(param1:String) : void
      {
         this._uniqKeyForAutoSelect = param1;
         invalidate(INV_UNIQ_KEY);
      }
      
      public function get listVisible() : Boolean
      {
         return this._listVisible;
      }
      
      public function set listVisible(param1:Boolean) : void
      {
         this._listVisible = param1;
         invalidate(INV_LIST_VISIBLE);
      }
      
      private function onListDPChangeHandler(param1:Event) : void
      {
         this.updateTableDataEmpty();
      }
      
      private function onHeaderSortDirectionChangedHandler(param1:SortingEvent) : void
      {
         var _loc2_:NormalSortingButton = NormalSortingButton(param1.target);
         if(_loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
         {
            this._list.sortByField(_loc2_.id,_loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
         }
      }
      
      private function onListEventHandler(param1:ListEvent) : void
      {
         if(this._isRendererToggle && param1.type == ListEvent.ITEM_CLICK)
         {
            if(this.listSelectedIndex == param1.index)
            {
               this._list.resetSelectedItem();
            }
         }
         dispatchEvent(SortableTableListEvent.createByListEvent(param1));
         param1.stopImmediatePropagation();
      }
      
      private function onListSelectedDataChangedHandler(param1:SortingEvent) : void
      {
         param1.stopImmediatePropagation();
         dispatchEvent(new SortingEvent(SortingEvent.SELECTED_DATA_CHANGED));
      }
   }
}
