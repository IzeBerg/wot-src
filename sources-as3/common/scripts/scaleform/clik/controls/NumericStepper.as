package scaleform.clik.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.Constraints;
   import scaleform.gfx.TextFieldEx;
   
   public class NumericStepper extends UIComponent
   {
       
      
      [Inspectable(defaultValue="1")]
      public var stepSize:Number = 1;
      
      public var constraintsDisabled:Boolean = false;
      
      protected var _maximum:Number = 10;
      
      protected var _minimum:Number = 0;
      
      protected var _value:Number = 0;
      
      protected var _labelFunction:Function;
      
      protected var state:String = "default";
      
      protected var _newFrame:String;
      
      private var _oldState:String = "";
      
      public var textField:TextField;
      
      public var nextBtn:Button;
      
      public var prevBtn:Button;
      
      public var container:MovieClip;
      
      public function NumericStepper()
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
         TextFieldEx.setNoTranslate(this.textField,true);
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
         mouseEnabled = tabEnabled = param1;
         this.setState(!!param1 ? (_focused > 0 ? "focused" : "default") : "disabled");
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
      
      [Inspectable(defaultValue="10")]
      public function get maximum() : Number
      {
         return this._maximum;
      }
      
      public function set maximum(param1:Number) : void
      {
         this._maximum = param1;
         param1 = this._value;
      }
      
      [Inspectable(defaultValue="0")]
      public function get minimum() : Number
      {
         return this._minimum;
      }
      
      public function set minimum(param1:Number) : void
      {
         this._minimum = param1;
         param1 = this._value;
      }
      
      [Inspectable(defaultValue="0",name="value")]
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         param1 = this.lockValue(param1);
         if(param1 == this._value)
         {
            return;
         }
         var _loc2_:Number = this._value;
         this._value = param1;
         if(initialized)
         {
            dispatchEventAndSound(new IndexEvent(IndexEvent.INDEX_CHANGE,true,false,this.value,_loc2_,null));
         }
         invalidate();
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
      
      public function increment() : void
      {
         this.onNext(null);
      }
      
      public function decrement() : void
      {
         this.onPrev(null);
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
               if(this._value < this._maximum)
               {
                  if(_loc4_)
                  {
                     this.onNext(null);
                  }
                  param1.handled = true;
               }
               break;
            case NavigationCode.LEFT:
               if(this._value > this._minimum)
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
                  this.value = this._minimum;
               }
               param1.handled = true;
               break;
            case NavigationCode.END:
               if(!_loc4_)
               {
                  this.value = this._maximum;
               }
               param1.handled = true;
         }
      }
      
      override public function toString() : String
      {
         return "[CLIK NumericStepper " + name + "]";
      }
      
      override protected function configUI() : void
      {
         if(!this.constraintsDisabled)
         {
            constraints.addElement("textField",this.textField,Constraints.LEFT | Constraints.RIGHT);
         }
         addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
         this.nextBtn.addEventListener(ButtonEvent.CLICK,this.onNext,false,0,true);
         this.prevBtn.addEventListener(ButtonEvent.CLICK,this.onPrev,false,0,true);
         tabEnabled = _focusable;
         tabChildren = false;
         if(this.textField != null)
         {
            this.textField.tabEnabled = this.textField.mouseEnabled = false;
         }
         if(this.container != null)
         {
            this.container.tabEnabled = this.container.mouseEnabled = false;
         }
         this.prevBtn.enabled = this.nextBtn.enabled = this.enabled;
         this.prevBtn.autoRepeat = this.nextBtn.autoRepeat = true;
         this.prevBtn.focusable = this.nextBtn.focusable = false;
         this.prevBtn.focusTarget = this.nextBtn.focusTarget = this;
         this.prevBtn.tabEnabled = this.nextBtn.tabEnabled = false;
         this.prevBtn.mouseEnabled = this.nextBtn.mouseEnabled = true;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.STATE))
         {
            if(this._newFrame && this._newFrame != this._oldState)
            {
               gotoAndPlay(this._newFrame);
               this._oldState = this._newFrame;
               this._newFrame = null;
               this.updateAfterStateChange();
               dispatchEventAndSound(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateLabel();
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
      
      protected function handleDataChange(param1:Event) : void
      {
         invalidate(InvalidationType.DATA);
      }
      
      protected function updateAfterStateChange() : void
      {
         invalidateSize();
         this.updateLabel();
         if(this.textField != null)
         {
            this.textField.tabEnabled = this.textField.mouseEnabled = false;
         }
         if(this.container != null)
         {
            this.container.tabEnabled = this.container.mouseEnabled = false;
         }
         if(constraints != null && !this.constraintsDisabled)
         {
            constraints.updateElement("textField",this.textField);
         }
      }
      
      protected function updateLabel() : void
      {
         var _loc1_:String = this._value.toString();
         if(this._labelFunction != null)
         {
            _loc1_ = this._labelFunction(this._value);
         }
         this.textField.text = _loc1_;
      }
      
      protected function onNext(param1:ButtonEvent) : void
      {
         this.value = this._value + this.stepSize;
      }
      
      protected function onPrev(param1:ButtonEvent) : void
      {
         this.value = this._value - this.stepSize;
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
      
      protected function lockValue(param1:Number) : Number
      {
         return Number(Math.max(this._minimum,Math.min(this._maximum,this.stepSize * Math.round(param1 / this.stepSize))));
      }
   }
}
