package scaleform.clik.controls
{
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   
   [Event(name="change",type="flash.events.Event")]
   public class OptionStepper extends UIComponent
   {
       
      
      public var selectedItem:Object;
      
      protected var _dataProvider:IDataProvider;
      
      protected var _selectedIndex:Number = 0;
      
      protected var _newSelectedIndex:int = 0;
      
      protected var _labelField:String = "label";
      
      protected var _labelFunction:Function;
      
      protected var _state:String = "default";
      
      protected var _newFrame:String;
      
      protected var _constraintsDisabled:Boolean = false;
      
      public var textField:TextField;
      
      public var nextBtn:Button;
      
      public var prevBtn:Button;
      
      public function OptionStepper()
      {
         super();
      }
      
      override protected function preInitialize() : void
      {
         if(!this._constraintsDisabled)
         {
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
         }
      }
      
      override protected function initialize() : void
      {
         this.dataProvider = new DataProvider();
         super.initialize();
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = param1;
         mouseEnabled = this.enabled;
         tabEnabled = _focusable && this.enabled;
         gotoAndPlay(!!param1 ? (_focused > 0 ? "focused" : "default") : "disabled");
         if(!initialized)
         {
            return;
         }
         this.updateAfterStateChange();
         this.prevBtn.enabled = this.nextBtn.enabled = param1;
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
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider != param1)
         {
            if(this._dataProvider != null)
            {
               this._dataProvider.removeEventListener(Event.CHANGE,this.handleDataChange);
            }
            this._dataProvider = param1;
            this.selectedItem = null;
            if(this._dataProvider == null)
            {
               return;
            }
            this._dataProvider.addEventListener(Event.CHANGE,this.handleDataChange);
         }
         invalidateData();
         this.updateSelectedItem();
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc2_:Number = Math.max(0,Math.min(this._dataProvider.length - 1,param1));
         if(_loc2_ == this._selectedIndex || _loc2_ == this._newSelectedIndex)
         {
            return;
         }
         this._newSelectedIndex = _loc2_;
         this.invalidateSelectedIndex();
      }
      
      public function get labelField() : String
      {
         return this._labelField;
      }
      
      public function set labelField(param1:String) : void
      {
         this._labelField = param1;
         this.updateLabel();
      }
      
      public function get labelFunction() : Function
      {
         return this._labelFunction;
      }
      
      public function set labelFunction(param1:Function) : void
      {
         this._labelFunction = param1;
         this.updateLabel();
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
         if(this._labelField != null && this._labelField in param1 && param1[this._labelField] != null)
         {
            return param1[this._labelField];
         }
         return param1.toString();
      }
      
      public function invalidateSelectedIndex() : void
      {
         invalidate(InvalidationType.SELECTED_INDEX);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:uint = _loc2_.controllerIndex;
         var _loc4_:Boolean = _loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD;
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.RIGHT:
               if(this._selectedIndex < this._dataProvider.length - 1)
               {
                  if(_loc4_)
                  {
                     this.onNext(null);
                  }
                  param1.handled = true;
               }
               break;
            case NavigationCode.LEFT:
               if(this._selectedIndex > 0)
               {
                  if(_loc4_)
                  {
                     this.onPrev(null);
                  }
                  param1.handled = true;
               }
               break;
            case NavigationCode.HOME:
               if(!_loc4_)
               {
                  this.selectedIndex = 0;
               }
               param1.handled = true;
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  this.selectedIndex = this._dataProvider.length - 1;
               }
               param1.handled = true;
         }
      }
      
      override public function toString() : String
      {
         return "[CLIK OptionStepper " + name + "]";
      }
      
      override protected function configUI() : void
      {
         if(!this._constraintsDisabled)
         {
            constraints.addElement("textField",this.textField,Constraints.ALL);
         }
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.nextBtn.addEventListener(ButtonEvent.CLICK,this.onNext,false,0,true);
         this.prevBtn.addEventListener(ButtonEvent.CLICK,this.onPrev,false,0,true);
         tabEnabled = _focusable;
         tabChildren = false;
         this.textField.tabEnabled = this.textField.mouseEnabled = false;
         this.prevBtn.enabled = this.nextBtn.enabled = this.enabled;
         this.prevBtn.autoRepeat = this.nextBtn.autoRepeat = true;
         this.prevBtn.focusable = this.nextBtn.focusable = false;
         this.prevBtn.focusTarget = this.nextBtn.focusTarget = this;
         this.prevBtn.tabEnabled = this.nextBtn.tabEnabled = false;
         this.prevBtn.mouseEnabled = this.nextBtn.mouseEnabled = true;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SELECTED_INDEX))
         {
            this.updateSelectedIndex();
         }
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._newFrame)
            {
               gotoAndPlay(this._newFrame);
               this._newFrame = null;
            }
            this.updateAfterStateChange();
            dispatchEventAndSound(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.refreshData();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            if(!this._constraintsDisabled)
            {
               constraints.update(_width,_height);
            }
         }
      }
      
      override protected function changeFocus() : void
      {
         if(_focused || _displayFocus)
         {
            this.setState("focused","default");
         }
         else
         {
            this.setState("default");
         }
         this.prevBtn.displayFocus = this.nextBtn.displayFocus = _focused > 0;
      }
      
      protected function updateSelectedIndex() : void
      {
         if(this._selectedIndex == this._newSelectedIndex)
         {
            return;
         }
         var _loc1_:int = this._selectedIndex;
         this._selectedIndex = this._newSelectedIndex;
         dispatchEventAndSound(new IndexEvent(IndexEvent.INDEX_CHANGE,true,false,this._selectedIndex,_loc1_,this.dataProvider[this._selectedIndex]));
         this.updateSelectedItem();
      }
      
      protected function refreshData() : void
      {
         this._dataProvider.requestItemAt(this._selectedIndex,this.populateText);
      }
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      protected function updateAfterStateChange() : void
      {
         invalidateSize();
         this.updateLabel();
         this.textField.tabEnabled = this.textField.mouseEnabled = false;
         if(constraints != null && !this._constraintsDisabled)
         {
            constraints.updateElement("textField",this.textField);
         }
      }
      
      protected function updateLabel() : void
      {
         if(this.selectedItem == null)
         {
            return;
         }
         if(this.textField != null)
         {
            this.textField.text = this.itemToLabel(this.selectedItem);
         }
      }
      
      protected function updateSelectedItem() : void
      {
         invalidateData();
      }
      
      protected function populateText(param1:Object) : void
      {
         this.selectedItem = param1;
         this.updateLabel();
         dispatchEventAndSound(new Event(Event.CHANGE));
      }
      
      protected function onNext(param1:Object) : void
      {
         this.selectedIndex += 1;
         this.invalidateSelectedIndex();
      }
      
      protected function onPrev(param1:Object) : void
      {
         this.selectedIndex -= 1;
         this.invalidateSelectedIndex();
      }
      
      protected function setState(... rest) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(rest.length == 1)
         {
            _loc4_ = rest[0].toString();
            if(this._state != _loc4_ && _labelHash[_loc4_])
            {
               this._state = this._newFrame = _loc4_;
               invalidateState();
            }
            return;
         }
         var _loc2_:uint = rest.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = rest[_loc3_].toString();
            if(_labelHash[_loc5_])
            {
               this._state = this._newFrame = _loc5_;
               invalidateState();
               break;
            }
            _loc3_++;
         }
      }
   }
}
