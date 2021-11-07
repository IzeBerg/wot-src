package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.wg.data.constants.ComponentState;
   import net.wg.gui.interfaces.ISoundButton;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class SoundButton extends Button implements ISoundButton
   {
      
      private static const INPUT_LOCK_DURATION:Number = 20;
      
      private static const SHOW_LABEL:String = "show";
      
      private static const HIDE_LABEL:String = "hide";
      
      private static const STATE_PREFIX_LABEL:String = "state";
      
      public static const ENABLED_ALPHA:Number = 1;
      
      public static const DISABLED_ALPHA:Number = 0.6;
       
      
      public var hitMc:MovieClip;
      
      public var isUseRightBtn:Boolean = false;
      
      protected var mouseHandlingLocked:Boolean = false;
      
      protected var keyboardHandlingLocked:Boolean = false;
      
      protected var useFocusedAsSelect:Boolean = false;
      
      private var _soundType:String = "normal";
      
      private var _soundId:String = "";
      
      private var _mouseEnabledOnDisabled:Boolean = false;
      
      private var _soundEnabled:Boolean = true;
      
      private var _mutedSoundTypes:Array;
      
      public function SoundButton()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG SoundButton " + name + "]";
      }
      
      override protected function onBeforeDispose() : void
      {
         if(_repeatTimer != null)
         {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.stop();
         }
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         App.utils.scheduler.cancelTask(this.unlockKeyboardHandling);
         App.utils.scheduler.cancelTask(this.unlockMouseHandling);
         App.utils.scheduler.cancelTask(this.updateMouseEnabled);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.hitMc = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.hitMc != null)
         {
            this.hitArea = this.hitMc;
         }
         buttonMode = this.enabled;
         this.updateMouseEnabled();
         if(App.soundMgr != null && this._soundEnabled)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
         if(textField != null)
         {
            textField.mouseEnabled = false;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function handleRelease(param1:uint = 0) : void
      {
         var _loc2_:ButtonEvent = null;
         if(!this.enabled)
         {
            return;
         }
         setState(focusIndicator == null ? ComponentState.RELEASE : ComponentState.KB_RELEASE);
         if(_repeatTimer != null)
         {
            _repeatTimer.stop();
            _repeatTimer.reset();
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
            _repeatTimer = null;
         }
         handleClick(param1);
         _pressedByKeyboard = false;
         if(!_isRepeating && !this.keyboardHandlingLocked)
         {
            _loc2_ = new ButtonEvent(ButtonEvent.CLICK,true,false,param1,0,true,false);
            dispatchEvent(_loc2_);
            this.mouseHandlingLocked = true;
            App.utils.scheduler.scheduleTask(this.unlockMouseHandling,INPUT_LOCK_DURATION);
         }
         _isRepeating = false;
      }
      
      override protected function changeFocus() : void
      {
         var _loc1_:String = null;
         if(!this.enabled)
         {
            return;
         }
         if(_focusIndicator == null)
         {
            if(group != null && groupName != null && groupName != "")
            {
               if(this.useFocusedAsSelect && (_focused || _displayFocus) && !this.selected)
               {
                  this.selected = true;
               }
            }
            else
            {
               setState(_focused || _displayFocus ? ComponentState.OVER : ComponentState.OUT);
            }
            if(_pressedByKeyboard && !_focused)
            {
               _pressedByKeyboard = false;
            }
         }
         else
         {
            if(_focusIndicator.totalframes == 1)
            {
               _focusIndicator.visible = _focused > 0;
            }
            else
            {
               _loc1_ = STATE_PREFIX_LABEL + _focused;
               if(_focusIndicatorLabelHash[_loc1_])
               {
                  _newFocusIndicatorFrame = STATE_PREFIX_LABEL + _focused;
               }
               else
               {
                  _newFocusIndicatorFrame = _focused || _displayFocus ? SHOW_LABEL : HIDE_LABEL;
               }
               invalidateState();
            }
            if(_pressedByKeyboard && !_focused)
            {
               setState(ComponentState.KB_RELEASE);
               _pressedByKeyboard = false;
            }
         }
      }
      
      public function beginButtonRepeat() : void
      {
         if(autoRepeat && _repeatTimer == null)
         {
            _repeatTimer = new Timer(repeatDelay,1);
            _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false,0,true);
            _repeatTimer.start();
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         if(this._mutedSoundTypes)
         {
            return this._mutedSoundTypes.indexOf(param1) == -1;
         }
         return this.enabled;
      }
      
      public final function getSoundId() : String
      {
         return this._soundId;
      }
      
      public final function getSoundType() : String
      {
         return this.soundType;
      }
      
      private function updateMouseEnabled() : void
      {
         mouseEnabled = this._mouseEnabledOnDisabled && !this.enabled ? Boolean(true) : Boolean(this.enabled);
      }
      
      private function unlockMouseHandling() : void
      {
         this.mouseHandlingLocked = false;
      }
      
      private function unlockKeyboardHandling() : void
      {
         this.keyboardHandlingLocked = false;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == this.enabled)
         {
            return;
         }
         if(this.focusable && this.focused && !param1)
         {
            this.focused = 0;
         }
         super.enabled = param1;
         buttonMode = useHandCursor = this.enabled;
         if(this._mouseEnabledOnDisabled)
         {
            mouseEnabled = false;
            App.utils.scheduler.scheduleOnNextFrame(this.updateMouseEnabled);
         }
      }
      
      [Inspectable(defaultValue="normal",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 != null && param1 != "" && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      [Inspectable(defaultValue="",type="String")]
      public function get soundId() : String
      {
         return this._soundId;
      }
      
      public function set soundId(param1:String) : void
      {
         this._soundId = param1;
      }
      
      public function get soundEnabled() : Boolean
      {
         return this._soundEnabled;
      }
      
      public function set soundEnabled(param1:Boolean) : void
      {
         if(this._soundEnabled == param1)
         {
            return;
         }
         this._soundEnabled = param1;
         if(App.soundMgr != null)
         {
            if(this._soundEnabled)
            {
               App.soundMgr.addSoundsHdlrs(this);
            }
            else
            {
               App.soundMgr.removeSoundHdlrs(this);
            }
         }
      }
      
      public function get mouseEnabledOnDisabled() : Boolean
      {
         return this._mouseEnabledOnDisabled;
      }
      
      public function set mouseEnabledOnDisabled(param1:Boolean) : void
      {
         if(this._mouseEnabledOnDisabled == param1)
         {
            return;
         }
         this._mouseEnabledOnDisabled = param1;
         this.updateMouseEnabled();
      }
      
      public function set mutedSoundTypes(param1:Array) : void
      {
         this._mutedSoundTypes = param1;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:ButtonEvent = null;
         _autoRepeatEvent = null;
         if(!this.enabled)
         {
            return;
         }
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc4_ != MouseEventEx.LEFT_BUTTON)
         {
            _loc5_ = this.isUseRightBtn && _loc4_ == MouseEventEx.RIGHT_BUTTON;
            if(!_loc5_)
            {
               return;
            }
         }
         _mouseDown ^= 1 << _loc3_;
         if(_mouseDown == 0 && _repeatTimer != null)
         {
            _repeatTimer.stop();
            _repeatTimer.reset();
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
            _repeatTimer = null;
         }
         setState(ComponentState.RELEASE);
         handleClick(_loc3_);
         if(!_isRepeating && !this.mouseHandlingLocked)
         {
            _loc6_ = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,false);
            dispatchEvent(_loc6_);
            this.keyboardHandlingLocked = true;
            App.utils.scheduler.scheduleTask(this.unlockKeyboardHandling,INPUT_LOCK_DURATION);
         }
         _isRepeating = false;
         callLogEvent(param1);
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         _isRepeating = false;
         super.handleReleaseOutside(param1);
      }
   }
}
