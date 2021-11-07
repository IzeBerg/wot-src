package net.wg.gui.components.controls
{
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import scaleform.clik.controls.TextInput;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   import scaleform.gfx.TextFieldEx;
   
   [Event(name="change",type="flash.events.Event")]
   public class TextInput extends scaleform.clik.controls.TextInput
   {
       
      
      public var highlightMc:UIComponent = null;
      
      [Inspectable(defaultValue="true",name="extractEscapes",verbose="1")]
      protected var _extractEscapes:Boolean = true;
      
      private var _selectionTextColor:uint = 1973787;
      
      private var _selectionBgColor:uint = 9868935;
      
      private var _focusOutByWaiting:Boolean = false;
      
      private var _pastSelectionStart:Number = 0;
      
      private var _pastSelectionEnd:Number = 0;
      
      public function TextInput()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.highlightMc.dispose();
         this.highlightMc = null;
         removeEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp,false);
         textField.removeEventListener(FocusEvent.FOCUS_OUT,this.handleTextFieldFocusOut,false);
         super.onDispose();
      }
      
      override public function set focusable(param1:Boolean) : void
      {
         super.focusable = param1;
         if(_focusable && editable)
         {
            addEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp,false);
         }
      }
      
      [Inspectable(defaultValue="#1E1E1B",type="Color")]
      public function get selectionTextColor() : uint
      {
         return this._selectionTextColor;
      }
      
      public function set selectionTextColor(param1:uint) : void
      {
         this._selectionTextColor = this.rgbToArgb(param1);
         TextFieldEx.setSelectionTextColor(textField,this._selectionTextColor);
         TextFieldEx.setInactiveSelectionTextColor(textField,this.rgbToArgb(textField.textColor));
      }
      
      [Inspectable(defaultValue="#969687",type="Color")]
      public function get selectionBgColor() : uint
      {
         return this._selectionBgColor;
      }
      
      public function set selectionBgColor(param1:uint) : void
      {
         this._selectionBgColor = this.rgbToArgb(param1);
         TextFieldEx.setSelectionBkgColor(textField,this._selectionBgColor);
         TextFieldEx.setInactiveSelectionBkgColor(textField,0);
      }
      
      public function get extractEscapes() : Boolean
      {
         return this._extractEscapes;
      }
      
      public function set extractEscapes(param1:Boolean) : void
      {
         if(this._extractEscapes == param1)
         {
            return;
         }
         this._extractEscapes = param1;
      }
      
      public function get highlight() : Boolean
      {
         return this.highlightMc.visible;
      }
      
      public function set highlight(param1:Boolean) : void
      {
         this.highlightMc.visible = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(focusable && editable)
         {
            addEventListener(MouseEvent.MOUSE_UP,this.handleMouseUp,false,0,true);
         }
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
         if(textField != null)
         {
            this.selectionTextColor = this._selectionTextColor;
            this.selectionBgColor = this._selectionBgColor;
            if(textField.hasEventListener(FocusEvent.FOCUS_OUT))
            {
               textField.removeEventListener(FocusEvent.FOCUS_OUT,this.handleTextFieldFocusOut,false);
            }
            textField.addEventListener(FocusEvent.FOCUS_OUT,this.handleTextFieldFocusOut,false,0,true);
            if(textField.hasEventListener(FocusEvent.FOCUS_IN))
            {
               textField.removeEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false);
            }
            textField.addEventListener(FocusEvent.FOCUS_IN,this.handleTextFieldFocusIn,false,0,true);
         }
      }
      
      protected function autoSelectionText() : void
      {
         if(this._focusOutByWaiting)
         {
            textField.setSelection(this._pastSelectionStart,this._pastSelectionEnd);
         }
         else
         {
            textField.setSelection(0,textField.text.length);
         }
         this._focusOutByWaiting = false;
      }
      
      override protected function handleMouseDown(param1:MouseEvent) : void
      {
         super.handleMouseDown(param1);
      }
      
      override protected function handleTextFieldFocusIn(param1:FocusEvent) : void
      {
         super.handleTextFieldFocusIn(param1);
         this.autoSelectionText();
         App.utils.IME.setVisible(true);
      }
      
      [Event(name="change",type="flash.events.Event")]
      override protected function handleTextChange(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         super.handleTextChange(param1);
         this.highlight = false;
         if(this._extractEscapes)
         {
            _loc2_ = textField.text;
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               switch(_loc2_.charAt(_loc4_))
               {
                  case "\n":
                  case "\r":
                     break;
                  default:
                     _loc3_ += _loc2_.charAt(_loc4_);
                     break;
               }
               _loc4_++;
            }
            textField.text = _loc3_;
         }
      }
      
      private function rgbToArgb(param1:uint) : uint
      {
         return 4278190080 | param1;
      }
      
      private function handleMouseUp(param1:MouseEvent) : void
      {
         this._pastSelectionStart = textField.selectionBeginIndex;
         this._pastSelectionEnd = textField.selectionEndIndex;
      }
      
      protected function handleTextFieldFocusOut(param1:FocusEvent) : void
      {
         if(App.instance)
         {
            this._focusOutByWaiting = Boolean(App.waiting) ? Boolean(App.waiting.isOnStage) : Boolean(false);
            if(this._focusOutByWaiting)
            {
               if(this._pastSelectionStart == this._pastSelectionEnd)
               {
                  this._pastSelectionStart = this._pastSelectionEnd = textField.caretIndex;
               }
            }
            App.utils.IME.setVisible(false);
         }
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         if(!this._focusOutByWaiting)
         {
            this._pastSelectionStart = textField.selectionBeginIndex;
            this._pastSelectionEnd = textField.selectionEndIndex;
         }
         switch(param1.details.code)
         {
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
            case Keyboard.UP:
            case Keyboard.DOWN:
               param1.handled = true;
               return;
            default:
               super.handleInput(param1);
               return;
         }
      }
   }
}
