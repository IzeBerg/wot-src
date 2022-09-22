package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextFieldType;
   import net.wg.data.constants.Errors;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.controls.TextArea;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.utils.Padding;
   import scaleform.gfx.TextFieldEx;
   
   public class TextAreaSimple extends scaleform.clik.controls.TextArea
   {
      
      private static const PADDING_FOR_BG:Number = 7;
      
      private static const TEXTFIELD_PADDING:Number = 5;
      
      private static const BGFORM_MARGIN:Number = 3;
      
      private static const SHOW_BGFORM_SCROLLBAR_X_SHIFT:Number = -2;
      
      private static const HIDE_BGFORM_SCROLLBAR_X_SHIFT:Number = -1;
      
      private static const HIDE_BGFORM_SCROLLBAR_HEIGHT_SHIFT:Number = -2;
      
      private static const HIDE_BGFORM_SCROLLBAR_Y_START:Number = 1;
      
      private static const DEFAULT_ALPHA_RGB:uint = 4278190080;
      
      private static const DEFAULT_POSITION:uint = 1;
      
      private static const INACTIVE_SELECTION_BKG_COLOR:uint = 0;
      
      private static const STATE_DEFAULT:String = "default";
       
      
      public var bgForm:Sprite;
      
      private var _safePosition:Boolean = false;
      
      private var _autoScroll:Boolean = false;
      
      private var _showBgForm:Boolean = false;
      
      private var _selectable:Boolean = false;
      
      private var _textPadding:Padding;
      
      private var _selectionTextColor:uint = 1973787;
      
      private var _selectionBgColor:uint = 9868935;
      
      public function TextAreaSimple()
      {
         this._textPadding = new Padding(0,0,0,0);
         super();
      }
      
      override protected function onDispose() : void
      {
         this._textPadding = null;
         this.bgForm = null;
         textField.removeEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false);
         textField.removeEventListener(FocusEvent.FOCUS_IN,this.onTextFieldFocusInHandler);
         textField.removeEventListener(FocusEvent.FOCUS_OUT,this.onTextFieldFocusOutHandler);
         textField.removeEventListener(Event.CHANGE,handleTextChange);
         removeEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false);
         removeEventListener(InputEvent.INPUT,this.handleInput,false);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         if(this._showBgForm)
         {
            textField.x = PADDING_FOR_BG;
            textField.y = PADDING_FOR_BG;
            textField.width -= PADDING_FOR_BG * 2;
            textField.height -= PADDING_FOR_BG * 2;
         }
         else
         {
            textField.x = this._textPadding.left;
            textField.y = this._textPadding.top;
            textField.width -= this._textPadding.left + this._textPadding.right;
            textField.height -= this._textPadding.top + this._textPadding.bottom;
         }
         if(!constraintsDisabled)
         {
            constraints.addElement(textField.name,textField,Constraints.ALL);
         }
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         textField.addEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false,0,true);
         if(this.focusable && this._selectable)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false,0,true);
         }
         setState(defaultState,STATE_DEFAULT);
         textField.selectable = !!enabled ? this.editable || this._selectable : Boolean(false);
         this.bgForm.visible = this.showBgForm;
      }
      
      override protected function updateTextField() : void
      {
         _resetScrollPosition = true;
         App.utils.asserter.assertNotNull(textField,textField.name + Errors.CANT_NULL);
         this.updateText();
         textField.maxChars = _maxChars;
         textField.alwaysShowSelection = _alwaysShowSelection;
         textField.selectable = !!enabled ? Boolean(this._selectable) : Boolean(enabled);
         textField.type = _editable && enabled ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
         textField.tabEnabled = this._selectable && enabled && _focusable;
         textField.addEventListener(Event.CHANGE,handleTextChange,false,0,true);
         if(textField.hasEventListener(FocusEvent.FOCUS_IN))
         {
            textField.removeEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false);
         }
         textField.addEventListener(FocusEvent.FOCUS_IN,handleTextFieldFocusIn,false,0,true);
         if(!textField.hasEventListener(FocusEvent.FOCUS_IN))
         {
            textField.addEventListener(FocusEvent.FOCUS_IN,this.onTextFieldFocusInHandler);
         }
         if(!textField.hasEventListener(FocusEvent.FOCUS_OUT))
         {
            textField.addEventListener(FocusEvent.FOCUS_OUT,this.onTextFieldFocusOutHandler);
         }
         textField.selectable = !!enabled ? this.editable || this._selectable : Boolean(enabled);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.selectionTextColor = this._selectionTextColor;
            this.selectionBgColor = this._selectionBgColor;
         }
         this.updateText();
      }
      
      override protected function drawScrollBar() : void
      {
         if(_autoScrollBar)
         {
            if(this._showBgForm)
            {
               _scrollBar.y = BGFORM_MARGIN;
               _scrollBar.x = width - _scrollBar.width + SHOW_BGFORM_SCROLLBAR_X_SHIFT;
               _scrollBar.height = height - BGFORM_MARGIN * 2;
            }
            else
            {
               _scrollBar.y = HIDE_BGFORM_SCROLLBAR_Y_START;
               _scrollBar.x = width - _scrollBar.width + HIDE_BGFORM_SCROLLBAR_X_SHIFT;
               _scrollBar.height = height + HIDE_BGFORM_SCROLLBAR_HEIGHT_SHIFT;
            }
         }
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         if(this.autoScroll)
         {
            position = !!this._safePosition ? int(textField.scrollV) : int(textField.maxScrollV);
         }
         if(_scrollBar)
         {
            constraints.update(availableWidth,_height);
         }
      }
      
      public function appendHtmlResetPosition(param1:String) : void
      {
         this.safePosition = false;
         appendHtml(param1);
      }
      
      private function rgbToArgb(param1:uint) : uint
      {
         return DEFAULT_ALPHA_RGB + param1;
      }
      
      override public function get focusable() : Boolean
      {
         return _focusable;
      }
      
      override public function set focusable(param1:Boolean) : void
      {
         _focusable = param1;
         if(!_focusable && enabled)
         {
            tabChildren = false;
         }
         changeFocus();
         if(_focusable && this.selectable)
         {
            addEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false,0,true);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_DOWN,handleMouseDown,false);
         }
      }
      
      [Inspectable(defaultValue="true")]
      override public function get editable() : Boolean
      {
         return _editable;
      }
      
      override public function set editable(param1:Boolean) : void
      {
         _editable = param1;
         textField.type = _editable && enabled ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
         this.focusable = !!_editable ? Boolean(_editable) : Boolean(this.selectable);
      }
      
      [Inspectable(defaultValue="false")]
      public function get showBgForm() : Boolean
      {
         return this._showBgForm;
      }
      
      public function set showBgForm(param1:Boolean) : void
      {
         this._showBgForm = param1;
      }
      
      [Inspectable(defaultValue="top:0,right:0,bottom:0,left:0",name="textPadding")]
      public function get textPadding() : Object
      {
         return this._textPadding;
      }
      
      public function set textPadding(param1:Object) : void
      {
         this._textPadding = new Padding(param1.top,param1.right,param1.bottom,param1.left);
      }
      
      [Inspectable(defaultValue="false")]
      public function get autoScroll() : Boolean
      {
         return this._autoScroll;
      }
      
      public function set autoScroll(param1:Boolean) : void
      {
         this._autoScroll = param1;
      }
      
      [Inspectable(defaultValue="false")]
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
         this.focusable = !!_editable ? Boolean(_editable) : Boolean(this._selectable);
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
         TextFieldEx.setInactiveSelectionBkgColor(textField,INACTIVE_SELECTION_BKG_COLOR);
      }
      
      public function get safePosition() : Boolean
      {
         return this._safePosition;
      }
      
      public function set safePosition(param1:Boolean) : void
      {
         this._safePosition = param1;
      }
      
      public function get textHeight() : Number
      {
         return textField.textHeight + TEXTFIELD_PADDING;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value == InputValue.KEY_DOWN || _loc2_.value == InputValue.KEY_HOLD)
         {
            return;
         }
         var _loc3_:String = param1.details.navEquivalent;
         switch(_loc3_)
         {
            case NavigationCode.UP:
               if(position == DEFAULT_POSITION)
               {
                  return;
               }
               position = Math.max(DEFAULT_POSITION,position - 1);
               param1.handled = true;
               break;
            case NavigationCode.DOWN:
               if(position == _maxScroll)
               {
                  return;
               }
               position = Math.min(_maxScroll,position + 1);
               param1.handled = true;
               break;
            case NavigationCode.END:
               position = _maxScroll;
               param1.handled = true;
               break;
            case NavigationCode.HOME:
               position = DEFAULT_POSITION;
               param1.handled = true;
               break;
            case NavigationCode.PAGE_UP:
               _loc4_ = textField.bottomScrollV - textField.scrollV;
               position = Math.max(DEFAULT_POSITION,position - _loc4_);
               param1.handled = true;
               break;
            case NavigationCode.PAGE_DOWN:
               _loc5_ = textField.bottomScrollV - textField.scrollV;
               position = Math.min(_maxScroll,position + _loc5_);
               param1.handled = true;
         }
      }
      
      override protected function handleScroll(param1:Event) : void
      {
         super.handleScroll(param1);
         this._safePosition = _scrollBar.position < textField.maxScrollV;
      }
      
      private function onTextFieldFocusInHandler(param1:FocusEvent) : void
      {
         App.utils.IME.setVisible(true);
      }
      
      private function onTextFieldFocusOutHandler(param1:FocusEvent) : void
      {
         App.utils.IME.setVisible(false);
      }
   }
}
