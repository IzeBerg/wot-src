package com.gskinner.motion
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class GTween extends EventDispatcher
   {
      
      public static var version:Number = 2.01;
      
      public static var defaultDispatchEvents:Boolean = false;
      
      public static var pauseAll:Boolean = false;
      
      public static var timeScaleAll:Number = 1;
      
      protected static var hasStarPlugins:Boolean = false;
      
      protected static var plugins:Object = {};
      
      protected static var shape:Shape;
      
      protected static var time:Number;
      
      protected static var tickList:Dictionary = new Dictionary(true);
      
      protected static var gcLockList:Dictionary = new Dictionary(false);
      
      public static var defaultEase:Function = linearEase;
      
      {
         staticInit();
      }
      
      protected var _delay:Number = 0;
      
      protected var _values:Object;
      
      protected var _paused:Boolean = true;
      
      protected var _position:Number;
      
      protected var _inited:Boolean;
      
      protected var _initValues:Object;
      
      protected var _rangeValues:Object;
      
      protected var _proxy:TargetProxy;
      
      public var autoPlay:Boolean = true;
      
      public var data;
      
      public var duration:Number;
      
      public var ease:Function;
      
      public var nextTween:GTween;
      
      public var pluginData:Object;
      
      public var reflect:Boolean;
      
      public var repeatCount:int = 1;
      
      public var target:Object;
      
      public var useFrames:Boolean;
      
      public var timeScale:Number = 1;
      
      public var positionOld:Number;
      
      public var ratio:Number;
      
      public var ratioOld:Number;
      
      public var calculatedPosition:Number;
      
      public var calculatedPositionOld:Number;
      
      public var suppressEvents:Boolean;
      
      public var dispatchEvents:Boolean;
      
      public var onComplete:Function;
      
      public var onChange:Function;
      
      public var onInit:Function;
      
      public function GTween(param1:Object = null, param2:Number = 1, param3:Object = null, param4:Object = null, param5:Object = null)
      {
         var _loc6_:Boolean = false;
         super();
         this.ease = defaultEase;
         this.dispatchEvents = defaultDispatchEvents;
         this.target = param1;
         this.duration = param2;
         this.pluginData = this.copy(param5,{});
         if(param4)
         {
            _loc6_ = param4.swapValues;
            delete param4.swapValues;
         }
         this.copy(param4,this);
         this.resetValues(param3);
         if(_loc6_)
         {
            this.swapValues();
         }
         if(this.duration == 0 && this.delay == 0 && this.autoPlay)
         {
            this.position = 0;
         }
      }
      
      public static function installPlugin(param1:Object, param2:Array, param3:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc4_:uint = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param2[_loc4_];
            if(_loc5_ == "*")
            {
               hasStarPlugins = true;
            }
            if(plugins[_loc5_] == null)
            {
               plugins[_loc5_] = [param1];
            }
            else if(param3)
            {
               plugins[_loc5_].unshift(param1);
            }
            else
            {
               plugins[_loc5_].push(param1);
            }
            _loc4_++;
         }
      }
      
      public static function linearEase(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1;
      }
      
      protected static function staticInit() : void
      {
         (shape = new Shape()).addEventListener(Event.ENTER_FRAME,staticTick);
         time = getTimer() / 1000;
      }
      
      protected static function staticTick(param1:Event) : void
      {
         var _loc4_:* = null;
         var _loc5_:GTween = null;
         var _loc2_:Number = time;
         time = getTimer() / 1000;
         if(pauseAll)
         {
            return;
         }
         var _loc3_:Number = (time - _loc2_) * timeScaleAll;
         for(_loc4_ in tickList)
         {
            _loc5_ = _loc4_ as GTween;
            _loc5_.position = _loc5_._position + (!!_loc5_.useFrames ? timeScaleAll : _loc3_) * _loc5_.timeScale;
         }
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      public function set paused(param1:Boolean) : void
      {
         if(param1 == this._paused)
         {
            return;
         }
         this._paused = param1;
         if(this._paused)
         {
            delete tickList[this];
            if(this.target is IEventDispatcher)
            {
               this.target.removeEventListener("_",this.invalidate);
            }
            delete gcLockList[this];
         }
         else
         {
            if(isNaN(this._position) || this.repeatCount != 0 && this._position >= this.repeatCount * this.duration)
            {
               this._inited = false;
               this.calculatedPosition = this.calculatedPositionOld = this.ratio = this.ratioOld = this.positionOld = 0;
               this._position = -this.delay;
            }
            tickList[this] = true;
            if(this.target is IEventDispatcher)
            {
               this.target.addEventListener("_",this.invalidate);
            }
            else
            {
               gcLockList[this] = true;
            }
         }
      }
      
      public function get position() : Number
      {
         return this._position;
      }
      
      public function set position(param1:Number) : void
      {
         var _loc4_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         this.positionOld = this._position;
         this.ratioOld = this.ratio;
         this.calculatedPositionOld = this.calculatedPosition;
         var _loc2_:Number = this.repeatCount * this.duration;
         var _loc3_:Boolean = param1 >= _loc2_ && this.repeatCount > 0;
         if(_loc3_)
         {
            if(this.calculatedPositionOld == _loc2_)
            {
               return;
            }
            this._position = _loc2_;
            this.calculatedPosition = this.reflect && !(this.repeatCount & 1) ? Number(0) : Number(this.duration);
         }
         else
         {
            this._position = param1;
            this.calculatedPosition = this._position < 0 ? Number(0) : Number(this._position % this.duration);
            if(this.reflect && this._position / this.duration & 1)
            {
               this.calculatedPosition = this.duration - this.calculatedPosition;
            }
         }
         this.ratio = this.duration == 0 && this._position >= 0 ? Number(1) : Number(this.ease(this.calculatedPosition / this.duration,0,1,1));
         if(this.target && (this._position >= 0 || this.positionOld >= 0) && this.calculatedPosition != this.calculatedPositionOld)
         {
            if(!this._inited)
            {
               this.init();
            }
            for(_loc4_ in this._values)
            {
               _loc5_ = this._initValues[_loc4_];
               _loc6_ = this._rangeValues[_loc4_];
               _loc7_ = _loc5_ + _loc6_ * this.ratio;
               _loc8_ = plugins[_loc4_];
               if(_loc8_)
               {
                  _loc9_ = _loc8_.length;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc7_ = _loc8_[_loc10_].tween(this,_loc4_,_loc7_,_loc5_,_loc6_,this.ratio,_loc3_);
                     _loc10_++;
                  }
                  if(!isNaN(_loc7_))
                  {
                     this.target[_loc4_] = _loc7_;
                  }
               }
               else
               {
                  this.target[_loc4_] = _loc7_;
               }
            }
         }
         if(hasStarPlugins)
         {
            _loc8_ = plugins["*"];
            _loc9_ = _loc8_.length;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc8_[_loc10_].tween(this,"*",NaN,NaN,NaN,this.ratio,_loc3_);
               _loc10_++;
            }
         }
         if(!this.suppressEvents)
         {
            if(this.dispatchEvents)
            {
               this.dispatchEvt("change");
            }
            if(this.onChange != null)
            {
               this.onChange(this);
            }
         }
         if(_loc3_)
         {
            this.paused = true;
            if(this.nextTween)
            {
               this.nextTween.paused = false;
            }
            if(!this.suppressEvents)
            {
               if(this.dispatchEvents)
               {
                  this.dispatchEvt("complete");
               }
               if(this.onComplete != null)
               {
                  this.onComplete(this);
               }
            }
         }
      }
      
      public function get delay() : Number
      {
         return this._delay;
      }
      
      public function set delay(param1:Number) : void
      {
         if(this._position <= 0)
         {
            this._position = -param1;
         }
         this._delay = param1;
      }
      
      public function get proxy() : TargetProxy
      {
         if(this._proxy == null)
         {
            this._proxy = new TargetProxy(this);
         }
         return this._proxy;
      }
      
      public function setValue(param1:String, param2:Number) : void
      {
         this._values[param1] = param2;
         this.invalidate();
      }
      
      public function getValue(param1:String) : Number
      {
         return this._values[param1];
      }
      
      public function deleteValue(param1:String) : Boolean
      {
         delete this._rangeValues[param1];
         delete this._initValues[param1];
         return delete this._values[param1];
      }
      
      public function setValues(param1:Object) : void
      {
         this.copy(param1,this._values,true);
         this.invalidate();
      }
      
      public function resetValues(param1:Object = null) : void
      {
         this._values = {};
         this.setValues(param1);
      }
      
      public function getValues() : Object
      {
         return this.copy(this._values,{});
      }
      
      public function getInitValue(param1:String) : Number
      {
         return this._initValues[param1];
      }
      
      public function swapValues() : void
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         if(!this._inited)
         {
            this.init();
         }
         var _loc1_:Object = this._values;
         this._values = this._initValues;
         this._initValues = _loc1_;
         for(_loc2_ in this._rangeValues)
         {
            this._rangeValues[_loc2_] *= -1;
         }
         if(this._position < 0)
         {
            _loc3_ = this.positionOld;
            this.position = 0;
            this._position = this.positionOld;
            this.positionOld = _loc3_;
         }
         else
         {
            this.position = this._position;
         }
      }
      
      public function init() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         this._inited = true;
         this._initValues = {};
         this._rangeValues = {};
         for(_loc1_ in this._values)
         {
            if(plugins[_loc1_])
            {
               _loc2_ = plugins[_loc1_];
               _loc3_ = _loc2_.length;
               _loc4_ = _loc1_ in this.target ? Number(this.target[_loc1_]) : Number(NaN);
               _loc5_ = 0;
               while(_loc5_ < _loc3_)
               {
                  _loc4_ = _loc2_[_loc5_].init(this,_loc1_,_loc4_);
                  _loc5_++;
               }
               if(!isNaN(_loc4_))
               {
                  this._rangeValues[_loc1_] = this._values[_loc1_] - (this._initValues[_loc1_] = _loc4_);
               }
            }
            else
            {
               this._rangeValues[_loc1_] = this._values[_loc1_] - (this._initValues[_loc1_] = this.target[_loc1_]);
            }
         }
         if(hasStarPlugins)
         {
            _loc2_ = plugins["*"];
            _loc3_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_[_loc5_].init(this,"*",NaN);
               _loc5_++;
            }
         }
         if(!this.suppressEvents)
         {
            if(this.dispatchEvents)
            {
               this.dispatchEvt("init");
            }
            if(this.onInit != null)
            {
               this.onInit(this);
            }
         }
      }
      
      public function beginning() : void
      {
         this.position = 0;
         this.paused = true;
      }
      
      public function end() : void
      {
         this.position = this.repeatCount > 0 ? Number(this.repeatCount * this.duration) : Number(this.duration);
      }
      
      protected function invalidate() : void
      {
         this._inited = false;
         if(this._position > 0)
         {
            this._position = 0;
         }
         if(this.autoPlay)
         {
            this.paused = false;
         }
      }
      
      protected function copy(param1:Object, param2:Object, param3:Boolean = false) : Object
      {
         var _loc4_:* = null;
         for(_loc4_ in param1)
         {
            if(param3 && param1[_loc4_] == null)
            {
               delete param2[_loc4_];
            }
            else
            {
               param2[_loc4_] = param1[_loc4_];
            }
         }
         return param2;
      }
      
      protected function dispatchEvt(param1:String) : void
      {
         if(hasEventListener(param1))
         {
            dispatchEvent(new Event(param1));
         }
      }
   }
}

import com.gskinner.motion.GTween;
import flash.utils.Proxy;
import flash.utils.flash_proxy;

dynamic class TargetProxy extends Proxy
{
    
   
   private var tween:GTween;
   
   function TargetProxy(param1:GTween)
   {
      super();
      this.tween = param1;
   }
   
   override flash_proxy function callProperty(param1:*, ... rest) : *
   {
      return this.tween.target[param1].apply(null,rest);
   }
   
   override flash_proxy function getProperty(param1:*) : *
   {
      var _loc2_:Number = this.tween.getValue(param1);
      return !!isNaN(_loc2_) ? this.tween.target[param1] : _loc2_;
   }
   
   override flash_proxy function setProperty(param1:*, param2:*) : void
   {
      if(param2 is Boolean || param2 is String || isNaN(param2))
      {
         this.tween.target[param1] = param2;
      }
      else
      {
         this.tween.setValue(String(param1),Number(param2));
      }
   }
   
   override flash_proxy function deleteProperty(param1:*) : Boolean
   {
      this.tween.deleteValue(param1);
      return true;
   }
}
