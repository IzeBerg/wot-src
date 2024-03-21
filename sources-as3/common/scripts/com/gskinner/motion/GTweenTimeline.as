package com.gskinner.motion
{
   public class GTweenTimeline extends GTween
   {
       
      
      public var suppressCallbacks:Boolean;
      
      protected var callbacks:Array;
      
      protected var labels:Object;
      
      protected var tweens:Array;
      
      protected var tweenStartPositions:Array;
      
      public function GTweenTimeline(param1:Object = null, param2:Number = 1, param3:Object = null, param4:Object = null, param5:Object = null, param6:Array = null)
      {
         this.tweens = [];
         this.tweenStartPositions = [];
         this.callbacks = [];
         this.labels = {};
         this.addTweens(param6);
         super(param1,param2,param3,param4,param5);
         if(autoPlay)
         {
            paused = false;
         }
      }
      
      public static function setPropertyValue(param1:Object, param2:String, param3:*) : void
      {
         param1[param2] = param3;
      }
      
      override public function set position(param1:Number) : void
      {
         var _loc5_:int = 0;
         var _loc2_:Boolean = suppressEvents;
         suppressEvents = true;
         super.position = param1;
         var _loc3_:Number = _position / duration >> 0;
         var _loc4_:Boolean = reflect && _loc3_ % 2 >= 1;
         var _loc6_:int = this.tweens.length;
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               this.tweens[_loc5_].position = calculatedPosition - this.tweenStartPositions[_loc5_];
               _loc5_++;
            }
         }
         else
         {
            _loc5_ = _loc6_ - 1;
            while(_loc5_ >= 0)
            {
               this.tweens[_loc5_].position = calculatedPosition - this.tweenStartPositions[_loc5_];
               _loc5_--;
            }
         }
         if(!this.suppressCallbacks)
         {
            this.checkCallbacks();
         }
         suppressEvents = _loc2_;
         if(onChange != null && !suppressEvents)
         {
            onChange(this);
         }
         if(onComplete != null && !suppressEvents && param1 >= repeatCount * duration && repeatCount > 0)
         {
            onComplete(this);
         }
      }
      
      public function addTween(param1:Number, param2:GTween) : void
      {
         if(param2 == null || isNaN(param1))
         {
            return;
         }
         param2.autoPlay = false;
         param2.paused = true;
         var _loc3_:int = -1;
         while(++_loc3_ < this.tweens.length && this.tweenStartPositions[_loc3_] < param1)
         {
         }
         this.tweens.splice(_loc3_,0,param2);
         this.tweenStartPositions.splice(_loc3_,0,param1);
         param2.position = calculatedPosition - param1;
      }
      
      public function addTweens(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            this.addTween(param1[_loc2_],param1[_loc2_ + 1] as GTween);
            _loc2_ += 2;
         }
      }
      
      public function removeTween(param1:GTween) : void
      {
         var _loc2_:int = this.tweens.length;
         while(_loc2_ >= 0)
         {
            if(this.tweens[_loc2_] == param1)
            {
               this.tweens.splice(_loc2_,1);
               this.tweenStartPositions.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      public function addLabel(param1:Number, param2:String) : void
      {
         this.labels[param2] = param1;
      }
      
      public function removeLabel(param1:String) : void
      {
         delete this.labels[param1];
      }
      
      public function addCallback(param1:*, param2:Function, param3:Array = null, param4:Function = null, param5:Array = null) : void
      {
         var _loc6_:Number = this.resolveLabelOrPosition(param1);
         if(isNaN(_loc6_))
         {
            return;
         }
         var _loc7_:Callback = new Callback(_loc6_,param2,param3,param4,param5);
         var _loc8_:int = this.callbacks.length;
         var _loc9_:int = _loc8_ - 1;
         while(_loc9_ >= 0)
         {
            if(_loc6_ > this.callbacks[_loc9_].position)
            {
               break;
            }
            _loc9_--;
         }
         this.callbacks.splice(_loc9_ + 1,0,_loc7_);
      }
      
      public function removeCallback(param1:*) : void
      {
         var _loc2_:Number = this.resolveLabelOrPosition(param1);
         if(isNaN(_loc2_))
         {
            return;
         }
         var _loc3_:int = this.callbacks.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_ == this.callbacks[_loc4_].position)
            {
               this.callbacks.splice(_loc4_,1);
            }
            _loc4_++;
         }
      }
      
      public function gotoAndPlay(param1:*) : void
      {
         this.goto(param1);
         paused = false;
      }
      
      public function gotoAndStop(param1:*) : void
      {
         this.goto(param1);
         paused = true;
      }
      
      public function goto(param1:*) : void
      {
         var _loc2_:Number = this.resolveLabelOrPosition(param1);
         if(!isNaN(_loc2_))
         {
            this.position = _loc2_;
         }
      }
      
      public function resolveLabelOrPosition(param1:*) : Number
      {
         return !!isNaN(param1) ? Number(this.labels[String(param1)]) : Number(param1);
      }
      
      public function calculateDuration() : void
      {
         var _loc1_:Number = 0;
         if(this.callbacks.length > 0)
         {
            _loc1_ = this.callbacks[this.callbacks.length - 1].position;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.tweens.length)
         {
            if(this.tweens[_loc2_].duration + this.tweenStartPositions[_loc2_] > _loc1_)
            {
               _loc1_ = this.tweens[_loc2_].duration + this.tweenStartPositions[_loc2_];
            }
            _loc2_++;
         }
         duration = _loc1_;
      }
      
      protected function checkCallbacks() : void
      {
         var _loc3_:Boolean = false;
         if(this.callbacks.length == 0)
         {
            return;
         }
         var _loc1_:uint = _position / duration >> 0;
         var _loc2_:uint = positionOld / duration >> 0;
         if(_loc1_ == _loc2_ || repeatCount > 0 && _position >= duration * repeatCount)
         {
            this.checkCallbackRange(calculatedPositionOld,calculatedPosition);
         }
         else
         {
            _loc3_ = reflect && _loc2_ % 2 >= 1;
            this.checkCallbackRange(calculatedPositionOld,!!_loc3_ ? Number(0) : Number(duration));
            _loc3_ = reflect && _loc1_ % 2 >= 1;
            this.checkCallbackRange(!!_loc3_ ? Number(duration) : Number(0),calculatedPosition,!reflect);
         }
      }
      
      protected function checkCallbackRange(param1:Number, param2:Number, param3:Boolean = false) : void
      {
         var _loc9_:Callback = null;
         var _loc10_:Number = NaN;
         var _loc4_:Number = param1;
         var _loc5_:Number = param2;
         var _loc6_:int = -1;
         var _loc7_:int = this.callbacks.length;
         var _loc8_:int = 1;
         if(param1 > param2)
         {
            _loc4_ = param2;
            _loc5_ = param1;
            _loc6_ = _loc7_;
            _loc7_ = _loc8_ = -1;
         }
         while((_loc6_ = _loc6_ + _loc8_) != _loc7_)
         {
            _loc9_ = this.callbacks[_loc6_];
            _loc10_ = _loc9_.position;
            if(_loc10_ > _loc4_ && _loc10_ < _loc5_ || _loc10_ == param2 || param3 && _loc10_ == param1)
            {
               if(_loc8_ == 1)
               {
                  if(_loc9_.forward != null)
                  {
                     _loc9_.forward.apply(this,_loc9_.forwardParams);
                  }
               }
               else if(_loc9_.reverse != null)
               {
                  _loc9_.reverse.apply(this,_loc9_.reverseParams);
               }
            }
         }
      }
   }
}

class Callback
{
    
   
   public var position:Number;
   
   public var forward:Function;
   
   public var reverse:Function;
   
   public var forwardParams:Array;
   
   public var reverseParams:Array;
   
   function Callback(param1:Number, param2:Function, param3:Array, param4:Function, param5:Array)
   {
      super();
      this.position = param1;
      this.forward = param2;
      this.reverse = param4;
      this.forwardParams = param3;
      this.reverseParams = param5;
   }
}
