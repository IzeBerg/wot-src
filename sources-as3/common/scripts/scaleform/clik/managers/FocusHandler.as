package scaleform.clik.managers
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import scaleform.clik.constants.FocusMode;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.NavigationCode;
   import scaleform.clik.core.CLIK;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.FocusHandlerEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.utils.WeakReference;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.FocusEventEx;
   import scaleform.gfx.FocusManager;
   
   [Event(name="input",type="gfx.events.InputEvent")]
   public class FocusHandler
   {
      
      protected static var initialized:Boolean = false;
      
      public static var instance:FocusHandler;
       
      
      protected var _stage:Stage;
      
      protected var currentFocusLookup:Dictionary;
      
      protected var actualFocusLookup:Dictionary;
      
      protected var preventStageFocusChanges:Boolean = false;
      
      protected var mouseDown:Boolean = false;
      
      public function FocusHandler()
      {
         super();
         this.currentFocusLookup = new Dictionary();
         this.actualFocusLookup = new Dictionary();
      }
      
      public static function getInstance() : FocusHandler
      {
         if(instance == null)
         {
            instance = new FocusHandler();
         }
         return instance;
      }
      
      public static function init(param1:Stage, param2:UIComponent) : void
      {
         if(initialized)
         {
            return;
         }
         var _loc3_:FocusHandler = FocusHandler.getInstance();
         _loc3_.stage = param1;
         FocusManager.alwaysEnableArrowKeys = true;
         FocusManager.disableFocusKeys = true;
         initialized = true;
      }
      
      public function set stage(param1:Stage) : void
      {
         if(this._stage == null)
         {
            this._stage = param1;
         }
         this._stage.stageFocusRect = false;
         if(Extensions.enabled)
         {
            this._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.trackMouseDown,false,0,true);
            this._stage.addEventListener(MouseEvent.MOUSE_UP,this.trackMouseDown,false,0,true);
         }
         this._stage.addEventListener(FocusEvent.FOCUS_IN,this.updateActualFocus,false,0,true);
         this._stage.addEventListener(FocusEvent.FOCUS_OUT,this.updateActualFocus,false,0,true);
         this._stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE,this.handleMouseFocusChange,false,0,true);
         this._stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.handleMouseFocusChange,false,0,true);
         var _loc2_:InputDelegate = InputDelegate.getInstance();
         _loc2_.initialize(this._stage);
         _loc2_.addEventListener(InputEvent.INPUT,this.handleInput,false,0,true);
      }
      
      public function getFocus(param1:uint) : InteractiveObject
      {
         return this.getCurrentFocusDisplayObject(param1);
      }
      
      public function setFocus(param1:InteractiveObject, param2:uint = 0, param3:Boolean = false) : void
      {
         var _loc5_:UIComponent = null;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:Boolean = false;
         var _loc4_:InteractiveObject = param1;
         if(param1 != null)
         {
            while(true)
            {
               _loc5_ = param1 as UIComponent;
               if(_loc5_ == null)
               {
                  break;
               }
               if(_loc5_.focusTarget == null)
               {
                  break;
               }
               param1 = _loc5_.focusTarget;
            }
         }
         if(_loc5_ != null)
         {
            if(_loc5_.focusable == false)
            {
               param1 = null;
            }
         }
         var _loc6_:Sprite = param1 as Sprite;
         if(_loc6_ && param3 && _loc6_.tabEnabled == false)
         {
            param1 = null;
         }
         if(CLIK.disableNullFocusMoves && (param1 == null || param1 == this._stage))
         {
            return;
         }
         var _loc7_:DisplayObject = this.getActualFocusDisplayObject(param2);
         var _loc8_:DisplayObject = this.getCurrentFocusDisplayObject(param2);
         if(_loc8_ != param1)
         {
            _loc5_ = _loc8_ as UIComponent;
            if(_loc5_ != null)
            {
               _loc5_.focused &= ~(1 << param2);
            }
            if(_loc8_ != null)
            {
               if(_loc8_ is UIComponent)
               {
                  (_loc8_ as UIComponent).dispatchEventAndSound(new FocusHandlerEvent(FocusHandlerEvent.FOCUS_OUT,true,false,param2));
               }
               else
               {
                  _loc8_.dispatchEvent(new FocusHandlerEvent(FocusHandlerEvent.FOCUS_OUT,true,false,param2));
               }
            }
            _loc8_ = param1;
            this.setCurrentFocusDisplayObject(param2,param1);
            _loc5_ = _loc8_ as UIComponent;
            if(_loc5_ != null)
            {
               _loc5_.focused |= 1 << param2;
            }
            if(_loc8_ != null)
            {
               if(_loc8_ is UIComponent)
               {
                  (_loc8_ as UIComponent).dispatchEventAndSound(new FocusHandlerEvent(FocusHandlerEvent.FOCUS_IN,true,false,param2));
               }
               else
               {
                  _loc8_.dispatchEvent(new FocusHandlerEvent(FocusHandlerEvent.FOCUS_IN,true,false,param2));
               }
            }
         }
         var _loc9_:Boolean = _loc7_ is TextField;
         var _loc10_:Boolean = _loc8_ is UIComponent;
         if(_loc7_ != _loc8_ && (!_loc9_ || _loc9_ && !_loc10_))
         {
            if(_loc4_ is TextField && _loc4_ != param1 && param1 == null)
            {
               param1 = _loc4_;
            }
            this.preventStageFocusChanges = true;
            if(Extensions.isScaleform)
            {
               _loc11_ = FocusManager.getControllerMaskByFocusGroup(param2);
               _loc12_ = Extensions.numControllers;
               _loc13_ = 0;
               while(_loc13_ < _loc12_)
               {
                  _loc14_ = (_loc11_ >> _loc13_ & 1) != 0;
                  if(_loc14_)
                  {
                     this.setSystemFocus(param1 as InteractiveObject,_loc13_);
                  }
                  _loc13_++;
               }
            }
            else
            {
               this.setSystemFocus(param1 as InteractiveObject);
            }
            this._stage.addEventListener(Event.ENTER_FRAME,this.clearFocusPrevention,false,0,true);
         }
      }
      
      protected function getCurrentFocusDisplayObject(param1:uint) : InteractiveObject
      {
         var _loc2_:WeakReference = this.currentFocusLookup[param1] as WeakReference;
         if(_loc2_)
         {
            return _loc2_.value as InteractiveObject;
         }
         return null;
      }
      
      protected function setCurrentFocusDisplayObject(param1:uint, param2:InteractiveObject) : void
      {
         this.currentFocusLookup[param1] = new WeakReference(param2);
      }
      
      protected function getActualFocusDisplayObject(param1:uint) : InteractiveObject
      {
         var _loc2_:WeakReference = this.actualFocusLookup[param1] as WeakReference;
         if(_loc2_)
         {
            return _loc2_.value as InteractiveObject;
         }
         return null;
      }
      
      protected function setActualFocusDisplayObject(param1:uint, param2:InteractiveObject) : void
      {
         this.actualFocusLookup[param1] = new WeakReference(param2);
      }
      
      protected function setSystemFocus(param1:InteractiveObject, param2:uint = 0) : void
      {
         if(Extensions.isScaleform)
         {
            FocusManager.setFocus(param1,param2);
         }
         else
         {
            this._stage.focus = param1;
         }
      }
      
      protected function getSystemFocus(param1:uint = 0) : InteractiveObject
      {
         if(Extensions.isScaleform)
         {
            return FocusManager.getFocus(param1);
         }
         return this._stage.focus;
      }
      
      protected function clearFocusPrevention(param1:Event) : void
      {
         this.preventStageFocusChanges = false;
         this._stage.removeEventListener(Event.ENTER_FRAME,this.clearFocusPrevention,false);
      }
      
      public function input(param1:InputDetails) : void
      {
         var _loc2_:InputEvent = new InputEvent(InputEvent.INPUT,param1);
         this.handleInput(_loc2_);
      }
      
      public function trackMouseDown(param1:MouseEvent) : void
      {
         this.mouseDown = param1.buttonDown;
      }
      
      protected function handleInput(param1:InputEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc16_:InputDelegate = null;
         var _loc17_:String = null;
         var _loc2_:Number = param1.details.controllerIndex;
         var _loc3_:Number = FocusManager.getControllerFocusGroup(_loc2_);
         var _loc4_:InteractiveObject = this.getCurrentFocusDisplayObject(_loc3_);
         if(_loc4_ == null)
         {
            _loc4_ = this._stage;
         }
         var _loc5_:InputEvent = param1.clone() as InputEvent;
         if(_loc4_ is UIComponent)
         {
            _loc6_ = (_loc4_ as UIComponent).dispatchEventAndSound(_loc5_);
         }
         else
         {
            _loc6_ = _loc4_.dispatchEvent(_loc5_);
         }
         if(!_loc6_ || _loc5_.handled)
         {
            _loc16_ = InputDelegate.getInstance();
            _loc16_.stopPropagationEvent();
            return;
         }
         if(param1.details.value == InputValue.KEY_UP)
         {
            return;
         }
         var _loc7_:String = param1.details.navEquivalent;
         if(_loc7_ == null)
         {
            return;
         }
         var _loc8_:InteractiveObject = this.getCurrentFocusDisplayObject(_loc3_);
         var _loc9_:InteractiveObject = this.getActualFocusDisplayObject(_loc3_);
         var _loc10_:InteractiveObject = this.getSystemFocus(_loc3_);
         if(_loc9_ is TextField && _loc9_ == _loc8_ && this.handleTextFieldInput(_loc7_,_loc2_))
         {
            return;
         }
         if(_loc9_ is TextField && this.handleTextFieldInput(_loc7_,_loc2_))
         {
            return;
         }
         var _loc11_:Boolean = _loc7_ == NavigationCode.LEFT || _loc7_ == NavigationCode.RIGHT;
         var _loc12_:Boolean = _loc7_ == NavigationCode.UP || NavigationCode.DOWN;
         if(_loc8_ == null)
         {
            if(_loc10_ && _loc10_ is UIComponent)
            {
               _loc8_ = _loc10_ as UIComponent;
            }
         }
         if(_loc8_ == null)
         {
            if(_loc9_ && _loc9_ is UIComponent)
            {
               _loc8_ = _loc9_ as UIComponent;
            }
         }
         if(_loc8_ == null)
         {
            return;
         }
         var _loc13_:DisplayObjectContainer = _loc8_.parent;
         var _loc14_:String = FocusMode.DEFAULT;
         if(_loc11_ || _loc12_)
         {
            _loc17_ = !!_loc11_ ? FocusMode.HORIZONTAL : FocusMode.VERTICAL;
            while(_loc13_ != null)
            {
               if(!(_loc17_ in _loc13_))
               {
                  break;
               }
               _loc14_ = _loc13_[_loc17_];
               if(_loc14_ != null && _loc14_ != FocusMode.DEFAULT)
               {
                  break;
               }
               _loc13_ = _loc13_.parent;
            }
         }
         else
         {
            _loc13_ = null;
         }
         if(_loc9_ is TextField && _loc9_.parent == _loc8_)
         {
            _loc8_ = this.getSystemFocus(_loc2_);
         }
         var _loc15_:InteractiveObject = FocusManager.findFocus(_loc7_,null,_loc14_ == FocusMode.LOOP,_loc8_,false,_loc2_);
         if(_loc15_ != null)
         {
            this.setFocus(_loc15_,_loc3_);
         }
      }
      
      protected function handleMouseFocusChange(param1:FocusEvent) : void
      {
         this.handleFocusChange(param1.target as InteractiveObject,param1.relatedObject as InteractiveObject,param1);
      }
      
      protected function handleFocusChange(param1:InteractiveObject, param2:InteractiveObject, param3:FocusEvent) : void
      {
         var _loc7_:TextField = null;
         if(this.mouseDown && param2 is TextField)
         {
            param3.preventDefault();
            return;
         }
         if(CLIK.disableDynamicTextFieldFocus && param2 is TextField)
         {
            _loc7_ = param2 as TextField;
            if(_loc7_.type == "dynamic")
            {
               param3.stopImmediatePropagation();
               param3.stopPropagation();
               param3.preventDefault();
               return;
            }
         }
         if(param2 is UIComponent)
         {
            param3.preventDefault();
         }
         if(param1 is TextField && param2 == null && CLIK.disableTextFieldToNullFocusMoves)
         {
            param3.preventDefault();
            return;
         }
         var _loc4_:FocusEventEx = param3 as FocusEventEx;
         var _loc5_:uint = _loc4_ == null ? uint(0) : uint(_loc4_.controllerIdx);
         var _loc6_:uint = FocusManager.getControllerFocusGroup(_loc5_);
         this.setActualFocusDisplayObject(_loc6_,param2);
         this.setFocus(param2,_loc6_,param3.type == FocusEvent.MOUSE_FOCUS_CHANGE);
      }
      
      protected function updateActualFocus(param1:FocusEvent) : void
      {
         var _loc2_:InteractiveObject = null;
         var _loc3_:InteractiveObject = null;
         if(param1.type == FocusEvent.FOCUS_IN)
         {
            _loc2_ = param1.relatedObject as InteractiveObject;
            _loc3_ = param1.target as InteractiveObject;
         }
         else
         {
            _loc2_ = param1.target as InteractiveObject;
            _loc3_ = param1.relatedObject as InteractiveObject;
         }
         if(param1.type == FocusEvent.FOCUS_OUT)
         {
            if(this.preventStageFocusChanges)
            {
               param1.stopImmediatePropagation();
               param1.stopPropagation();
            }
         }
         var _loc4_:FocusEventEx = param1 as FocusEventEx;
         var _loc5_:uint = _loc4_ == null ? uint(0) : uint(_loc4_.controllerIdx);
         var _loc6_:uint = FocusManager.getControllerFocusGroup(_loc5_);
         this.setActualFocusDisplayObject(_loc6_,_loc3_);
         var _loc7_:InteractiveObject = this.getCurrentFocusDisplayObject(_loc6_);
         if(_loc3_ != null && _loc3_ is TextField && _loc3_.parent != null && _loc7_ == _loc3_.parent && _loc7_ == _loc2_)
         {
            return;
         }
         var _loc8_:Boolean = _loc3_ is TextField;
         var _loc9_:Boolean = _loc7_ is UIComponent;
         if(_loc3_ != _loc7_)
         {
            if(!(_loc8_ && _loc9_) || _loc3_ == null)
            {
               if(!this.preventStageFocusChanges || _loc8_)
               {
                  this.setFocus(_loc3_,_loc6_);
               }
            }
         }
      }
      
      protected function handleTextFieldInput(param1:String, param2:uint) : Boolean
      {
         var _loc3_:TextField = this.getActualFocusDisplayObject(param2) as TextField;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc4_:int = _loc3_.caretIndex;
         var _loc5_:Number = 0;
         switch(param1)
         {
            case NavigationCode.UP:
               if(!_loc3_.multiline)
               {
                  return false;
               }
               break;
            case NavigationCode.LEFT:
               break;
            case NavigationCode.DOWN:
               if(!_loc3_.multiline)
               {
                  return false;
               }
            case NavigationCode.RIGHT:
               return _loc4_ < _loc3_.length;
            default:
               return false;
         }
         return _loc4_ > 0;
      }
   }
}
