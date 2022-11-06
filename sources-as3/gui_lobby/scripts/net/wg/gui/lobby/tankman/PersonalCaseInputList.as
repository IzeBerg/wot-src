package net.wg.gui.lobby.tankman
{
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.TextInput;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class PersonalCaseInputList extends UIComponentEx
   {
      
      public static const NAME_SELECTED:String = "nameSelected";
      
      public static const LABEL_FIELD_VALUE:String = "value";
      
      private static const TIME_DELAY:uint = 500;
       
      
      public var searchText:TextInput;
      
      public var list:ScrollingListEx;
      
      private var _dataProvider:DataProvider;
      
      private var _originalName:String = null;
      
      private var _selectedItem:Object = null;
      
      private var _textInput:Boolean = false;
      
      public function PersonalCaseInputList()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.updateSelectedIndexAfterInput);
         this.list.removeEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler);
         this.list.removeEventListener(ListEvent.ITEM_PRESS,this.onListItemPressHandler);
         this.list.dispose();
         this.list = null;
         this.searchText.removeEventListener(MouseEvent.MOUSE_DOWN,this.onSearchTextMouseDownHandler);
         this.searchText.removeEventListener(InputEvent.INPUT,this.onSearchTextInputHandler);
         this.searchText.removeEventListener(FocusEvent.FOCUS_IN,this.onSearchTextFocusInHandler);
         this.searchText.dispose();
         this.searchText = null;
         this._selectedItem = App.utils.data.cleanupDynamicObject(this._selectedItem);
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.list.labelField = LABEL_FIELD_VALUE;
         this.list.addEventListener(ListEvent.INDEX_CHANGE,this.onListIndexChangeHandler);
         this.list.addEventListener(ListEvent.ITEM_PRESS,this.onListItemPressHandler);
         this.list.invalidate(InvalidationType.SCROLL_BAR);
         this.searchText.addEventListener(MouseEvent.MOUSE_DOWN,this.onSearchTextMouseDownHandler);
         this.searchText.addEventListener(InputEvent.INPUT,this.onSearchTextInputHandler);
         this.searchText.addEventListener(FocusEvent.FOCUS_IN,this.onSearchTextFocusInHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._dataProvider && this._originalName != null)
         {
            this.list.dataProvider = this._dataProvider;
            if(this.list.selectedIndex == -1)
            {
               this.searchText.text = this._originalName;
               this.list.selectedIndex = this.searchIndex(this._originalName,false);
            }
            this.list.validateNow();
         }
      }
      
      public function updateData(param1:Array, param2:String) : void
      {
         this._dataProvider = new DataProvider(param1);
         this._originalName = param2;
         invalidateData();
      }
      
      private function searchIndex(param1:String, param2:Boolean) : int
      {
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc3_:String = App.utils.toUpperOrLowerCase(param1,false);
         var _loc4_:IDataProvider = this.list.dataProvider;
         var _loc5_:int = _loc4_.length;
         var _loc6_:int = param1.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = _loc4_[_loc7_];
            _loc9_ = App.utils.toUpperOrLowerCase(String(_loc8_.value),false);
            if(param2 && _loc3_ == _loc9_.slice(0,_loc6_))
            {
               this.selectedItem = _loc8_;
               return _loc7_;
            }
            if(_loc3_ == _loc9_)
            {
               this.selectedItem = _loc8_;
               return _loc7_;
            }
            _loc7_++;
         }
         return this.list.selectedIndex;
      }
      
      private function updateSelectedIndexAfterInput() : void
      {
         this.list.selectedIndex = this.searchIndex(this.searchText.text,true);
      }
      
      public function get selectedItem() : Object
      {
         return this._selectedItem;
      }
      
      public function set selectedItem(param1:Object) : void
      {
         this._selectedItem = param1;
         dispatchEvent(new Event(NAME_SELECTED,true));
      }
      
      private function onSearchTextInputHandler(param1:InputEvent) : void
      {
         if(param1.details && param1.details.value != InputValue.KEY_HOLD)
         {
            App.utils.scheduler.scheduleTask(this.updateSelectedIndexAfterInput,TIME_DELAY);
         }
      }
      
      private function onListIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:Object = param1.itemData;
         if(_loc2_ && !this._textInput)
         {
            this.searchText.text = _loc2_.value;
            this.selectedItem = _loc2_;
         }
      }
      
      private function onSearchTextMouseDownHandler(param1:MouseEvent) : void
      {
         this._textInput = true;
      }
      
      private function onListItemPressHandler(param1:ListEvent) : void
      {
         this._textInput = false;
      }
      
      private function onSearchTextFocusInHandler(param1:FocusEvent) : void
      {
         this.searchText.textField.setSelection(0,this.searchText.text.length);
      }
   }
}
