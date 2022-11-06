package scaleform.clik.controls
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.utils.ConstrainedElement;
   import scaleform.clik.utils.Constraints;
   
   [Event(name="change",type="flash.events.Event")]
   public class Label extends UIComponent
   {
       
      
      public var constraintsDisabled:Boolean = false;
      
      protected var _text:String;
      
      protected var _autoSize:String = "none";
      
      protected var isHtml:Boolean;
      
      protected var state:String = "default";
      
      protected var _newFrame:String;
      
      public var textField:TextField;
      
      public function Label()
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
         mouseEnabled = mouseChildren = param1;
         this.setState(this.defaultState);
      }
      
      [Inspectable(name="text")]
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            param1 = "";
         }
         this.isHtml = false;
         this._text = param1;
         invalidateData();
      }
      
      public function get htmlText() : String
      {
         return this._text;
      }
      
      public function set htmlText(param1:String) : void
      {
         if(param1 == null)
         {
            param1 = "";
         }
         this.isHtml = true;
         this._text = param1;
         invalidateData();
      }
      
      [Inspectable(defaultValue="none",enumeration="none,left,right,center")]
      public function get autoSize() : String
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         if(param1 == this._autoSize)
         {
            return;
         }
         this._autoSize = param1;
         invalidateData();
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
         this.isHtml = false;
         invalidateData();
      }
      
      public function appendHtml(param1:String) : void
      {
         this._text += param1;
         this.isHtml = true;
         invalidateData();
      }
      
      override public function toString() : String
      {
         return "[CLIK Label " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!this.constraintsDisabled)
         {
            constraints.addElement("textField",this.textField,Constraints.ALL);
         }
         focusable = false;
      }
      
      protected function calculateWidth() : Number
      {
         var _loc2_:ConstrainedElement = null;
         if(constraints == null || this.textField == null)
         {
            return actualWidth;
         }
         if(!this.constraintsDisabled)
         {
            _loc2_ = constraints.getElement("textField");
         }
         return Number(Math.ceil(this.textField.textWidth + _loc2_.left + _loc2_.right + 5));
      }
      
      protected function alignForAutoSize() : void
      {
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(!initialized || this._autoSize == TextFieldAutoSize.NONE || this.textField == null)
         {
            return;
         }
         _loc1_ = _width;
         var _loc2_:Number = _width = this.calculateWidth();
         switch(this._autoSize)
         {
            case TextFieldAutoSize.RIGHT:
               _loc3_ = x + _loc1_;
               x = _loc3_ - _loc2_;
               break;
            case TextFieldAutoSize.CENTER:
               _loc4_ = x + _loc1_ * 0.5;
               x = _loc4_ - _loc2_ * 0.5;
         }
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
            dispatchEventAndSound(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateText();
            if(this.autoSize != TextFieldAutoSize.NONE)
            {
               this.alignForAutoSize();
               invalidateSize();
            }
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
      
      protected function updateText() : void
      {
         if(this._text != null && this.textField != null)
         {
            if(this.isHtml)
            {
               this.textField.htmlText = this._text;
            }
            else
            {
               this.textField.text = this._text;
            }
         }
      }
      
      protected function updateAfterStateChange() : void
      {
         if(!initialized)
         {
            return;
         }
         if(constraints != null && !this.constraintsDisabled)
         {
            constraints.updateElement("textField",this.textField);
         }
         this.updateText();
         dispatchEventAndSound(new ComponentEvent(ComponentEvent.STATE_CHANGE));
      }
      
      protected function setState(... rest) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(rest.length == 1)
         {
            _loc4_ = rest[0].toString();
            if(this.state != _loc4_ && _labelHash[_loc4_])
            {
               this.state = this._newFrame = _loc4_;
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
               this.state = this._newFrame = _loc5_;
               invalidateState();
               break;
            }
            _loc3_++;
         }
      }
   }
}
