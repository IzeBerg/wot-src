package net.wg.gui.components.advanced.collapsingBar
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.collapsingBar.data.CollapsingBarButtonVO;
   import net.wg.gui.components.advanced.collapsingBar.interfaces.ICollapseChecker;
   import net.wg.gui.components.containers.Group;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class CollapsingBar extends Group
   {
      
      private static const SELECT_INVALID:String = "selectInvalid";
       
      
      protected var buttonGroup:CollapsingGroup = null;
      
      private var _tmpTF:TextField = null;
      
      private var _isBarCollapsed:Boolean = false;
      
      private var _autoCollapsed:Boolean = false;
      
      private var _buttonLinkage:String = "";
      
      private var _collapseChecker:ICollapseChecker = null;
      
      private var _allowedKeyboard:Boolean;
      
      protected var currentSelectedId:int = -1;
      
      public function CollapsingBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buttonGroup.addEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Button = null;
         super.draw();
         if(isInvalid(SELECT_INVALID))
         {
            dispatchEvent(new Event(Event.CHANGE,true));
            _loc1_ = this.buttonGroup.getButtonAt(this.selectedIndex);
            if(this.buttonGroup && _loc1_)
            {
               this.currentSelectedId = _loc1_.data.id;
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.buttonGroup = new CollapsingGroup(this);
         this._tmpTF = new TextField();
      }
      
      override protected function onDispose() : void
      {
         this.buttonGroup.removeEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
         removeEventListener(InputEvent.INPUT,this.handleInput);
         this.removeAllButtons();
         this.buttonGroup.dispose();
         this.buttonGroup = null;
         this._collapseChecker = null;
         this._tmpTF = null;
         super.onDispose();
      }
      
      public function collapseBar(param1:Boolean) : void
      {
         this._isBarCollapsed = param1;
         this.buttonGroup.collapseAll(param1);
         invalidateLayout();
      }
      
      public function getButtonAt(param1:int) : Button
      {
         return this.buttonGroup.getButtonAt(param1);
      }
      
      public function setAutoCollapsed(param1:Boolean, param2:ICollapseChecker) : void
      {
         this._autoCollapsed = param1;
         this._collapseChecker = param2;
      }
      
      public function setCollapsingButtonSize(param1:int, param2:int) : void
      {
         this.buttonGroup.collapsedButtonSize.x = param1;
         this.buttonGroup.collapsedButtonSize.y = param2;
      }
      
      public function setData(param1:DataProvider, param2:int) : void
      {
         this.currentSelectedId = param2 == Values.DEFAULT_INT ? int(this.currentSelectedId) : int(param2);
         this.createTabs(param1);
         if(this._autoCollapsed)
         {
            this._isBarCollapsed = this._collapseChecker.checkCollapsing();
         }
         this.buttonGroup.collapseAll(this._isBarCollapsed);
         invalidate(InvalidationType.LAYOUT,SELECT_INVALID);
         validateNow();
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         if(this._autoCollapsed)
         {
            _loc3_ = this._collapseChecker.checkCollapsing();
            if(_loc3_ != this._isBarCollapsed)
            {
               this.collapseBar(_loc3_);
            }
         }
      }
      
      public function getTextWidth(param1:ResizableButton) : int
      {
         this._tmpTF.text = CollapsingBarButtonVO(param1.data).label;
         return this._tmpTF.textWidth;
      }
      
      protected function applyDataToButton(param1:ResizableButton, param2:CollapsingBarButtonVO) : void
      {
         param1.toggle = true;
         param1.allowDeselect = false;
         param1.mouseEnabledOnDisabled = true;
         param1.tooltip = param2.tooltip;
         param1.data = param2;
         param1.label = param2.label;
      }
      
      protected function calculateExpandedSize(param1:ResizableButton) : Point
      {
         var _loc2_:Point = param1.getOriginSize();
         return new Point(this.calcExpandedWidth(_loc2_),this.calcExpandedHeight(_loc2_));
      }
      
      protected function calcExpandedHeight(param1:Point) : Number
      {
         return Math.max(this.buttonGroup.collapsedButtonSize.y,param1.y);
      }
      
      protected function calcExpandedWidth(param1:Point) : Number
      {
         return Math.max(this.buttonGroup.collapsedButtonSize.x,param1.x);
      }
      
      protected function removeAllButtons() : void
      {
         removeAllChildren(true);
         this.buttonGroup.removeAllButtons();
      }
      
      private function removeLustBtn() : void
      {
         var _loc1_:Button = this.getButtonAt(this.buttonGroup.length - 1);
         this.buttonGroup.removeButton(_loc1_);
         removeChild(_loc1_);
      }
      
      private function addNewBtn() : void
      {
         var _loc1_:ResizableButton = null;
         _loc1_ = App.utils.classFactory.getComponent(this._buttonLinkage,Button);
         _loc1_.owner = this;
         addChild(_loc1_);
         this.buttonGroup.addButton(_loc1_);
      }
      
      protected function createTabs(param1:DataProvider) : void
      {
         var _loc2_:ResizableButton = null;
         var _loc3_:CollapsingBarButtonVO = null;
         var _loc4_:Point = null;
         var _loc8_:int = 0;
         var _loc9_:Button = null;
         var _loc10_:int = 0;
         var _loc5_:int = param1.length;
         var _loc6_:int = this.buttonGroup.length;
         var _loc7_:int = 0;
         if(_loc5_ > _loc6_)
         {
            _loc8_ = _loc5_ - _loc6_;
            _loc7_ = 0;
            while(_loc7_ < _loc8_)
            {
               this.addNewBtn();
               _loc7_++;
            }
            _loc9_ = this.buttonGroup.getButtonAt(0);
            if(_loc9_)
            {
               this.setTextFormat(_loc9_.textField.getTextFormat());
            }
         }
         else if(_loc5_ < _loc6_)
         {
            _loc10_ = _loc6_ - _loc5_;
            _loc7_ = 0;
            while(_loc7_ < _loc10_)
            {
               this.removeLustBtn();
               _loc7_++;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = param1[_loc7_];
            _loc2_ = ResizableButton(this.buttonGroup.getButtonAt(_loc7_));
            _loc2_.resetScale();
            this.applyDataToButton(_loc2_,_loc3_);
            _loc2_.selected = _loc3_.id == this.currentSelectedId;
            _loc4_ = this.calculateExpandedSize(_loc2_);
            this.buttonGroup.maxExpandedSize.x = Math.max(_loc4_.x,this.buttonGroup.maxExpandedSize.x);
            this.buttonGroup.maxExpandedSize.y = Math.max(_loc4_.y,this.buttonGroup.maxExpandedSize.y);
            _loc7_++;
         }
      }
      
      private function setTextFormat(param1:TextFormat) : void
      {
         this._tmpTF.setTextFormat(param1);
         this._tmpTF.defaultTextFormat = param1;
      }
      
      protected function onStageResize() : void
      {
         var _loc1_:Boolean = false;
         if(this._autoCollapsed)
         {
            _loc1_ = this._collapseChecker.checkCollapsing();
            if(_loc1_ != this._isBarCollapsed)
            {
               this.collapseBar(_loc1_);
            }
         }
      }
      
      public function get selectedIndex() : int
      {
         return this.buttonGroup.selectedIndex;
      }
      
      public function get allowedKeyboard() : Boolean
      {
         return this._allowedKeyboard;
      }
      
      public function set allowedKeyboard(param1:Boolean) : void
      {
         this._allowedKeyboard = param1;
      }
      
      public function get autoCollapsed() : Boolean
      {
         return this._autoCollapsed;
      }
      
      public function set buttonLinkage(param1:String) : void
      {
         this._buttonLinkage = param1;
      }
      
      public function get isBarCollapsed() : Boolean
      {
         return this._isBarCollapsed;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc6_:Number = NaN;
         if(!this._allowedKeyboard || param1.handled)
         {
            return;
         }
         var _loc2_:Button = this.getButtonAt(this.selectedIndex) as Button;
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
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:Boolean = false;
         switch(_loc3_.navEquivalent)
         {
            case NavigationCode.LEFT:
               _loc6_ = this.selectedIndex - 1;
               _loc5_ = true;
               break;
            case NavigationCode.RIGHT:
               _loc6_ = this.selectedIndex + 1;
               _loc5_ = true;
         }
         if(_loc5_)
         {
            _loc6_ = Math.max(0,Math.min(this.buttonGroup.length - 1,_loc6_));
            if(_loc6_ != this.selectedIndex)
            {
               this.buttonGroup.setSelectedButtonByIndex(_loc6_);
               param1.handled = true;
               invalidate(SELECT_INVALID);
            }
         }
      }
      
      private function onButtonGroupChangeHandler(param1:Event) : void
      {
         if(this._isBarCollapsed)
         {
            invalidateLayout();
         }
         invalidate(SELECT_INVALID);
      }
   }
}
