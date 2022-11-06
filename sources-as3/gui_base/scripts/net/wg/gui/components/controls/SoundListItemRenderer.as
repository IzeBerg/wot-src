package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class SoundListItemRenderer extends ListItemRenderer implements ISoundable
   {
       
      
      [Inspectable(type="String")]
      public var soundId:String = "";
      
      private var _soundType:String = "itemRenderer";
      
      private var _useRightButton:Boolean = false;
      
      private var _mouseEnabledOnDisabled:Boolean = false;
      
      public function SoundListItemRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateMouseEnabled();
         if(App.soundMgr)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && data && data.hasOwnProperty("enabled"))
         {
            this.enabled = data.enabled;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         if(App.soundMgr != null)
         {
            App.soundMgr.removeSoundHdlrs(this);
         }
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return this.enabled;
      }
      
      public final function getSoundId() : String
      {
         return this.soundId;
      }
      
      public final function getSoundType() : String
      {
         return this.soundType;
      }
      
      private function updateMouseEnabled() : void
      {
         if(this._mouseEnabledOnDisabled && !enabled)
         {
            mouseEnabled = true;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.updateMouseEnabled();
      }
      
      [Inspectable(defaultValue="itemRenderer",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      public function get useRightButton() : Boolean
      {
         return this._useRightButton;
      }
      
      [Inspectable(defaultValue="false",type="Boolean")]
      public function set useRightButton(param1:Boolean) : void
      {
         if(this._useRightButton == param1)
         {
            return;
         }
         this._useRightButton = param1;
      }
      
      public function get mouseEnabledOnDisabled() : Boolean
      {
         return this._mouseEnabledOnDisabled;
      }
      
      public function set mouseEnabledOnDisabled(param1:Boolean) : void
      {
         this._mouseEnabledOnDisabled = param1;
         this.updateMouseEnabled();
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         if(this._useRightButton)
         {
            this.handleMousePressEx(param1);
         }
         else
         {
            super.handleMousePress(param1);
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         if(this._useRightButton)
         {
            this.handleMouseReleaseEx(param1);
         }
         else
         {
            super.handleMouseRelease(param1);
         }
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         if(this._useRightButton)
         {
            this.handleReleaseOutsideEx(param1);
         }
         else
         {
            super.handleReleaseOutside(param1);
         }
      }
      
      protected function handleMousePressEx(param1:MouseEvent) : void
      {
         var _loc5_:ButtonEvent = null;
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         _mouseDown |= 1 << _loc3_;
         if(enabled)
         {
            if(_loc4_ == 0)
            {
               setState("down");
            }
            if(autoRepeat && _repeatTimer == null)
            {
               _autoRepeatEvent = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,true);
               _repeatTimer = new Timer(repeatDelay,1);
               _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false,0,true);
               _repeatTimer.start();
            }
            _loc5_ = new ButtonEvent(ButtonEvent.PRESS,true,false,_loc3_,_loc4_,false,false);
            dispatchEvent(_loc5_);
            callLogEvent(param1);
         }
      }
      
      protected function handleMouseReleaseEx(param1:MouseEvent) : void
      {
         var _loc5_:ButtonEvent = null;
         _autoRepeatEvent = null;
         if(!enabled)
         {
            return;
         }
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         _mouseDown ^= 1 << _loc3_;
         if(_mouseDown == 0 && _repeatTimer)
         {
            _repeatTimer.stop();
            _repeatTimer.reset();
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
            _repeatTimer = null;
         }
         if(_loc4_ == 0)
         {
            setState("release");
            handleClick(_loc3_);
         }
         if(!_isRepeating)
         {
            _loc5_ = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,false);
            dispatchEvent(_loc5_);
         }
         _isRepeating = false;
         callLogEvent(param1);
      }
      
      protected function handleReleaseOutsideEx(param1:MouseEvent) : void
      {
         _autoRepeatEvent = null;
         if(contains(DisplayObject(param1.target)))
         {
            return;
         }
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.handleReleaseOutside,false);
         _mouseDown ^= 1 << _loc3_;
         dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE_OUTSIDE));
         if(!enabled)
         {
            return;
         }
         if(lockDragStateChange && _loc4_ == 0)
         {
            if(_focused || _displayFocus)
            {
               setState(focusIndicator == null ? "release" : "kb_release");
            }
            else
            {
               setState("kb_release");
            }
         }
      }
   }
}
