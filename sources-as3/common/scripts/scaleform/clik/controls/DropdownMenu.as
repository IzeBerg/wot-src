package scaleform.clik.controls
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.infrastructure.events.TutorialEvent;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.managers.PopUpManager;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Padding;
   
   [Event(name="change",type="flash.events.Event")]
   public class DropdownMenu extends Button
   {
       
      
      [Inspectable(defaultValue="CLIKScrollingList",type="String")]
      public var dropdown:Object = "CLIKScrollingList";
      
      [Inspectable(defaultValue="CLIKListItemRenderer",type="String")]
      public var itemRenderer:Object = "CLIKListItemRenderer";
      
      [Inspectable(type="String")]
      public var scrollBar:Object;
      
      [Inspectable(defaultValue="normal",enumeration="normal,stick,wrap")]
      public var menuWrapping:String = "normal";
      
      [Inspectable(defaultValue="down",enumeration="up,down")]
      public var menuDirection:String = "down";
      
      [Inspectable(defaultValue="-1")]
      public var menuWidth:Number = -1;
      
      [Inspectable(defaultValue="1")]
      public var menuMargin:Number = 1;
      
      [Inspectable(defaultValue="5")]
      public var menuRowCount:Number = 5;
      
      [Inspectable(defaultFixedLength="true")]
      public var menuRowsFixed:Boolean = true;
      
      public var menuPadding:Padding;
      
      public var menuOffset:Padding;
      
      public var thumbOffsetTop:Number;
      
      public var thumbOffsetBottom:Number;
      
      protected var _selectedIndex:int = -1;
      
      protected var _dataProvider:IDataProvider;
      
      protected var _labelField:String = "label";
      
      protected var _labelFunction:Function;
      
      protected var _popup:MovieClip;
      
      protected var _dropdownRef:MovieClip = null;
      
      public function DropdownMenu()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         this.dataProvider = new DataProvider();
         this.menuOffset = new Padding(0,0,0,0);
         this.menuPadding = new Padding(0,0,0,0);
         super.initialize();
      }
      
      override public function get autoRepeat() : Boolean
      {
         return false;
      }
      
      override public function set autoRepeat(param1:Boolean) : void
      {
      }
      
      override public function get data() : Object
      {
         return null;
      }
      
      override public function set data(param1:Object) : void
      {
      }
      
      override public function get label() : String
      {
         return "";
      }
      
      override public function set label(param1:String) : void
      {
      }
      
      override public function get selected() : Boolean
      {
         return super.selected;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
      }
      
      override public function get toggle() : Boolean
      {
         return super.toggle;
      }
      
      override public function set toggle(param1:Boolean) : void
      {
         super.toggle = param1;
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="menuPadding")]
      public function set inspectableMenuPadding(param1:Object) : void
      {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.menuPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="menuOffset")]
      public function set inspectableMenuOffset(param1:Object) : void
      {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.menuOffset = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      [Inspectable(defaultValue="top:0,bottom:0",name="thumbOffset")]
      public function set inspectableThumbOffset(param1:Object) : void
      {
         if(!componentInspectorSetting)
         {
            return;
         }
         this.thumbOffsetTop = Number(param1.top);
         this.thumbOffsetBottom = Number(param1.bottom);
      }
      
      [Inspectable(defaultValue="true")]
      override public function get focusable() : Boolean
      {
         return _focusable;
      }
      
      override public function set focusable(param1:Boolean) : void
      {
         super.focusable = param1;
      }
      
      override protected function onDispose() : void
      {
         if(this._dataProvider)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
            this._dataProvider.cleanUp();
            this._dataProvider = null;
         }
         if(this._dropdownRef)
         {
            this._dropdownRef.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.dropdownRefReadyForTutorialHandler);
         }
         super.onDispose();
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc2_:CoreList = null;
         var _loc3_:uint = 0;
         if(this._selectedIndex == param1)
         {
            return;
         }
         this._selectedIndex = param1;
         this.invalidateSelectedIndex();
         if(this._dropdownRef != null)
         {
            _loc2_ = this._dropdownRef as CoreList;
            _loc3_ = _loc2_ is ScrollingList ? uint((_loc2_ as ScrollingList).scrollPosition) : uint(0);
            dispatchEventAndSound(new ListEvent(ListEvent.INDEX_CHANGE,true,false,this._selectedIndex,-1,-1,_loc2_.getRendererAt(this._selectedIndex,_loc3_),Boolean(this._dataProvider) ? this._dataProvider.requestItemAt(this._selectedIndex) : -1));
         }
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
         }
         this._dataProvider = param1;
         var _loc2_:int = this._dataProvider == null ? int(0) : int(this._dataProvider.length);
         if(!this.menuRowsFixed && _loc2_ > 0 && _loc2_ < this.menuRowCount)
         {
            this.menuRowCount = _loc2_;
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.addEventListener(Event.CHANGE,this.handleDataChange,false,0,true);
         }
         invalidateData();
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set labelField(param1:String) : void
      {
         this._labelField = param1;
         invalidateData();
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         this._labelFunction = param1;
         invalidateData();
      }
      
      public function itemToLabel(param1:Object) : String
      {
         if(param1 == null)
         {
            return "";
         }
         if(this._labelFunction != null)
         {
            return this._labelFunction(param1);
         }
         if(param1 is String)
         {
            return param1.toString();
         }
         if(this._labelField != null && param1[this._labelField] != null)
         {
            return param1[this._labelField];
         }
         return param1.toString();
      }
      
      public function open() : void
      {
         this.selected = true;
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false,0,true);
         this.showDropdown();
      }
      
      public function close() : void
      {
         this.selected = false;
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false);
         this.hideDropdown();
      }
      
      public function isOpen() : Boolean
      {
         return this._dropdownRef != null;
      }
      
      public function invalidateSelectedIndex() : void
      {
         invalidate(InvalidationType.SELECTED_INDEX);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         if(this._dropdownRef != null && this.selected)
         {
            this._dropdownRef.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         var _loc3_:Boolean = _loc2_.value == InputValue.KEY_DOWN;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.ESCAPE:
               if(this.selected)
               {
                  if(_loc3_)
                  {
                     this.close();
                  }
                  param1.handled = true;
                  break;
               }
         }
      }
      
      override public function toString() : String
      {
         return "[CLIK DropdownMenu " + name + "]";
      }
      
      public function get dropDownref() : MovieClip
      {
         return this._dropdownRef;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SELECTED_INDEX) || isInvalid(InvalidationType.DATA))
         {
            if(this._dataProvider != null)
            {
               this._dataProvider.requestItemAt(this._selectedIndex,this.populateText);
            }
            invalidateData();
         }
         super.draw();
      }
      
      override protected function changeFocus() : void
      {
         super.changeFocus();
         if(_selected && this._dropdownRef)
         {
            this.close();
         }
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         if(!_selected)
         {
            this.open();
         }
         else
         {
            this.close();
         }
         super.handleClick();
      }
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      protected function populateText(param1:Object) : void
      {
         this.updateLabel(param1);
         dispatchEventAndSound(new Event(Event.CHANGE));
      }
      
      protected function updateLabel(param1:Object) : void
      {
         _label = this.itemToLabel(param1);
      }
      
      protected function handleStageClick(param1:MouseEvent) : void
      {
         if(this.contains(param1.target as DisplayObject))
         {
            return;
         }
         if(this._dropdownRef.contains(param1.target as DisplayObject))
         {
            return;
         }
         this.close();
      }
      
      protected function showDropdown() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         if(this.dropdown == null)
         {
            return;
         }
         if(this.dropdown is String && this.dropdown != "")
         {
            _loc2_ = App.utils.classFactory.getClass(this.dropdown.toString(),loaderInfo);
            if(_loc2_ != null)
            {
               _loc1_ = App.utils.classFactory.getComponent(this.dropdown.toString(),CoreList,null,loaderInfo) as CoreList;
            }
         }
         if(_loc1_)
         {
            if(this.itemRenderer is String && this.itemRenderer != "")
            {
               _loc1_.itemRenderer = App.utils.classFactory.getClass(this.itemRenderer.toString(),loaderInfo);
            }
            else if(this.itemRenderer is Class)
            {
               _loc1_.itemRenderer = this.itemRenderer as Class;
            }
            if(this.scrollBar is String && this.scrollBar != "")
            {
               _loc1_.scrollBar = App.utils.classFactory.getClass(this.scrollBar.toString(),loaderInfo);
            }
            else if(this.scrollBar is Class)
            {
               _loc1_.scrollBar = this.scrollBar as Class;
            }
            _loc1_.selectedIndex = this._selectedIndex;
            _loc1_.width = this.menuWidth == -1 ? Number(width + this.menuOffset.left + this.menuOffset.right) : Number(this.menuWidth);
            _loc1_.dataProvider = this._dataProvider;
            _loc1_.padding = this.menuPadding;
            _loc1_.wrapping = this.menuWrapping;
            _loc1_.margin = this.menuMargin;
            _loc1_.thumbOffset = {
               "top":this.thumbOffsetTop,
               "bottom":this.thumbOffsetBottom
            };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = this.menuRowCount < 1 ? 5 : this.menuRowCount;
            _loc1_.labelField = this._labelField;
            _loc1_.labelFunction = this._labelFunction;
            _loc1_.addEventListener(ListEvent.ITEM_CLICK,this.handleMenuItemClick,false,0,true);
            this._dropdownRef = _loc1_;
            this._dropdownRef.name = "dropDownList";
            this._dropdownRef.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.dropdownRefReadyForTutorialHandler);
            PopUpManager.show(_loc1_,x + this.menuOffset.left,this.menuDirection == "down" ? Number(y + height + this.menuOffset.top) : Number(y - this._dropdownRef.height + this.menuOffset.bottom),parent);
         }
      }
      
      protected function hideDropdown() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         if(this._dropdownRef)
         {
            this._dropdownRef.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,this.dropdownRefReadyForTutorialHandler);
            _loc1_ = this._dropdownRef.parent;
            if(_loc1_)
            {
               _loc1_.removeChild(this._dropdownRef);
            }
            this._dropdownRef = null;
         }
      }
      
      protected function handleMenuItemClick(param1:ListEvent) : void
      {
         this.selectedIndex = param1.index;
         this.close();
      }
      
      protected function dropdownRefReadyForTutorialHandler(param1:TutorialEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.addPathPoint(this,name);
         dispatchEvent(param1);
      }
   }
}
