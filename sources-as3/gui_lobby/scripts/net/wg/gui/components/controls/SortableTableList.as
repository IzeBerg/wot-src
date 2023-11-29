package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.events.SortingEvent;
   import net.wg.infrastructure.interfaces.IDAAPISortable;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SortableTableList extends SortableScrollingList
   {
      
      private static const INV_SELECTED_RENDERER:String = "invSelRend";
       
      
      private var _oldSelectedItem:Object = null;
      
      private var _isSortingTheLastActivity:Boolean = false;
      
      private var _isDataProviderReceived:Boolean = false;
      
      private var _uniqueKeyForAutoSelect:String = null;
      
      private var _lastSelectedUniqueValue:Object = null;
      
      private var _isSelectable:Boolean = true;
      
      public function SortableTableList()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG SortableTableList " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler,false,0,true);
      }
      
      override protected function updateSelectedIndex() : void
      {
         super.updateSelectedIndex();
         invalidate(INV_SELECTED_RENDERER);
      }
      
      override protected function applySorting(param1:Array) : void
      {
         super.applySorting(param1);
         var _loc2_:int = -1;
         if(this._isSelectable)
         {
            if(_dataProvider && _dataProvider is IDAAPISortable)
            {
               _newSelectedIndex = IDAAPISortable(_dataProvider).getDAAPIselectedIdx();
               invalidateSelectedIndex();
            }
            else
            {
               _newSelectedIndex = this.checkSelectedItem(_loc2_);
               invalidateSelectedIndex();
            }
         }
         else
         {
            _newSelectedIndex = _loc2_;
            invalidateSelectedIndex();
         }
      }
      
      override protected function draw() : void
      {
         this._isSortingTheLastActivity = false;
         if(this._isDataProviderReceived && this._isSelectable)
         {
            this._isDataProviderReceived = false;
            dispatchEvent(new SortingEvent(SortingEvent.SELECTED_DATA_CHANGED));
         }
         if(isInvalid(INV_SELECTED_RENDERER))
         {
            this.layoutSelectedRenderers();
         }
         super.draw();
      }
      
      override protected function invalidateSorting(param1:Object) : void
      {
         this.updateOldSelected(_selectedIndex);
         super.invalidateSorting(param1);
         this._isSortingTheLastActivity = true;
         invalidate(SORTING_INVALID);
      }
      
      override protected function onDispose() : void
      {
         this._lastSelectedUniqueValue = null;
         this._oldSelectedItem = null;
         this.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler,false);
         super.onDispose();
      }
      
      override protected function populateData(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:IListItemRenderer = null;
         var _loc7_:ListData = null;
         var _loc8_:ITableRenderer = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = _renderers.length;
         var _loc9_:Vector.<IListItemRenderer> = new Vector.<IListItemRenderer>();
         var _loc10_:int = 0;
         while(_loc10_ < _loc3_)
         {
            _loc5_ = param1[_loc10_];
            _loc6_ = getRendererAt(_loc10_);
            _loc4_ = _scrollPosition + _loc10_;
            _loc7_ = new ListData(_loc4_,itemToLabel(_loc5_),_selectedIndex == _loc4_);
            _loc6_.enabled = _loc10_ < _loc2_;
            _loc6_.setListData(_loc7_);
            _loc8_ = _loc6_ as ITableRenderer;
            if(_loc8_)
            {
               _loc8_.isPassive = !this._isSelectable;
            }
            if(_loc5_ != _loc6_.getData())
            {
               _loc9_.push(_loc6_);
            }
            _loc6_.setData(_loc5_);
            _loc6_.validateNow();
            _loc10_++;
         }
         if(_loc9_.length > 0)
         {
            dispatchEvent(new SortableTableListEvent(SortableTableListEvent.RENDERERS_DATA_CNAHGE,_loc9_,true));
         }
         _loc9_.splice(0,_loc9_.length);
         App.tutorialMgr.dispatchEventForCustomComponent(this);
      }
      
      override protected function drawScrollBar() : void
      {
         super.drawScrollBar();
         _scrollBar.x = _width - _scrollBar.width - margin - sbPadding.right;
      }
      
      public function resetSelectedItem() : void
      {
         this._oldSelectedItem = null;
         this._lastSelectedUniqueValue = null;
         this.selectedIndex = -1;
      }
      
      public function scrollToItemByUniqKey(param1:String, param2:Object) : void
      {
         var _loc3_:int = this.findItemIndex(param2,param1);
         if(_loc3_ > -1)
         {
            scrollToIndex(_loc3_);
         }
      }
      
      private function layoutSelectedRenderers() : void
      {
         var _loc1_:IListItemRenderer = null;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_renderers)
         {
            _loc1_ = null;
            _loc2_ = _renderers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               container.setChildIndex(DisplayObject(_renderers[_loc3_]),_loc3_);
               if(_renderers[_loc3_].selected)
               {
                  _loc1_ = _renderers[_loc3_];
               }
               _loc3_++;
            }
            if(_loc1_)
            {
               _loc4_ = container.numChildren - 1;
               container.setChildIndex(DisplayObject(_loc1_),_loc4_);
            }
         }
      }
      
      private function checkSelectedItem(param1:int) : int
      {
         var _loc2_:Object = null;
         var _loc3_:uint = dataProvider.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = dataProvider[_loc4_];
            if(this._oldSelectedItem && _loc2_ && this._oldSelectedItem == _loc2_)
            {
               param1 = _loc4_;
               break;
            }
            if(this._uniqueKeyForAutoSelect && _loc2_ && _loc2_.hasOwnProperty(this._uniqueKeyForAutoSelect) && this._lastSelectedUniqueValue == _loc2_[this._uniqueKeyForAutoSelect])
            {
               param1 = _loc4_;
               break;
            }
            _loc4_++;
         }
         return param1;
      }
      
      private function updateOldSelected(param1:int) : void
      {
         var _loc2_:IListItemRenderer = getRendererAt(param1);
         if(_loc2_)
         {
            this._oldSelectedItem = _dataProvider[param1];
            if(this._uniqueKeyForAutoSelect && this._oldSelectedItem && this._oldSelectedItem.hasOwnProperty(this._uniqueKeyForAutoSelect))
            {
               this._lastSelectedUniqueValue = this._oldSelectedItem[this._uniqueKeyForAutoSelect];
            }
         }
      }
      
      private function findItemIndex(param1:Object, param2:String) : int
      {
         var _loc3_:int = -1;
         var _loc4_:uint = dataProvider.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(param1 == dataProvider[_loc5_][param2])
            {
               _loc3_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         this._isSortingTheLastActivity = false;
         this._isDataProviderReceived = true;
         super.dataProvider = param1;
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         var _loc2_:IListItemRenderer = null;
         if(param1 < 0)
         {
            super.selectedIndex = -1;
         }
         else
         {
            _loc2_ = getRendererAt(param1,_scrollPosition);
            if(_loc2_ && _loc2_.selectable)
            {
               super.selectedIndex = !!this._isSelectable ? int(param1) : int(-1);
            }
         }
      }
      
      public function get selectedItem() : Object
      {
         if(_selectedIndex > -1 && dataProvider && dataProvider.length > 0)
         {
            return dataProvider.requestItemAt(selectedIndex);
         }
         return null;
      }
      
      public function get uniqKeyForAutoSelect() : String
      {
         return this._uniqueKeyForAutoSelect;
      }
      
      public function set uniqKeyForAutoSelect(param1:String) : void
      {
         this._uniqueKeyForAutoSelect = param1;
      }
      
      public function get isSelectable() : Boolean
      {
         return this._isSelectable;
      }
      
      public function set isSelectable(param1:Boolean) : void
      {
         this._isSelectable = param1;
      }
      
      override protected function handleItemClick(param1:ButtonEvent) : void
      {
         super.handleItemClick(param1);
         this._isSortingTheLastActivity = false;
      }
      
      private function onIndexChangeHandler(param1:ListEvent) : void
      {
         if(this._isSelectable)
         {
            if(!this._isSortingTheLastActivity)
            {
               dispatchEvent(new SortingEvent(SortingEvent.SELECTED_DATA_CHANGED));
            }
         }
         else
         {
            param1.stopImmediatePropagation();
            this.resetSelectedItem();
            validateNow();
         }
      }
   }
}
