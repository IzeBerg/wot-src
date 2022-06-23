package net.wg.infrastructure.managers.impl
{
   import flash.display.InteractiveObject;
   import flash.events.FocusEvent;
   import flash.events.IEventDispatcher;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.base.meta.impl.GameInputManagerMeta;
   import net.wg.utils.IGameInputManager;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.controls.TextInput;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.FocusManager;
   
   public class GameInputManager extends GameInputManagerMeta implements IGameInputManager
   {
      
      private static const NO_CALLBACK:Number = -1;
       
      
      private var _dispatcher:IEventDispatcher = null;
      
      private var _ignoredKeyCode:Number = -1;
      
      private var _exclusiveHandlers:Dictionary = null;
      
      private var _handlersContainers:Dictionary = null;
      
      private var _priorities:Vector.<Number>;
      
      private var _prioritiesLen:Number;
      
      public function GameInputManager()
      {
         this._priorities = new <Number>[0];
         this._prioritiesLen = this._priorities.length;
         super();
         this._handlersContainers = new Dictionary();
         var _loc1_:int = 0;
         while(_loc1_ < this._prioritiesLen)
         {
            this._handlersContainers[this._priorities[_loc1_]] = new Dictionary();
            _loc1_++;
         }
      }
      
      private static function removeKeyHandler(param1:Number, param2:String, param3:Function, param4:Dictionary) : Boolean
      {
         var _loc5_:Number = NaN;
         if(param4[param1])
         {
            if(param4[param1][param2])
            {
               _loc5_ = getCallbackIndex(param4[param1][param2],param3);
               if(_loc5_ >= 0)
               {
                  param4[param1][param2][_loc5_].dispose();
                  param4[param1][param2].splice(_loc5_,1);
                  if(param4[param1][param2].length == 0)
                  {
                     delete param4[param1][param2];
                  }
                  if(getDictLength(param4[param1]) == 0)
                  {
                     delete param4[param1];
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      private static function clearKeyHandlersDict(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:Dictionary = null;
         var _loc5_:Array = null;
         var _loc6_:GameInputCallback = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         for(_loc2_ in param1)
         {
            _loc4_ = param1[_loc2_];
            for(_loc3_ in _loc4_)
            {
               _loc5_ = _loc4_[_loc2_];
               if(_loc5_)
               {
                  _loc7_ = _loc5_.length;
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_)
                  {
                     _loc6_ = _loc5_[_loc8_];
                     _loc6_.dispose();
                     _loc8_++;
                  }
                  _loc5_.length = 0;
                  delete _loc4_[_loc3_];
               }
            }
            delete param1[_loc2_];
         }
         param1 = null;
      }
      
      private static function addKeyHandler(param1:Number, param2:String, param3:Function, param4:Boolean, param5:String, param6:Dictionary) : void
      {
         if(!param6[param1])
         {
            param6[param1] = new Dictionary();
         }
         if(!param6[param1][param2])
         {
            param6[param1][param2] = [];
         }
         if(getCallbackIndex(param6[param1][param2],param3) != NO_CALLBACK)
         {
            DebugUtils.LOG_WARNING("GameInputHandler.setKeyHandler. Existing handler for keyCode = " + param1 + " and event = " + param2 + " is to be reset!");
         }
         else
         {
            param6[param1][param2].push(new GameInputCallback(param3,param4,param5));
         }
      }
      
      private static function getCallbackIndex(param1:Array, param2:Function) : Number
      {
         var _loc3_:int = 0;
         var _loc5_:GameInputCallback = null;
         var _loc4_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1[_loc3_];
            if(_loc5_.isHasSameHandler(param2))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return NO_CALLBACK;
      }
      
      private static function getDictLength(param1:Dictionary) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function as_addKeyHandler(param1:Number, param2:String, param3:Boolean, param4:String, param5:Number) : void
      {
         this.setKeyHandler(param1,param2,this.pyInputHandler,param3,param4,param5);
      }
      
      public function as_clearKeyHandler(param1:Number, param2:String) : void
      {
         this.clearKeyHandler(param1,param2,this.pyInputHandler);
      }
      
      public function clearKeyHandler(param1:Number, param2:String, param3:Function) : void
      {
         this.assertEventType(param2);
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < this._prioritiesLen && !_loc4_)
         {
            _loc4_ = removeKeyHandler(param1,param2,param3,this._handlersContainers[this._priorities[_loc5_]]);
            _loc5_++;
         }
      }
      
      public function clearKeyHandlers() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._prioritiesLen)
         {
            clearKeyHandlersDict(this._handlersContainers[this._priorities[_loc2_]]);
            _loc2_++;
         }
         for(_loc1_ in this._exclusiveHandlers)
         {
            delete this._exclusiveHandlers[_loc1_];
         }
         this._exclusiveHandlers = null;
      }
      
      override protected function onDispose() : void
      {
         this.clearKeyHandlers();
         this._handlersContainers = null;
         this._dispatcher.removeEventListener(InputEvent.INPUT,this.onInputHandler);
         this._dispatcher.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler,true);
         this._dispatcher = null;
         super.onDispose();
      }
      
      public function initStage(param1:IEventDispatcher) : void
      {
         this._dispatcher = param1;
         this._dispatcher.addEventListener(InputEvent.INPUT,this.onInputHandler,false,0,true);
         this._dispatcher.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler,true,10000,true);
      }
      
      public function setIgnoredKeyCode(param1:Number) : void
      {
         this._ignoredKeyCode = param1;
      }
      
      public function setKeyHandler(param1:Number, param2:String, param3:Function, param4:Boolean, param5:String = null, param6:Number = 0) : void
      {
         this.assertEventType(param2);
         if(!this._handlersContainers[param6])
         {
            this._handlersContainers[param6] = new Dictionary();
            this._priorities.push(param6);
            this._prioritiesLen = this._priorities.length;
            this._priorities = this._priorities.sort(Array.NUMERIC | Array.DESCENDING);
         }
         addKeyHandler(param1,param2,param3,param4,param5,this._handlersContainers[param6]);
      }
      
      private function assertEventType(param1:String) : void
      {
         App.utils.asserter.assert(param1 == InputValue.KEY_UP || param1 == InputValue.KEY_DOWN,"Event must be \'keyUp\' or \'keyDown\'");
      }
      
      private function getSystemFocus(param1:uint) : InteractiveObject
      {
         if(Extensions.isScaleform)
         {
            return FocusManager.getFocus(param1);
         }
         return App.stage.focus;
      }
      
      private function hasExclusiveHandlers() : Boolean
      {
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:* = this._exclusiveHandlers;
         for(_loc2_ in _loc4_)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function findHandler(param1:InputDetails, param2:Dictionary) : GameInputCallback
      {
         var _loc4_:int = 0;
         var _loc3_:GameInputCallback = null;
         if(!param2[param1.code])
         {
            return null;
         }
         if(!param2[param1.code][param1.value])
         {
            return null;
         }
         if(param2[param1.code][param1.value].length == 0)
         {
            return null;
         }
         _loc4_ = param2[param1.code][param1.value].length - 1;
         return param2[param1.code][param1.value][_loc4_] as GameInputCallback;
      }
      
      private function pyInputHandler(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         handleGlobalKeyEventS(_loc2_.code,_loc2_.value);
      }
      
      private function onInputHandler(param1:InputEvent) : void
      {
         var callback:GameInputCallback = null;
         var details:InputDetails = null;
         var i:int = 0;
         var focused:TextField = null;
         var focusedParent:TextInput = null;
         var event:InputEvent = param1;
         try
         {
            callback = null;
            details = event.details;
            if(event.handled || this._ignoredKeyCode == details.code)
            {
               return;
            }
            i = 0;
            while(i < this._prioritiesLen && !callback)
            {
               callback = this.findHandler(details,this._handlersContainers[this._priorities[i]]);
               i++;
            }
            if(!callback)
            {
               return;
            }
            if(callback.cancelEvent)
            {
               if(!this._exclusiveHandlers)
               {
                  this._exclusiveHandlers = new Dictionary(true);
               }
               this._exclusiveHandlers[details.code] = callback.cancelEvent;
            }
            else if(this._exclusiveHandlers && this._exclusiveHandlers[details.code] == details.value)
            {
               delete this._exclusiveHandlers[details.code];
            }
            focused = this.getSystemFocus(0) as TextField;
            if(callback.isIgnoreText && focused != null)
            {
               focusedParent = focused.parent as TextInput;
               if(focused.type == TextFieldType.INPUT || focusedParent && focusedParent.enabled && focusedParent.editable)
               {
                  return;
               }
            }
            callback.envoke(event);
         }
         catch(e:Error)
         {
            DebugUtils.LOG_DEBUG(e.message);
            DebugUtils.LOG_DEBUG(e.getStackTrace());
         }
      }
      
      private function onFocusInHandler(param1:FocusEvent) : void
      {
         var _loc3_:TextInput = null;
         var _loc2_:TextField = param1.target as TextField;
         if(_loc2_)
         {
            _loc3_ = _loc2_.parent as TextInput;
            if(_loc2_.type == TextFieldType.INPUT && _loc3_ && _loc3_.enabled && _loc3_.editable && this.hasExclusiveHandlers() && App.voiceChatMgr.isVOIPAvailableS())
            {
               FocusManager.setFocus(null);
               param1.preventDefault();
               param1.stopImmediatePropagation();
            }
         }
      }
   }
}

import net.wg.data.constants.Errors;
import net.wg.infrastructure.interfaces.entity.IDisposable;
import scaleform.clik.events.InputEvent;

class GameInputCallback implements IDisposable
{
    
   
   private var _handler:Function = null;
   
   private var _ignoreText:Boolean = false;
   
   private var _cancelEvent:String = null;
   
   private var _disposed:Boolean = false;
   
   function GameInputCallback(param1:Function, param2:Boolean, param3:String = null)
   {
      super();
      App.utils.asserter.assertNotNull(param1,"handler" + Errors.CANT_NULL);
      this._handler = param1;
      this._ignoreText = param2;
      this._cancelEvent = param3;
   }
   
   public function envoke(param1:InputEvent) : void
   {
      this._handler(param1);
   }
   
   public function get isIgnoreText() : Boolean
   {
      return this._ignoreText;
   }
   
   public function get cancelEvent() : String
   {
      return this._cancelEvent;
   }
   
   public function dispose() : void
   {
      this._disposed = true;
      this._handler = null;
      this._cancelEvent = null;
   }
   
   public function isHasSameHandler(param1:Function) : Boolean
   {
      return param1 == this._handler;
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}
