package net.wg.gui.lobby.settings.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.MouseEventEx;
   
   [InspectableList("visible")]
   public class KeyInput extends SoundButton
   {
      
      private static const TO_STRING_MESSAGE:String = "WG KeyInput name: ";
      
      private static const SHOW_DELAY:int = 1500;
      
      private static const INVALID_KEYS:String = "invalidKeys";
       
      
      public var alert:UIComponent;
      
      public var bg:MovieClip;
      
      public var border:MovieClip;
      
      private var _keys:Array;
      
      private var _keyCode:Number;
      
      private var _keyString:String;
      
      private var _keyDefault:Number;
      
      private var _alertMessageAlias:String = "#tooltips:setting_window/controls/key_input/warning";
      
      public function KeyInput()
      {
         super();
      }
      
      override public function toString() : String
      {
         return TO_STRING_MESSAGE + name;
      }
      
      override protected function onDispose() : void
      {
         if(this.alert)
         {
            this.alert.dispose();
            this.alert = null;
         }
         this.bg = null;
         this.border = null;
         if(this._keys)
         {
            this._keys = null;
         }
         if(_repeatTimer)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteHandler);
         }
         this.clearEventListeners();
         removeEventListener(Event.SELECT,this.onSelectHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         stage.doubleClickEnabled = true;
         toggle = true;
         addEventListener(Event.SELECT,this.onSelectHandler);
         buttonMode = enabled;
         mouseEnabled = true;
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            textField.text = this._keyString || Values.EMPTY_STR;
            this.alert.visible = this._keyCode == KeyProps.KEY_NONE && !selected;
         }
         if(this._keys && isInvalid(INVALID_KEYS))
         {
            this.keysToUpperCase();
         }
         super.draw();
      }
      
      public function setupKey(param1:Array, param2:Number) : void
      {
         this._keys = param1;
         this.keysToUpperCase();
         this._keyString = App.utils.commons.keyToString(param2).keyName;
         var _loc3_:KeyProps = App.utils.commons.keyToString(param2);
         if(this.isInKeySet(_loc3_.keyCommand))
         {
            this.key = param2;
         }
         else
         {
            this.key = KeyProps.KEY_NONE;
         }
      }
      
      private function keysToUpperCase() : void
      {
         var _loc1_:int = this._keys.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            this._keys[_loc2_] = App.utils.toUpperOrLowerCase(String(this._keys[_loc2_]),true);
            _loc2_++;
         }
      }
      
      private function addEventListeners() : void
      {
         addEventListener(ButtonEvent.PRESS,this.onPressHandler);
         addEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onReleaseOutsideHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler,false,0,true);
      }
      
      private function clearEventListeners() : void
      {
         removeEventListener(ButtonEvent.PRESS,this.onPressHandler);
         removeEventListener(ButtonEvent.RELEASE_OUTSIDE,this.onReleaseOutsideHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
      }
      
      private function processCode(param1:Number) : void
      {
         var _loc3_:Point = null;
         var _loc4_:ITooltipProps = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(param1 == Keyboard.ESCAPE)
         {
            this.inputClose();
            return;
         }
         var _loc2_:KeyProps = App.utils.commons.keyToString(param1);
         if(this.isInKeySet(_loc2_.keyCommand))
         {
            this.key = param1;
            dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE,this.key));
            this.inputClose();
         }
         else
         {
            _loc3_ = parent.localToGlobal(new Point(x + width,y - height - 7));
            _loc4_ = new TooltipProps(BaseTooltips.TYPE_WARNING,_loc3_.x,_loc3_.y,0,0,SHOW_DELAY);
            _loc5_ = App.utils.locale.makeString(this._alertMessageAlias,{"keyName":_loc2_.keyName});
            _loc6_ = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.ALERT_TEXT,_loc5_);
            App.toolTipMgr.show(_loc6_,_loc4_);
            this.inputClose();
         }
      }
      
      private function isInKeySet(param1:String) : Boolean
      {
         return this._keys.indexOf(param1,0) > -1;
      }
      
      private function inputClose() : void
      {
         selected = false;
         invalidate();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == enabled)
         {
            return;
         }
         buttonMode = param1;
         super.enabled = param1;
      }
      
      public function get keyCode() : Number
      {
         return this._keyCode;
      }
      
      public function set keyDefault(param1:Number) : void
      {
         this._keyDefault = param1;
      }
      
      public function get key() : Number
      {
         return this._keyCode;
      }
      
      public function set key(param1:Number) : void
      {
         if(this._keyCode == param1)
         {
            return;
         }
         if(param1 == KeyProps.KEY_NONE)
         {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE,KeyProps.KEY_NONE));
         }
         this._keyCode = param1;
         this._keyString = App.utils.commons.keyToString(this._keyCode).keyName;
         invalidateData();
      }
      
      public function get keys() : Array
      {
         return this._keys;
      }
      
      [ArrayElementType("String")]
      [Inspectable(name="keys",type="Array")]
      public function set keys(param1:Array) : void
      {
         this._keys = param1;
         invalidate(INVALID_KEYS);
      }
      
      public function get alertMessageAlias() : String
      {
         return this._alertMessageAlias;
      }
      
      public function set alertMessageAlias(param1:String) : void
      {
         this._alertMessageAlias = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = null;
         if(selected)
         {
            if(param1.isDefaultPrevented())
            {
               return;
            }
            _loc2_ = param1.details;
            if(_loc2_.value == InputValue.KEY_DOWN && selected)
            {
               this.processCode(_loc2_.code);
            }
         }
         else
         {
            super.handleInput(param1);
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         var _loc5_:ButtonEvent = null;
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         _mouseDown |= 1 << _loc3_;
         if(enabled)
         {
            setState(ComponentState.DOWN);
            if(autoRepeat && _repeatTimer == null)
            {
               _autoRepeatEvent = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,true);
               _repeatTimer = new Timer(repeatDelay,1);
               _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteHandler,false,0,true);
               _repeatTimer.start();
            }
            _loc5_ = new ButtonEvent(ButtonEvent.PRESS,true,false,_loc3_,_loc4_,false,false);
            dispatchEvent(_loc5_);
            callLogEvent(param1);
         }
         else
         {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.DISABLE_PRESS,NaN,true,false));
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.DISABLE_OVER,NaN,true,false));
         }
         super.handleMouseRollOver(param1);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         if(!enabled)
         {
            dispatchEvent(new KeyInputEvents(KeyInputEvents.DISABLE_OUT,NaN,true,false));
         }
         super.handleMouseRollOut(param1);
      }
      
      private function onTimerCompleteHandler(param1:TimerEvent) : void
      {
         beginRepeat(param1);
      }
      
      private function onStageMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _autoRepeatEvent = null;
         if(contains(DisplayObject(param1.target)))
         {
            return;
         }
         var _loc4_:MouseEventEx = param1 as MouseEventEx;
         if(_loc4_ != null)
         {
            _loc2_ = _loc4_.mouseIdx;
            _loc3_ = _loc4_.buttonIdx;
         }
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler,false);
         _mouseDown ^= 1 << _loc2_;
         dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE,true,false,_loc2_,_loc3_,false,false));
         if(!enabled)
         {
            return;
         }
         if(lockDragStateChange)
         {
            if(_focused || _displayFocus)
            {
               setState(focusIndicator == null ? ComponentState.RELEASE : ComponentState.KB_RELEASE);
            }
            else
            {
               setState(ComponentState.KB_RELEASE);
            }
         }
         callLogEvent(param1);
      }
      
      private function onSelectHandler(param1:Event) : void
      {
         if(this.selected)
         {
            this.addEventListeners();
         }
         else
         {
            this.clearEventListeners();
         }
      }
      
      private function onPressHandler(param1:ButtonEvent) : void
      {
         this.processCode(!!param1.isKeyboard ? Number(param1.controllerIdx) : Number(param1.buttonIdx));
      }
      
      private function onReleaseOutsideHandler(param1:ButtonEvent) : void
      {
         this.processCode(!!param1.isKeyboard ? Number(param1.controllerIdx) : Number(param1.buttonIdx));
      }
   }
}
