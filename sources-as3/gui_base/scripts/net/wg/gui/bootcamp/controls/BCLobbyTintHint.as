package net.wg.gui.bootcamp.controls
{
   import fl.motion.easing.Linear;
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.gui.bootcamp.events.AppearEvent;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   
   public class BCLobbyTintHint extends BCHighlightRendererBase
   {
      
      private static const CORNER_PADDING:int = 3;
      
      private static const DURATION_TIME_SCALE:int = 1000;
      
      private static const DURATION_TIME_ALPHA:int = 500;
      
      private static const DURATION_TIME_ALPHA_SHORT:int = 100;
      
      private static const DURATION_TIME_STEP:int = 200;
      
      private static const LABEL_APPEAR:String = "appear";
      
      private static const LABEL_DISAPPEAR:String = "disappear";
      
      private static const LABEL_VOID:String = "void";
      
      private static const DEF_COUNT_LINES:int = 3;
      
      private static const FX_LINE:String = "fxLine";
      
      private static const START_SCALE_LONG:Number = 1.25;
      
      private static const START_SCALE_SHORT:Number = 0.25;
       
      
      public var tint:MovieClip = null;
      
      public var border:MovieClip = null;
      
      public var fxLine1:MovieClip = null;
      
      public var fxLine2:MovieClip = null;
      
      public var fxLine3:MovieClip = null;
      
      public var fxLine4:MovieClip = null;
      
      private var _isFlag:Boolean = false;
      
      private var _isCycle:Boolean = true;
      
      private var _fastDisappear:Boolean = true;
      
      private var _longScale:Number = 1.25;
      
      private var _lines:Number = 3;
      
      private var _tweenArray:Array;
      
      private var _scaleTweenArray:Array;
      
      private var _timeoutArray:Array;
      
      private var _currentLoopStep:int = 0;
      
      private var _startedAnimations:int = 0;
      
      private var _isStarted:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _lastWidth:Number = 0;
      
      private var _lastHeight:Number = 0;
      
      private var _tweenTime:Number = 1000;
      
      public function BCLobbyTintHint()
      {
         this._tweenArray = [];
         this._scaleTweenArray = [];
         this._timeoutArray = [];
         this._scheduler = App.utils.scheduler;
         super();
         this.fxLine1.visible = this.fxLine2.visible = this.fxLine3.visible = this.fxLine4.visible = false;
      }
      
      private static function setupBorder(param1:MovieClip, param2:Number, param3:Number, param4:Boolean, param5:Boolean) : void
      {
         if(param5)
         {
            param1.cornerLeftTop.x = 0;
            param1.cornerLeftTop.y = 0;
            param1.cornerRightTop.x = param2;
            param1.cornerRightTop.y = 0;
            param1.cornerLeftBottom.x = 0;
            param1.cornerLeftBottom.y = param3;
            param1.cornerRightBottom.x = param2;
            param1.cornerRightBottom.y = param3;
            param1.lineTop.width = param2 - 2 * CORNER_PADDING;
            param1.lineBottom.width = param2 - 2 * CORNER_PADDING;
            param1.lineLeft.height = param3 - 2 * CORNER_PADDING;
            param1.lineRight.height = param3 - 2 * CORNER_PADDING;
            param1.lineTop.x = param1.cornerLeftTop.x + CORNER_PADDING;
            param1.lineTop.y = param1.cornerLeftTop.y;
            param1.lineBottom.x = param1.cornerLeftBottom.x + CORNER_PADDING;
            param1.lineBottom.y = param1.cornerLeftBottom.y;
            param1.lineLeft.x = param1.cornerLeftTop.x;
            param1.lineLeft.y = param1.cornerLeftTop.y + CORNER_PADDING;
            param1.lineRight.x = param1.cornerRightTop.x;
            param1.lineRight.y = param1.cornerRightTop.y + CORNER_PADDING;
         }
         else
         {
            param1.x = 0;
            param1.y = 0;
         }
         if(param1.visible != param4)
         {
            param1.visible = param4;
         }
      }
      
      private static function setupTint(param1:MovieClip, param2:Number, param3:Number, param4:Boolean) : void
      {
         if(param4)
         {
            param1.width = param2;
            param1.height = param3;
         }
         param1.x = 0;
         param1.y = 0;
      }
      
      private function setupLines(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc5_:MovieClip = null;
         var _loc4_:int = 1;
         while(_loc4_ <= this._lines)
         {
            _loc5_ = getChildByName(FX_LINE + String(_loc4_)) as MovieClip;
            if(param3)
            {
               _loc5_.width = param1;
               _loc5_.height = param2;
            }
            _loc5_.x = param1 / 2;
            _loc5_.y = param2 / 2;
            _loc4_++;
         }
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweenArray)
         {
            while(this._tweenArray.length > 0)
            {
               _loc1_ = this._tweenArray.pop();
               _loc1_.paused = true;
               _loc1_.dispose();
            }
         }
         if(this._scaleTweenArray)
         {
            while(this._scaleTweenArray.length > 0)
            {
               _loc1_ = this._scaleTweenArray.pop();
               _loc1_.paused = true;
               _loc1_.dispose();
            }
         }
         while(this._timeoutArray.length)
         {
            clearTimeout(this._timeoutArray.pop());
         }
         this._scheduler.cancelTask(this.finishItemAnimation);
         this._scheduler.cancelTask(this.animItemStart);
      }
      
      private function finishItemAnimation() : void
      {
         if(--this._startedAnimations <= 0)
         {
            gotoAndPlay(LABEL_DISAPPEAR);
            this.disposeTweens();
         }
      }
      
      private function animFxLineFinish(param1:Tween) : void
      {
         var _loc2_:Tween = new Tween(!!this._fastDisappear ? Number(DURATION_TIME_ALPHA_SHORT) : Number(DURATION_TIME_ALPHA),param1.target,{"alpha":0},{
            "ease":Strong.easeIn,
            "onComplete":this.finishItemAnimation,
            "fastTransform":false
         });
         this._tweenArray.push(_loc2_);
      }
      
      private function animFxLineStart(param1:MovieClip) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.visible = true;
         var _loc2_:Number = this.getStartScaleX(param1);
         var _loc3_:Number = param1.scaleX;
         var _loc4_:Number = this.getStartScaleY(param1);
         var _loc5_:Number = param1.scaleY;
         param1.scaleX = _loc2_;
         param1.scaleY = _loc4_;
         param1.alpha = 0;
         var _loc6_:Function = !!this._fastDisappear ? Linear.easeNone : Strong.easeOut;
         var _loc7_:Tween = new Tween(this._tweenTime,param1,{
            "scaleX":_loc3_,
            "scaleY":_loc5_
         },{"ease":_loc6_});
         var _loc8_:Tween = new Tween(this._tweenTime,param1,{"alpha":1},{
            "ease":_loc6_,
            "onComplete":this.animFxLineFinish,
            "fastTransform":false
         });
         this._scaleTweenArray.push(_loc7_);
         this._tweenArray.push(_loc8_);
      }
      
      private function resizeTweens() : void
      {
         var _loc3_:Tween = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Tween = null;
         if(this._scaleTweenArray == null)
         {
            return;
         }
         var _loc1_:int = this._scaleTweenArray.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._scaleTweenArray[_loc2_];
            if(!_loc3_.paused)
            {
               _loc4_ = MovieClip(_loc3_.target);
               _loc5_ = _loc3_.position;
               _loc6_ = _loc5_ / this._tweenTime;
               _loc7_ = this.getStartScaleX(_loc4_);
               _loc8_ = _loc4_.scaleX;
               _loc9_ = this.getStartScaleY(_loc4_);
               _loc10_ = _loc4_.scaleY;
               _loc3_.paused = true;
               _loc4_.scaleX = _loc7_ + (_loc8_ - _loc7_) * _loc6_;
               _loc4_.scaleY = _loc9_ + (_loc10_ - _loc9_) * _loc6_;
               _loc11_ = this._tweenTime - _loc5_;
               _loc12_ = new Tween(_loc11_,_loc4_,{
                  "scaleX":_loc8_,
                  "scaleY":_loc10_
               },{"ease":Strong.easeOut});
               this._scaleTweenArray.push(_loc12_);
            }
            _loc2_++;
         }
      }
      
      private function getStartScaleX(param1:MovieClip) : Number
      {
         if(param1.scaleX > param1.scaleY)
         {
            return this._longScale * param1.scaleX;
         }
         return (START_SCALE_SHORT * param1.height + param1.width) / param1.width * param1.scaleX;
      }
      
      private function getStartScaleY(param1:MovieClip) : Number
      {
         if(param1.scaleX > param1.scaleY)
         {
            return (START_SCALE_SHORT * param1.width + param1.height) / param1.height * param1.scaleY;
         }
         return this._longScale * param1.scaleY;
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         if(currentLabel == LABEL_VOID)
         {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            ++this._currentLoopStep;
            this.startItemAnimation();
         }
      }
      
      private function animItemStart(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         gotoAndPlay(LABEL_APPEAR);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this._startedAnimations = param1;
         if(param1 > 0)
         {
            _loc2_ = 1;
            while(_loc2_ <= param1)
            {
               _loc3_ = getChildByName(FX_LINE + String(_loc2_)) as MovieClip;
               this._timeoutArray.push(setTimeout(this.animFxLineStart,DURATION_TIME_STEP * (_loc2_ - 1),_loc3_));
               _loc2_++;
            }
         }
         else
         {
            this._scheduler.scheduleTask(this.finishItemAnimation,this._tweenTime);
         }
      }
      
      private function startItemAnimation() : void
      {
         this._scheduler.cancelTask(this.animItemStart);
         if(this._currentLoopStep == 0 || this._isCycle)
         {
            this.animItemStart(this._lines);
            dispatchEvent(new AppearEvent(AppearEvent.PREPARE));
         }
         else
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function set isCycle(param1:Boolean) : void
      {
         this._isCycle = param1;
      }
      
      public function set longScale(param1:Number) : void
      {
         this._longScale = param1;
      }
      
      public function set lines(param1:Number) : void
      {
         this._lines = param1;
      }
      
      public function set tweenTime(param1:Number) : void
      {
         this._tweenTime = param1;
      }
      
      public function set fastDisappear(param1:Boolean) : void
      {
         this._fastDisappear = param1;
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(this._lastWidth != param1 || this._lastHeight != param2)
         {
            this._lastWidth = param1;
            this._lastHeight = param2;
            if(!this._isStarted)
            {
               gotoAndStop(1);
               this.startItemAnimation();
               this._isStarted = true;
            }
            setupBorder(this.border,param1,param2,true,!this._isFlag);
            setupTint(this.tint.mc,param1,param2,!this._isFlag);
            this.setupLines(param1,param2,!this._isFlag);
            if(!this._isFlag)
            {
               this.resizeTweens();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.tint = null;
         this.border = null;
         this.fxLine1 = null;
         this.fxLine2 = null;
         this.fxLine3 = null;
         this.fxLine4 = null;
         this.disposeTweens();
         this._tweenArray = null;
         this._scaleTweenArray = null;
         this._timeoutArray = null;
         this._scheduler = null;
         super.onDispose();
      }
      
      protected function get size() : uint
      {
         return this._lastHeight;
      }
      
      protected function set isFlag(param1:Boolean) : void
      {
         this._isFlag = param1;
      }
   }
}
