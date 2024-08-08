package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.events.NumericStepperEvent;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.NumericStepper;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.FocusManager;
   
   public class NumericStepper extends scaleform.clik.controls.NumericStepper
   {
      
      private static var INVALID_IS_INTEGRAL:String = "invalidIsIntegral";
      
      private static var INVALID_SELECTION:String = "invalidSelection";
      
      public static const NAN_VALUE:Number = -1;
       
      
      public var nextBtn1:SoundButton;
      
      public var prevBtn1:SoundButton;
      
      public var bg:MovieClip;
      
      public var border:MovieClip;
      
      public var focusIndicator:MovieClip = null;
      
      public var states:MovieClip = null;
      
      protected var _integral:Boolean = true;
      
      private var _newFocusIndicatorFrame:String;
      
      private var _oldFocusIndicatorFrame:String;
      
      private var selectionPosBegin:Number = -1;
      
      private var selectionPosEnd:Number = -1;
      
      private var isValueChanged:Boolean = true;
      
      private var _manualValue:Number = NaN;
      
      private var isTextFilterChanged:Boolean;
      
      private var _digits:Number = 0;
      
      private var _digitsStr:String = "";
      
      private var _skipShowNAValue:Boolean = false;
      
      private var _playLimitSnd:Boolean = false;
      
      private var _textFilter:Array;
      
      private var _isUseLoop:Boolean = false;
      
      private var _emptyFieldPattern:String = "";
      
      private var _labelVal:String;
      
      private var _skipValues:Array;
      
      private var _isShowZero:Boolean = false;
      
      private var _canManualInput:Boolean = true;
      
      private var _textColorId:String = "mainText";
      
      private var _currentTextColorId:String;
      
      private var _valueOffset:int = 0;
      
      private var _stepSizeUnbindedToValue:Boolean = false;
      
      public function NumericStepper()
      {
         this._textFilter = [];
         this._labelVal = this._emptyFieldPattern;
         this._skipValues = [];
         this._currentTextColorId = this._textColorId;
         super();
         tabChildren = true;
      }
      
      protected static function stripNulls(param1:String) : String
      {
         while(param1.length > 1 && param1.substr(0,2) != "0." && (param1.length > 0 && param1.substr(0,1) == "0"))
         {
            param1 = param1.substr(1,param1.length - 1);
         }
         return param1;
      }
      
      protected static function stripDecimal(param1:String) : String
      {
         var _loc2_:RegExp = /\.|,/g;
         return param1.replace(_loc2_,"");
      }
      
      private static function get asserter() : IAssertable
      {
         return App.utils.asserter;
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         if(this.states)
         {
            this.states.gotoAndPlay(param1,param2);
         }
         else
         {
            super.gotoAndPlay(param1,param2);
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(this.states)
         {
            this.states.gotoAndStop(param1,param2);
         }
         else
         {
            super.gotoAndStop(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.normalizeValue);
         this._skipValues.splice(0,this._skipValues.length);
         this._skipValues = null;
         nextBtn.removeEventListener(ButtonEvent.DRAG_OUT,this.onNextBtnOut);
         prevBtn.removeEventListener(ButtonEvent.DRAG_OUT,this.onPrevBtnOut);
         nextBtn.removeEventListener(ButtonEvent.DRAG_OVER,this.onNextBtnOver);
         prevBtn.removeEventListener(ButtonEvent.DRAG_OVER,this.onPrevBtnOver);
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.mouseScrollWheelHandler);
         textField.removeEventListener(Event.CHANGE,this.onChanged);
         textField.removeEventListener(FocusEvent.FOCUS_IN,this.onSetTextFieldFocus);
         textField.removeEventListener(FocusEvent.FOCUS_OUT,this.onKillTextFieldFocus);
         this.nextBtn1.dispose();
         this.nextBtn1 = null;
         this.prevBtn1.dispose();
         this.prevBtn1 = null;
         this.bg = null;
         this.border = null;
         this.states = null;
         this.focusIndicator = null;
         this._textFilter.splice(0,this._textFilter.length);
         this._textFilter = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         nextBtn = this.nextBtn1 as SoundButton;
         App.utils.asserter.assertNotNull(nextBtn,"nextBtn" + Errors.CANT_NULL);
         prevBtn = this.prevBtn1 as SoundButton;
         App.utils.asserter.assertNotNull(prevBtn,"prevBtn" + Errors.CANT_NULL);
         super.initialize();
         if(this.states)
         {
            _labelHash = UIComponent.generateLabelHash(this.states);
         }
      }
      
      override protected function configUI() : void
      {
         if(this.states)
         {
            constraintsDisabled = true;
            this.initItems();
         }
         super.configUI();
         App.textMgr.setDefTextSelection(textField);
         tabEnabled = _focusable;
         tabChildren = true;
         textField.addEventListener(Event.CHANGE,this.onChanged);
         this.updateTextFieldProps();
         nextBtn.addEventListener(ButtonEvent.DRAG_OUT,this.onNextBtnOut);
         prevBtn.addEventListener(ButtonEvent.DRAG_OUT,this.onPrevBtnOut);
         nextBtn.addEventListener(ButtonEvent.DRAG_OVER,this.onNextBtnOver);
         prevBtn.addEventListener(ButtonEvent.DRAG_OVER,this.onPrevBtnOver);
         nextBtn.repeatInterval = prevBtn.repeatInterval = 40;
         nextBtn.repeatDelay = prevBtn.repeatDelay = 200;
         addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseScrollWheelHandler,false,0,true);
         this.updateManualInputProps();
         if(this.focusIndicator != null && !this.hasFocus && this.focusIndicator.totalFrames == 1)
         {
            this.focusIndicator.visible = false;
         }
         this.updateEnabledState();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SELECTION))
         {
            this.updateSelection();
         }
         if(this.isTextFilterChanged)
         {
            this.isTextFilterChanged = false;
            textField.filters = null;
            textField.filters = this._textFilter;
         }
         if(isInvalid(INVALID_IS_INTEGRAL))
         {
            textField.restrict = !!this._integral ? "0-9" : "0-9.";
         }
         if(this.isValueChanged)
         {
            this.isValueChanged = false;
            textField.scrollH = 0;
         }
      }
      
      override protected function updateLabel() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = Number.NaN;
         if(this.currentValueIsDefault)
         {
            this._labelVal = this.emptyFieldPattern;
         }
         else
         {
            if(_labelFunction != null)
            {
               this._labelVal = _labelFunction(_value);
            }
            else
            {
               this._labelVal = _value.toString();
            }
            if(this._isShowZero && this._digits > this._labelVal.length)
            {
               _loc2_ = this._digits - this._labelVal.length;
               this._labelVal = this._digitsStr.slice(0,_loc2_) + this._labelVal;
            }
            _loc1_ = _value;
         }
         this.checkTextColor(_loc1_,this._labelVal);
      }
      
      override protected function updateAfterStateChange() : void
      {
         this.updateFocusIndicator();
         invalidateSize();
         this.updateLabel();
         this.updateTextFieldProps();
         if(constraints != null && !constraintsDisabled)
         {
            constraints.updateElement("textField",textField);
         }
      }
      
      override protected function changeFocus() : void
      {
         super.changeFocus();
         this.updateFocusIndicatorStateData();
         if(!this.hasFocus)
         {
            this.selectionPosBegin = textField.text.length;
            this.selectionPosEnd = this.selectionPosBegin;
            invalidate(INVALID_SELECTION);
         }
      }
      
      public function getCurrentColorId() : String
      {
         return this._currentTextColorId;
      }
      
      public function setMaximumWithoutValidation(param1:Number) : void
      {
         _maximum = param1;
         this.calcDigitsCount();
      }
      
      public function setValueWithoutValidation(param1:Number) : void
      {
         if(param1 == _value)
         {
            this._playLimitSnd = false;
            this.updateEnabledState();
            return;
         }
         textField.text = param1.toString();
         _value = param1;
         this.updateEnabledState();
      }
      
      protected function normalizeValue() : void
      {
         if(!isNaN(this._manualValue))
         {
            this.value = this._manualValue;
            this.isValueChanged = true;
            this.selectionPosBegin = 0;
            this.selectionPosEnd = value.toString().length;
            invalidate();
         }
         this._manualValue = Number.NaN;
      }
      
      protected function scrollWheel(param1:Number) : void
      {
         if(!enabled)
         {
            return;
         }
         if(param1 > 0)
         {
            this.onNext(null);
         }
         else
         {
            this.onPrev(null);
         }
      }
      
      private function updateFocusIndicator() : void
      {
         if(this.focusIndicator && this._newFocusIndicatorFrame && this._oldFocusIndicatorFrame != this._newFocusIndicatorFrame)
         {
            this.focusIndicator.gotoAndPlay(this._newFocusIndicatorFrame);
            this._oldFocusIndicatorFrame = this._newFocusIndicatorFrame;
            this._newFocusIndicatorFrame = null;
         }
      }
      
      private function updateFocusIndicatorStateData() : void
      {
         if(this.focusIndicator.totalframes == 1)
         {
            this.focusIndicator.visible = this.hasFocus;
         }
         else
         {
            this._newFocusIndicatorFrame = this.hasFocus || _displayFocus ? "show" : "hide";
         }
      }
      
      private function initItems() : void
      {
         var _loc6_:DisplayObject = null;
         var _loc1_:Number = this.scaleX;
         var _loc2_:Number = this.scaleY;
         var _loc3_:Number = this.actualWidth;
         var _loc4_:Number = this.numChildren;
         setActualScale(1,1);
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = this.getChildAt(_loc5_);
            if(_loc6_ != nextBtn && _loc6_ != prevBtn && _loc6_ != textField)
            {
               _loc6_.scaleX = _loc1_;
               _loc6_.scaleY = _loc2_;
            }
            _loc5_++;
         }
         nextBtn.x = Math.round(_loc3_ - (nextBtn.width + 3));
         prevBtn.x = Math.round(_loc3_ - (prevBtn.width + 3));
         textField.width += _loc3_ - this._originalWidth;
         this._originalWidth = _loc3_;
         setActualSize(this.actualWidth,this.actualHeight);
         setActualScale(1,1);
      }
      
      private function calcDigitsCount() : void
      {
         if(!this._isShowZero)
         {
            return;
         }
         this._digits = _maximum.toString().length;
         if(this._digitsStr.length == this._digits)
         {
            return;
         }
         this._digitsStr = Values.EMPTY_STR;
         var _loc1_:Number = 0;
         while(_loc1_ < this._digits)
         {
            this._digitsStr += "0";
            _loc1_++;
         }
      }
      
      private function updateManualInputProps() : void
      {
         if(this._canManualInput && enabled && _focusable)
         {
            textField.type = TextFieldType.INPUT;
            textField.addEventListener(FocusEvent.FOCUS_IN,this.onSetTextFieldFocus);
            textField.addEventListener(FocusEvent.FOCUS_OUT,this.onKillTextFieldFocus);
         }
         else
         {
            textField.type = TextFieldType.DYNAMIC;
            textField.removeEventListener(FocusEvent.FOCUS_IN,this.onSetTextFieldFocus);
            textField.removeEventListener(FocusEvent.FOCUS_OUT,this.onKillTextFieldFocus);
         }
      }
      
      private function checkLockValue(param1:Number) : Number
      {
         if(param1 == NAN_VALUE && !this._skipShowNAValue)
         {
            return param1;
         }
         if(this.isUseLoop)
         {
            if(param1 > maximum)
            {
               param1 = minimum;
            }
            else if(param1 < minimum)
            {
               param1 = maximum;
            }
         }
         var _loc2_:Number = this._valueOffset + stepSize * Math.round((param1 - this._valueOffset) / stepSize);
         var _loc3_:Number = Math.max(_minimum,Math.min(_maximum,_loc2_));
         if(this._stepSizeUnbindedToValue)
         {
            _loc3_ = Math.max(_minimum,Math.min(_maximum,param1));
         }
         return _loc3_;
      }
      
      private function updateEnabledState() : void
      {
         nextBtn.enabled = nextBtn.mouseEnabled = this.getEnabledForBtn(nextBtn);
         prevBtn.enabled = prevBtn.mouseEnabled = this.getEnabledForBtn(prevBtn);
         this._playLimitSnd = false;
      }
      
      private function getEnabledForBtn(param1:Button) : Boolean
      {
         var _loc2_:Boolean = false;
         if(this.isUseLoop)
         {
            _loc2_ = true;
         }
         else
         {
            _loc2_ = param1 == prevBtn ? Boolean(value != minimum) : Boolean(value != maximum);
         }
         return enabled && _loc2_;
      }
      
      private function updateTextFieldProps() : void
      {
         var _loc1_:Boolean = false;
         if(textField != null)
         {
            _loc1_ = this.enabled && this.canManualInput;
            textField.tabEnabled = textField.mouseEnabled = _loc1_;
            textField.selectable = _loc1_;
         }
      }
      
      private function updateState() : void
      {
         setState(!!enabled ? (!!this.hasFocus ? "focused" : "default") : "disabled");
      }
      
      private function updateSelection() : void
      {
         textField.setSelection(this.selectionPosBegin,this.selectionPosEnd);
      }
      
      private function checkTextColor(param1:Number, param2:String) : void
      {
         var _loc3_:String = Boolean(this.states) ? this.states.currentLabel : currentLabel;
         this._currentTextColorId = TEXT_MANAGER_STYLES.MAIN_TEXT;
         if(_loc3_ == "disabled")
         {
            this._currentTextColorId = TEXT_MANAGER_STYLES.DISABLED_TEXT;
         }
         else if(this._skipValues && this._skipValues.indexOf(param1) != -1)
         {
            this._currentTextColorId = TEXT_MANAGER_STYLES.ERROR_TEXT;
         }
         else
         {
            this._currentTextColorId = this._textColorId;
         }
         dispatchEvent(new NumericStepperEvent(NumericStepperEvent.CHANGE_COLOR_STATE));
         textField.htmlText = App.textMgr.getTextStyleById(this._currentTextColorId,param2);
      }
      
      override public function get hasFocus() : Boolean
      {
         return _focused > 0 || FocusManager.getFocus(0) == textField;
      }
      
      override public function set maximum(param1:Number) : void
      {
         if(_maximum == param1)
         {
            return;
         }
         _maximum = stepSize * Math.floor(param1 / stepSize);
         this.value = _value;
         this.calcDigitsCount();
      }
      
      override public function set minimum(param1:Number) : void
      {
         if(_minimum == param1)
         {
            return;
         }
         _minimum = stepSize * Math.floor(param1 / stepSize);
         this.value = _value;
      }
      
      override public function set value(param1:Number) : void
      {
         var _loc2_:Number = _value;
         param1 = this.checkLockValue(param1);
         if(param1 == _value)
         {
            this._playLimitSnd = false;
            this.updateEnabledState();
            return;
         }
         _value = param1;
         this.updateEnabledState();
         dispatchEventAndSound(new IndexEvent(IndexEvent.INDEX_CHANGE,true,false,value,_loc2_,null));
         this.isValueChanged = true;
         invalidateData();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == enabled)
         {
            return;
         }
         super.enabled = param1;
         this.updateEnabledState();
         this.updateManualInputProps();
      }
      
      public function get integral() : Boolean
      {
         return this._integral;
      }
      
      public function set integral(param1:Boolean) : void
      {
         if(this._integral == param1)
         {
            return;
         }
         this._integral = param1;
         invalidate(INVALID_IS_INTEGRAL);
      }
      
      public function get textFilter() : Array
      {
         return this._textFilter;
      }
      
      public function set textFilter(param1:Array) : void
      {
         if(this._textFilter == param1)
         {
            return;
         }
         this._textFilter = param1;
         this.isTextFilterChanged = true;
         invalidate();
      }
      
      public function get isUseLoop() : Boolean
      {
         return this._isUseLoop;
      }
      
      public function set isUseLoop(param1:Boolean) : void
      {
         this._isUseLoop = param1;
      }
      
      public function get emptyFieldPattern() : String
      {
         return this._emptyFieldPattern;
      }
      
      public function set emptyFieldPattern(param1:String) : void
      {
         this._emptyFieldPattern = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function get skipValues() : Array
      {
         return this._skipValues;
      }
      
      public function set skipValues(param1:Array) : void
      {
         this._skipValues = param1;
         invalidate(InvalidationType.DATA);
      }
      
      public function set isShowZero(param1:Boolean) : void
      {
         this._isShowZero = param1;
         this.calcDigitsCount();
      }
      
      public function get canManualInput() : Boolean
      {
         return this._canManualInput;
      }
      
      public function set canManualInput(param1:Boolean) : void
      {
         this._canManualInput = param1;
         this.updateManualInputProps();
         this.updateTextFieldProps();
      }
      
      public function get textColorId() : String
      {
         return this._textColorId;
      }
      
      public function set textColorId(param1:String) : void
      {
         if(this._textColorId == param1)
         {
            return;
         }
         this._textColorId = param1;
         this.checkTextColor(_value,this._labelVal);
      }
      
      public function get currentValueIsDefault() : Boolean
      {
         return value == NAN_VALUE;
      }
      
      public function get isSkipValue() : Boolean
      {
         return this._skipValues && this._skipValues.indexOf(_value) != -1;
      }
      
      public function set valueOffset(param1:int) : void
      {
         this._valueOffset = param1;
      }
      
      public function set stepSizeUnbindedToValue(param1:Boolean) : void
      {
         this._stepSizeUnbindedToValue = param1;
      }
      
      public function get manualValue() : Number
      {
         return this._manualValue;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.isDefaultPrevented())
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         var _loc3_:Boolean = _loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD;
         if(_loc2_.code == Keyboard.NUMPAD_ADD)
         {
            _loc2_.navEquivalent = NavigationCode.UP;
         }
         else if(_loc2_.code == Keyboard.NUMPAD_SUBTRACT)
         {
            _loc2_.navEquivalent = NavigationCode.DOWN;
         }
         switch(_loc2_.navEquivalent)
         {
            case NavigationCode.UP:
               if(_value < _maximum || this.currentValueIsDefault || this.isUseLoop)
               {
                  if(_loc3_)
                  {
                     this.onNext(null);
                  }
               }
               else
               {
                  this.selectionPosBegin = this.selectionPosEnd = textField.text.length;
                  invalidate(INVALID_SELECTION);
               }
               param1.handled = true;
               break;
            case NavigationCode.LEFT:
            case NavigationCode.RIGHT:
               break;
            case NavigationCode.DOWN:
               if(_loc3_ && (_value > _minimum || this.currentValueIsDefault || this.isUseLoop))
               {
                  this.onPrev(null);
               }
               param1.handled = true;
               break;
            case NavigationCode.HOME:
               if(!_loc3_ && !_loc2_.shiftKey)
               {
                  this.value = _minimum;
               }
               param1.handled = true;
               break;
            case NavigationCode.END:
               if(!_loc3_ && !_loc2_.shiftKey)
               {
                  this.value = _maximum;
               }
               param1.handled = true;
               break;
            case NavigationCode.ENTER:
               if(!_loc3_)
               {
                  if(_loc2_.code == Keyboard.ENTER)
                  {
                     this.normalizeValue();
                     if(initialized)
                     {
                        dispatchEvent(new NumericStepperEvent(NumericStepperEvent.SUBMIT));
                     }
                  }
               }
         }
      }
      
      override protected function onNext(param1:ButtonEvent) : void
      {
         if(!isNaN(this._manualValue))
         {
            this.normalizeValue();
         }
         if(this.currentValueIsDefault)
         {
            this.value = minimum;
         }
         else
         {
            this._playLimitSnd = true;
            this._skipShowNAValue = true;
            this.value = value + stepSize;
            this._skipShowNAValue = false;
         }
         this.selectionPosBegin = this.selectionPosEnd = value.toString().length;
         invalidate(INVALID_SELECTION);
      }
      
      override protected function onPrev(param1:ButtonEvent) : void
      {
         if(!isNaN(this._manualValue))
         {
            this.normalizeValue();
         }
         if(this.currentValueIsDefault)
         {
            this.value = minimum;
         }
         else
         {
            this._playLimitSnd = true;
            this._skipShowNAValue = true;
            this.value = value - stepSize;
            this._skipShowNAValue = false;
         }
         this.selectionPosBegin = this.selectionPosEnd = value.toString().length;
         invalidate(INVALID_SELECTION);
      }
      
      protected function onChanged(param1:Event) : void
      {
         var _loc2_:IScheduler = App.utils.scheduler;
         _loc2_.cancelTask(this.normalizeValue);
         var _loc3_:String = stripNulls(textField.text);
         if(this.integral)
         {
            _loc3_ = stripDecimal(_loc3_);
         }
         var _loc4_:Number = Number(_loc3_);
         if(textField.text == "" || isNaN(_loc4_))
         {
            _loc4_ = _minimum;
         }
         this._manualValue = _loc4_;
         _loc2_.scheduleTask(this.normalizeValue,1000);
      }
      
      protected function onKillTextFieldFocus(param1:FocusEvent) : void
      {
         this.normalizeValue();
         this.updateFocusIndicatorStateData();
         this.updateState();
      }
      
      protected function onSetTextFieldFocus(param1:FocusEvent) : void
      {
         this.selectionPosBegin = 0;
         this.selectionPosEnd = textField.text.length;
         this.updateFocusIndicatorStateData();
         this.updateState();
         textField.scrollH = 0;
         invalidate(INVALID_SELECTION);
      }
      
      protected function onNextBtnOut(param1:ButtonEvent) : void
      {
         SoundButton(nextBtn).clearRepeatInterval();
      }
      
      protected function onPrevBtnOut(param1:ButtonEvent) : void
      {
         SoundButton(prevBtn).clearRepeatInterval();
      }
      
      protected function onNextBtnOver(param1:ButtonEvent) : void
      {
         SoundButton(nextBtn).beginButtonRepeat();
      }
      
      protected function onPrevBtnOver(param1:ButtonEvent) : void
      {
         SoundButton(prevBtn).beginButtonRepeat();
      }
      
      private function mouseScrollWheelHandler(param1:MouseEvent) : void
      {
         this.scrollWheel(param1.delta);
      }
   }
}
