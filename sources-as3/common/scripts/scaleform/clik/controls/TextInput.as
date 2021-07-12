package scaleform.clik.controls
{
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.managers.FocusHandler;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.FocusManager;
   import scaleform.gfx.MouseEventEx;
   
   [Event(name="stateChange",type="scaleform.clik.events.ComponentEvent")]
   public class TextInput extends UIComponent
   {
       
      
      public var defaultTextFormat:TextFormat;
      
      public var constraintsDisabled:Boolean = false;
      
      protected var _text:String = "";
      
      protected var _displayAsPassword:Boolean = false;
      
      protected var _maxChars:uint = 0;
      
      protected var _editable:Boolean = true;
      
      protected var _actAsButton:Boolean = false;
      
      protected var _alwaysShowSelection:Boolean = false;
      
      protected var _isHtml:Boolean = false;
      
      protected var _state:String = "default";
      
      protected var _newFrame:String;
      
      protected var _textFormat:TextFormat;
      
      protected var _usingDefaultTextFormat:Boolean = true;
      
      protected var _defaultText:String = "";
      
      private var hscroll:Number = 0;
      
      public var textField:TextField;
      
      public function TextInput()
      {
         super();
      }
      
      override protected function preInitialize() : void
      {
         if(!this.constraintsDisabled)
         {
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
         }
      }
      
      override protected function initialize() : void
      {
         super.tabEnabled = false;
         mouseEnabled = mouseChildren = this.enabled;
         super.initialize();
         this._textFormat = this.textField.getTextFormat();
         this.defaultTextFormat = new TextFormat();
         this.defaultTextFormat.italic = true;
         this.defaultTextFormat.color = 11184810;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
         super.tabEnabled = false;
         tabChildren = _focusable;
         this.setState(this.defaultState);
      }
      
      [Inspectable(defaultValue="true")]
      override public function get focusable() : Boolean
      {
         return _focusable;
      }
      
      override public function set focusable(param1:Boolean) : void
      {
         _focusable = param1;
         if(!_focusable && this.enabled)
         {
            tabChildren = false;
         }
         this.changeFocus();
         if(_focusable && this.editable)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown,false);
         }
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._isHtml = false;
         this._text = param1;
         invalidateData();
      }
      
      public function get htmlText() : String
      {
         return this._text;
      }
      
      public function set htmlText(param1:String) : void
      {
         this._isHtml = true;
         this._text = param1;
         invalidateData();
      }
      
      [Inspectable(defaultValue="",type="String",verbose="1")]
      public function get defaultText() : String
      {
         return this._defaultText;
      }
      
      public function set defaultText(param1:String) : void
      {
         this._defaultText = param1;
         invalidateData();
      }
      
      [Inspectable(defaultValue="false")]
      public function get displayAsPassword() : Boolean
      {
         return this._displayAsPassword;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         this._displayAsPassword = param1;
         if(this.textField != null)
         {
            this.textField.displayAsPassword = param1;
         }
      }
      
      [Inspectable(defaultValue="0")]
      public function get maxChars() : uint
      {
         return this._maxChars;
      }
      
      public function set maxChars(param1:uint) : void
      {
         this._maxChars = param1;
         if(this.textField != null)
         {
            this.textField.maxChars = param1;
         }
      }
      
      [Inspectable(defaultValue="true")]
      public function get editable() : Boolean
      {
         return this._editable;
      }
      
      public function set editable(param1:Boolean) : void
      {
         this._editable = param1;
         if(this.textField != null)
         {
            this.textField.type = this._editable && this.enabled ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
         }
         this.focusable = param1;
      }
      
      override public function get tabEnabled() : Boolean
      {
         return this.textField.tabEnabled;
      }
      
      override public function set tabEnabled(param1:Boolean) : void
      {
         this.textField.tabEnabled = param1;
      }
      
      override public function get tabIndex() : int
      {
         return this.textField.tabIndex;
      }
      
      override public function set tabIndex(param1:int) : void
      {
         this.textField.tabIndex = param1;
      }
      
      [Inspectable(defaultValue="false")]
      public function get actAsButton() : Boolean
      {
         return this._actAsButton;
      }
      
      public function set actAsButton(param1:Boolean) : void
      {
         if(this._actAsButton == param1)
         {
            return;
         }
         this._actAsButton = param1;
         if(param1)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.handleRollOver,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.handleRollOut,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.ROLL_OVER,this.handleRollOver,false);
            removeEventListener(MouseEvent.ROLL_OUT,this.handleRollOut,false);
         }
      }
      
      public function get alwaysShowSelection() : Boolean
      {
         return this._alwaysShowSelection;
      }
      
      public function set alwaysShowSelection(param1:Boolean) : void
      {
         this._alwaysShowSelection = param1;
         if(this.textField != null)
         {
            this.textField.alwaysShowSelection = param1;
         }
      }
      
      public function get length() : uint
      {
         return this.textField.length;
      }
      
      public function get defaultState() : String
      {
         return !this.enabled ? "disabled" : (Boolean(focused) ? "focused" : "default");
      }
      
      public function appendText(param1:String) : void
      {
         this._text += param1;
         this._isHtml = false;
         invalidateData();
      }
      
      public function appendHtml(param1:String) : void
      {
         this._text += param1;
         this._isHtml = true;
         invalidateData();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD)
         {
            return;
         }
      }
      
      override public function toString() : String
      {
         return "[CLIK TextInput " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!this.constraintsDisabled)
         {
            constraints.addElement("textField",this.textField,Constraints.ALL);
         }
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.textField.addEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false,0,true);
         if(this.focusable && this.editable)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown,false,0,true);
         }
         this.setState(this.defaultState,"default");
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._newFrame)
            {
               gotoAndPlay(this._newFrame);
               this._newFrame = null;
            }
            this.updateAfterStateChange();
            this.updateTextField();
            dispatchEventAndSound(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.SIZE);
         }
         else if(isInvalid(InvalidationType.DATA))
         {
            this.updateText();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            if(!this.constraintsDisabled)
            {
               constraints.update(_width,_height);
            }
         }
      }
      
      override protected function changeFocus() : void
      {
         this.setState(this.defaultState);
      }
      
      protected function updateTextField() : void
      {
         if(this.textField == null)
         {
            return;
         }
         this.updateText();
         this.textField.maxChars = this._maxChars;
         this.textField.alwaysShowSelection = this._alwaysShowSelection;
         this.textField.selectable = !!this.enabled ? Boolean(this._editable) : Boolean(this.enabled);
         this.textField.type = this._editable && this.enabled ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
         this.textField.tabEnabled = this._editable && this.enabled && _focusable;
         this.textField.addEventListener(Event.CHANGE,this.handleTextChange,false,0,true);
         if(this.textField.hasEventListener(FocusEvent.FOCUS_IN))
         {
            this.textField.removeEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false);
         }
         this.textField.addEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false,0,true);
      }
      
      protected function handleTextFieldFocusIn(param1:FocusEvent) : void
      {
         if(this.editable)
         {
            FocusHandler.getInstance().setFocus(this);
         }
      }
      
      protected function updateText() : void
      {
         if(_focused && this._usingDefaultTextFormat)
         {
            this.textField.defaultTextFormat = this._textFormat;
            this._usingDefaultTextFormat = false;
            if(this._displayAsPassword && !this.textField.displayAsPassword)
            {
               this.textField.displayAsPassword = true;
            }
         }
         if(this._text != "")
         {
            if(this._isHtml)
            {
               this.textField.htmlText = this._text;
            }
            else
            {
               this.textField.text = this._text;
            }
         }
         else
         {
            this.textField.text = "";
            if(!_focused && this._defaultText != "")
            {
               if(this._displayAsPassword)
               {
                  this.textField.displayAsPassword = false;
               }
               this.textField.text = this._defaultText;
               this._usingDefaultTextFormat = true;
               if(this.defaultTextFormat != null)
               {
                  this.textField.setTextFormat(this.defaultTextFormat);
               }
            }
         }
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
      
      protected function updateAfterStateChange() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(!initialized)
         {
            return;
         }
         constraints.updateElement("textField",this.textField);
         if(_focused)
         {
            if(Extensions.isScaleform)
            {
               _loc1_ = Extensions.numControllers;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  if(FocusManager.getFocus(_loc2_) == this)
                  {
                     App.utils.scheduler.scheduleOnNextFrame(this.trySetFocus,_loc2_);
                  }
                  _loc2_++;
               }
            }
            else
            {
               stage.focus = this.textField;
            }
         }
      }
      
      private function trySetFocus(param1:int) : void
      {
         if(hasFocus)
         {
            FocusManager.setFocus(this.textField,param1);
         }
      }
      
      protected function handleRollOver(param1:MouseEvent) : void
      {
         if(focused || !this.enabled)
         {
            return;
         }
         this.setState("over");
      }
      
      protected function handleRollOut(param1:MouseEvent) : void
      {
         if(focused || !this.enabled)
         {
            return;
         }
         this.setState("out","default");
      }
      
      protected function handleMouseDown(param1:MouseEvent) : void
      {
         if(focused || !this.enabled)
         {
            return;
         }
         if(param1 is MouseEventEx)
         {
            FocusManager.setFocus(this.textField,(param1 as MouseEventEx).mouseIdx);
         }
         else
         {
            stage.focus = this.textField;
         }
      }
      
      protected function handleTextChange(param1:Event) : void
      {
         if(!_focused)
         {
            return;
         }
         this._text = !!this._isHtml ? this.textField.htmlText : this.textField.text;
         dispatchEventAndSound(new Event(Event.CHANGE));
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.handleMouseDown,false);
         removeEventListener(MouseEvent.ROLL_OVER,this.handleRollOver,false);
         removeEventListener(MouseEvent.ROLL_OUT,this.handleRollOut,false);
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         this.textField.removeEventListener(Event.CHANGE,this.handleTextChange,false);
         this.textField.removeEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false);
         this.defaultTextFormat = null;
         this._textFormat = null;
         super.onDispose();
      }
   }
}
