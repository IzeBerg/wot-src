package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import net.wg.gui.components.controls.events.DropdownMenuEvent;
   import net.wg.gui.components.controls.events.ScrollBarEvent;
   import net.wg.gui.components.controls.helpers.ListUtils;
   import net.wg.infrastructure.events.TutorialEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.DropdownMenu;
   import scaleform.clik.controls.ScrollingList;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   [InspectableList("visible")]
   [Event(name="listIndexChange",type="scaleform.clik.events.ListEvent")]
   [Event(name="on_mouse_wheel_inside",type="net.wg.gui.components.controls.events.ScrollBarEvent")]
   [Event(name="closeDropDown",type="net.wg.gui.components.controls.events.DropdownMenuEvent")]
   [Event(name="showDropDown",type="net.wg.gui.components.controls.events.DropdownMenuEvent")]
   public class DropdownMenu extends scaleform.clik.controls.DropdownMenu implements ISoundable
   {
      
      private static const HANDLE_SCROLL_INV:String = "handleScrollInv";
      
      private static const INV_LIST_DATA:String = "InvListData";
      
      private static const SHADOW_WIDTH:Number = 6;
       
      
      [Inspectable(defaultValue="true")]
      public var showEmptyItems:Boolean;
      
      [Inspectable(type="String")]
      public var soundId:String = "";
      
      public var disposeDataProvider:Boolean = true;
      
      public var hitMc:MovieClip = null;
      
      public var checkItemDisabledFunction:Function = null;
      
      private var _soundType:String = "dropDownMenu";
      
      private var _handleScroll:Boolean = true;
      
      private var _maxRowCount:int = -1;
      
      private var _allowScrolling:Boolean = true;
      
      public function DropdownMenu()
      {
         super();
      }
      
      [Event(name="closeDropDown",type="net.wg.gui.components.controls.events.DropdownMenuEvent")]
      override public function close() : void
      {
         selected = false;
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick,false);
         App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler,false);
         App.stage.removeEventListener(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE,this.onMouseWheelInsideHandler,false);
         this.hideDropdown();
         if(!_dropdownRef)
         {
            dispatchEvent(new DropdownMenuEvent(DropdownMenuEvent.CLOSE_DROP_DOWN,null));
         }
      }
      
      override public function open() : void
      {
         super.open();
         App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler,false,0,true);
         App.stage.addEventListener(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE,this.onMouseWheelInsideHandler,false);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitArea = this.hitMc;
         buttonMode = true;
         if(App.soundMgr)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
         this.calcMenuAvailableRowCount();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ScrollingList = null;
         var _loc2_:int = 0;
         super.draw();
         if(_dataProvider && isInvalid(INV_LIST_DATA))
         {
            if(isOpen())
            {
               _loc1_ = ScrollingList(_dropdownRef);
               _loc2_ = menuRowCount < 1 ? int(5) : int(menuRowCount);
               if(_loc1_.rowCount != _loc2_)
               {
                  this.close();
                  this.open();
                  ScrollingList(_dropdownRef).validateNow();
               }
               else
               {
                  _loc1_.dataProvider = _dataProvider;
                  _loc1_.validateNow();
               }
            }
         }
         if(isInvalid(HANDLE_SCROLL_INV))
         {
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false);
            if(this._handleScroll)
            {
               addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
            }
         }
      }
      
      [Event(name="showDropDown",type="net.wg.gui.components.controls.events.DropdownMenuEvent")]
      override protected function showDropdown() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Class = null;
         if(dropdown == null)
         {
            return;
         }
         if(menuWidth == -1)
         {
            menuWidth = width - SHADOW_WIDTH;
         }
         if(dropdown is String && dropdown != "")
         {
            _loc2_ = App.utils.classFactory.getClass(dropdown.toString());
            if(_loc2_ != null)
            {
               _loc1_ = CoreList(App.utils.classFactory.getComponent(dropdown.toString(),CoreList));
            }
         }
         if(_loc1_)
         {
            if(itemRenderer is String && itemRenderer != "")
            {
               _loc1_.itemRenderer = App.utils.classFactory.getClass(itemRenderer.toString());
            }
            else if(itemRenderer is Class)
            {
               _loc1_.itemRenderer = itemRenderer as Class;
            }
            if(this._allowScrolling)
            {
               if(scrollBar is String && scrollBar != "")
               {
                  _loc1_.scrollBar = Class(App.utils.classFactory.getClass(scrollBar.toString()));
               }
               else if(scrollBar is Class)
               {
                  _loc1_.scrollBar = scrollBar as Class;
               }
            }
            _loc1_.selectedIndex = _selectedIndex;
            _loc1_.width = menuWidth == -1 ? Number(width + menuOffset.left + menuOffset.right) : Number(menuWidth);
            _loc1_.dataProvider = _dataProvider;
            _loc1_.padding = menuPadding;
            _loc1_.wrapping = menuWrapping;
            _loc1_.margin = menuMargin;
            _loc1_.thumbOffset = {
               "top":thumbOffsetTop,
               "bottom":thumbOffsetBottom
            };
            _loc1_.focusTarget = this;
            _loc1_.rowCount = menuRowCount < 1 ? 5 : menuRowCount;
            _loc1_.labelField = _labelField;
            _loc1_.labelFunction = _labelFunction;
            _loc1_.addEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false,0,true);
            _loc1_.canCleanDataProvider = false;
            _dropdownRef = _loc1_;
            App.utils.popupMgr.show(_loc1_,x + menuOffset.left,menuDirection == "down" ? Number(y + height + menuOffset.top) : Number(y - _dropdownRef.height + menuOffset.bottom),parent);
         }
         stage.addEventListener(Event.RESIZE,this.updateDDPosition);
         if(_dropdownRef)
         {
            _dropdownRef.name = "dropDownList";
            _dropdownRef.addEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,dropdownRefReadyForTutorialHandler);
            dispatchEvent(new DropdownMenuEvent(DropdownMenuEvent.SHOW_DROP_DOWN,_dropdownRef));
            this.callDropDownLogEvent(EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_DROPDOWN_OPEN);
         }
      }
      
      override protected function hideDropdown() : void
      {
         if(_dropdownRef)
         {
            IDisposable(_dropdownRef).dispose();
            this.callDropDownLogEvent(EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_DROPDOWN_CLOSE);
         }
         super.hideDropdown();
         App.stage.removeEventListener(Event.RESIZE,this.updateDDPosition);
      }
      
      override protected function updateText() : void
      {
         if(_label != null && textField != null)
         {
            textField.htmlText = _label;
         }
      }
      
      override protected function onDispose() : void
      {
         this.checkItemDisabledFunction = null;
         removeEventListener(Event.ADDED,addToAutoGroup);
         removeEventListener(Event.REMOVED,addToAutoGroup);
         removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress);
         removeEventListener(MouseEvent.CLICK,handleMouseRelease);
         removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease);
         removeEventListener(InputEvent.INPUT,handleInput);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.handleStageClick);
         App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler,false);
         App.stage.removeEventListener(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE,this.onMouseWheelInsideHandler,false);
         if(_repeatTimer)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat,false);
         }
         if(_dropdownRef)
         {
            _dropdownRef.removeEventListener(ListEvent.ITEM_CLICK,handleMenuItemClick,false);
            if(_dropdownRef is IDisposable)
            {
               IDisposable(_dropdownRef).dispose();
            }
            _dropdownRef.parent.removeChild(_dropdownRef);
            _dropdownRef.removeEventListener(TutorialEvent.VIEW_READY_FOR_TUTORIAL,dropdownRefReadyForTutorialHandler);
            _dropdownRef = null;
         }
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
            if(this.disposeDataProvider)
            {
               _dataProvider.cleanUp();
            }
            _dataProvider = null;
         }
         if(scrollBar && scrollBar is IDisposable)
         {
            IDisposable(scrollBar).dispose();
         }
         if(App.soundMgr)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         scrollBar = null;
         this.hitMc = null;
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.enabled;
      }
      
      public function getFirstSelectablePosition(param1:int, param2:Boolean = true) : int
      {
         return ListUtils.getFirstSelectablePosition(param1,selectedIndex,_dataProvider,param2,this.checkItemDisabledFunction);
      }
      
      public final function getSoundId() : String
      {
         return this.soundId;
      }
      
      public final function getSoundType() : String
      {
         return this.soundType;
      }
      
      private function tryClosedDropDown() : void
      {
         if(isOpen())
         {
            if(!_dropdownRef.hitTestPoint(stage.mouseX,stage.mouseY,true))
            {
               this.close();
            }
         }
      }
      
      private function calcMenuAvailableRowCount() : void
      {
         var _loc1_:uint = Boolean(_dataProvider) ? uint(_dataProvider.length) : uint(0);
         if(!menuRowsFixed)
         {
            if(this._maxRowCount < 0)
            {
               menuRowCount = _loc1_;
               this._allowScrolling = false;
            }
            else if(this._maxRowCount < _loc1_)
            {
               menuRowCount = this._maxRowCount;
               this._allowScrolling = true;
            }
            else
            {
               menuRowCount = _loc1_;
               this._allowScrolling = false;
            }
         }
         else
         {
            menuRowCount = this._maxRowCount;
            this._allowScrolling = true;
         }
      }
      
      private function callDropDownLogEvent(param1:String) : void
      {
         var _loc2_:DisplayObject = this as DisplayObject;
         App.utils.asserter.assertNotNull(_loc2_,Errors.CANT_NULL);
         App.eventLogManager.logUIElementDropDown(_loc2_,param1,0);
      }
      
      [Event(name="listIndexChange",type="scaleform.clik.events.ListEvent")]
      override public function set selectedIndex(param1:int) : void
      {
         var _loc2_:CoreList = null;
         var _loc3_:uint = 0;
         if(_selectedIndex == param1)
         {
            return;
         }
         _selectedIndex = param1;
         invalidateSelectedIndex();
         if(_dropdownRef != null)
         {
            _loc2_ = CoreList(_dropdownRef);
            _loc3_ = _loc2_ is ScrollingList ? uint(ScrollingList(_loc2_).scrollPosition) : uint(0);
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE,true,false,_selectedIndex,-1,-1,_loc2_.getRendererAt(_selectedIndex,_loc3_),_dataProvider.requestItemAt(_selectedIndex)));
         }
         else
         {
            dispatchEvent(new ListEvent(ListEvent.INDEX_CHANGE,true,false,_selectedIndex,-1,-1,null,_dataProvider.requestItemAt(_selectedIndex)));
         }
      }
      
      [Inspectable(defaultValue="false",verbose="1")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(super.enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         if(stage)
         {
            this.close();
         }
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(_dataProvider == param1)
         {
            return;
         }
         if(_dataProvider != null)
         {
            _dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange,false);
            if(this.disposeDataProvider)
            {
               _dataProvider.cleanUp();
            }
         }
         _dataProvider = param1;
         if(_dataProvider == null)
         {
            return;
         }
         this.calcMenuAvailableRowCount();
         _dataProvider.addEventListener(Event.CHANGE,this.handleDataChange,false,0,true);
         invalidateData();
         invalidate(INV_LIST_DATA);
      }
      
      [Inspectable(defaultValue="dropDownMenu",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      [Inspectable(defaultValue="-1",name="menuRowCount",variable="rowCount")]
      public function get rowCount() : int
      {
         return this._maxRowCount;
      }
      
      public function set rowCount(param1:int) : void
      {
         this._maxRowCount = param1;
         this.calcMenuAvailableRowCount();
         invalidateData();
      }
      
      public function get handleScroll() : Boolean
      {
         return this._handleScroll;
      }
      
      public function set handleScroll(param1:Boolean) : void
      {
         if(this._handleScroll != param1)
         {
            this._handleScroll = param1;
            invalidate(HANDLE_SCROLL_INV);
         }
      }
      
      override protected function handleDataChange(param1:Event) : void
      {
         this.calcMenuAvailableRowCount();
         super.handleDataChange(param1);
         invalidate(INV_LIST_DATA);
      }
      
      override protected function handleStageClick(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         if(this.contains(_loc2_))
         {
            return;
         }
         if(this._dropdownRef && this._dropdownRef.contains(_loc2_))
         {
            return;
         }
         this.close();
      }
      
      protected function updateDDPosition(param1:Event) : void
      {
         var _loc2_:Number = x + menuOffset.left;
         var _loc3_:Number = menuDirection == "down" ? Number(y + height + menuOffset.top) : Number(y - _dropdownRef.height + menuOffset.bottom);
         var _loc4_:Point = parent.localToGlobal(new Point(_loc2_,_loc3_));
         _dropdownRef.x = _loc4_.x / App.appScale >> 0;
         _dropdownRef.y = _loc4_.y / App.appScale >> 0;
      }
      
      private function onStageMouseWheelHandler(param1:MouseEvent) : void
      {
         if(App.contextMenuMgr.isShown())
         {
            return;
         }
         this.tryClosedDropDown();
      }
      
      private function onMouseWheelInsideHandler(param1:ScrollBarEvent) : void
      {
         this.tryClosedDropDown();
      }
      
      [Event(name="on_mouse_wheel_inside",type="net.wg.gui.components.controls.events.ScrollBarEvent")]
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ScrollingList = null;
         if(App.contextMenuMgr.isShown())
         {
            return;
         }
         param1.stopPropagation();
         if(App.stage)
         {
            App.stage.dispatchEvent(new ScrollBarEvent(ScrollBarEvent.ON_MOUSE_WHEEL_INSIDE));
         }
         var _loc2_:int = param1.delta > 0 ? int(-1) : int(1);
         if(_loc2_ == -1)
         {
            if(selectedIndex < 0)
            {
               _loc3_ = this.getFirstSelectablePosition(0,true);
            }
            else if(selectedIndex > this.getFirstSelectablePosition(0,true))
            {
               _loc3_ = this.getFirstSelectablePosition(selectedIndex - 1,false);
            }
            else
            {
               _loc3_ = this.getFirstSelectablePosition(selectedIndex + _loc2_,true);
            }
         }
         else if(selectedIndex == -1)
         {
            _loc3_ = this.getFirstSelectablePosition(0,true);
         }
         else if(selectedIndex < this.getFirstSelectablePosition(_dataProvider.length - 1,false))
         {
            _loc3_ = this.getFirstSelectablePosition(selectedIndex + 1,true);
         }
         else
         {
            _loc3_ = this.getFirstSelectablePosition(selectedIndex + _loc2_,true);
         }
         if(_dropdownRef && _loc3_ != _selectedIndex)
         {
            _loc4_ = _dropdownRef as ScrollingList;
            if(_loc4_)
            {
               _dropdownRef.selectedIndex = _loc3_;
            }
         }
         this.selectedIndex = _loc3_;
      }
   }
}
