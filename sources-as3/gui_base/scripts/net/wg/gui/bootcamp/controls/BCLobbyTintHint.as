package net.wg.gui.bootcamp.controls
{
   import fl.motion.easing.Linear;
   import fl.transitions.easing.Strong;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.bootcamp.events.AppearEvent;
   import net.wg.utils.IScheduler;
   import scaleform.clik.motion.Tween;
   
   public class BCLobbyTintHint extends BCHighlightRendererBase
   {
      
      private static const CORNER_PADDING:int = 3;
      
      private static const DURATION_TIME_SCALE:int = 1000;
      
      private static const FADE_OUT_TIME_ALPHA:int = 500;
      
      private static const FADE_OUT_TIME_ALPHA_SHORT:int = 100;
      
      private static const DURATION_TIME_STEP:int = 200;
      
      private static const LABEL_APPEAR:String = "appear";
      
      private static const LABEL_DISAPPEAR:String = "disappear";
      
      private static const LABEL_VOID:String = "void";
      
      private static const DEF_COUNT_LINES:int = 3;
      
      private static const START_SCALE_LONG:Number = 1.25;
      
      private static const START_SCALE_SHORT:Number = 0.25;
      
      private static const COUNT_LINES_ERROR:String = "The number of lines must be greater" + " than the existing MovieClips in _linesMC";
       
      
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
      
      private var _linesMC:Vector.<MovieClip>;
      
      private var _lines:Number = 3;
      
      private var _fadeInTweens:Array;
      
      private var _fadeOutTweens:Array;
      
      private var _currentLoopStep:int = 0;
      
      private var _isStarted:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _lastWidth:Number = 0;
      
      private var _lastHeight:Number = 0;
      
      private var _tweenTime:Number = 1000;
      
      public function BCLobbyTintHint()
      {
         this._fadeInTweens = [];
         this._fadeOutTweens = [];
         this._scheduler = App.utils.scheduler;
         super();
         this.fxLine1.visible = this.fxLine2.visible = this.fxLine3.visible = this.fxLine4.visible = false;
         this._linesMC = new <MovieClip>[this.fxLine1,this.fxLine2,this.fxLine3,this.fxLine4];
         this.addVoidFrameScript(this.onLabelVoidFrameScript);
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
      
      private static function removeTweens(param1:Array) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1[_loc3_].dispose();
            _loc3_++;
         }
         param1.splice(0,_loc2_);
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(this._lastWidth != param1 || this._lastHeight != param2)
         {
            this._lastWidth = param1;
            this._lastHeight = param2;
            setupBorder(this.border,param1,param2,true,!this._isFlag);
            setupTint(this.tint.mc,param1,param2,!this._isFlag);
            this.setupLines(param1,param2,!this._isFlag);
            if(!this._isStarted)
            {
               gotoAndStop(1);
               this.startItemAnimation();
               this._isStarted = true;
            }
            if(!this._isFlag)
            {
               this.resizeTweens();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.addVoidFrameScript(null);
         stop();
         this.tint = null;
         this.border = null;
         this.fxLine1 = null;
         this.fxLine2 = null;
         this.fxLine3 = null;
         this.fxLine4 = null;
         this.disposeTweens();
         this._fadeInTweens = null;
         this._fadeOutTweens = null;
         this._scheduler = null;
         this._linesMC.splice(0,this._linesMC.length);
         this._linesMC = null;
         super.onDispose();
      }
      
      private function runFadeInFxLine(param1:int) : void
      {
         var _loc2_:Tween = null;
         if(!this._fadeInTweens[param1])
         {
            _loc2_ = this.createFadeInTween(param1);
            if(_loc2_)
            {
               this._fadeInTweens[param1] = _loc2_;
            }
         }
         else
         {
            _loc2_ = this._fadeInTweens[param1];
            this.prepareFirstAnimation(MovieClip(_loc2_.target));
         }
         var _loc3_:Number = DURATION_TIME_STEP * param1;
         _loc2_.position = -_loc3_;
         _loc2_.paused = false;
      }
      
      private function createFadeInTween(param1:int) : Tween
      {
         var _loc2_:MovieClip = this._linesMC[param1];
         if(!_loc2_)
         {
            return null;
         }
         _loc2_.visible = true;
         var _loc3_:Number = _loc2_.scaleX;
         var _loc4_:Number = _loc2_.scaleY;
         this.prepareFirstAnimation(_loc2_);
         var _loc5_:Function = !!this._fastDisappear ? Linear.easeNone : Strong.easeOut;
         return new Tween(this._tweenTime,_loc2_,{
            "alpha":1,
            "scaleX":_loc3_,
            "scaleY":_loc4_
         },{
            "ease":_loc5_,
            "onComplete":this.onFadeInComplete,
            "data":param1
         });
      }
      
      private function onFadeInComplete(param1:Tween) : void
      {
         this.runFadeOutTween(int(param1.data),MovieClip(param1.target));
      }
      
      private function runFadeOutTween(param1:int, param2:MovieClip) : void
      {
         var _loc3_:Tween = null;
         if(!this._fadeOutTweens[param1])
         {
            _loc3_ = this.createFadeoutTween(param1,param2);
            if(_loc3_)
            {
               this._fadeOutTweens[param1] = _loc3_;
            }
         }
         else
         {
            _loc3_ = this._fadeOutTweens[param1];
         }
         _loc3_.paused = false;
      }
      
      private function createFadeoutTween(param1:int, param2:MovieClip) : Tween
      {
         var _loc3_:int = !!this._fastDisappear ? int(FADE_OUT_TIME_ALPHA_SHORT) : int(FADE_OUT_TIME_ALPHA);
         var _loc4_:Function = param1 == this._lines - 1 ? this.finishLastLineAnimation : null;
         return new Tween(_loc3_,param2,{"alpha":0},{
            "ease":Strong.easeIn,
            "fastTransform":false,
            "onComplete":_loc4_,
            "data":param1
         });
      }
      
      private function finishLastLineAnimation(param1:Tween) : void
      {
         gotoAndPlay(LABEL_DISAPPEAR);
      }
      
      private function addVoidFrameScript(param1:Function) : void
      {
         var _loc2_:FrameLabel = null;
         var _loc3_:int = currentLabels.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = currentLabels[_loc4_];
            if(_loc2_.name == LABEL_VOID)
            {
               addFrameScript(_loc2_.frame - 1,this.onLabelVoidFrameScript);
               break;
            }
            _loc4_++;
         }
      }
      
      private function onLabelVoidFrameScript() : void
      {
         ++this._currentLoopStep;
         this.startItemAnimation();
      }
      
      private function prepareFirstAnimation(param1:MovieClip) : void
      {
         param1.scaleX = this.getStartScaleX(param1);
         param1.scaleY = this.getStartScaleY(param1);
         param1.alpha = 0;
      }
      
      private function resizeTweens() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Tween = null;
         var _loc3_:int = 0;
         if(this._fadeInTweens && this._fadeOutTweens.length >= this._lines)
         {
            _loc1_ = this._fadeOutTweens;
            this._fadeOutTweens = [];
            _loc3_ = 0;
            while(_loc3_ < this._lines)
            {
               _loc2_ = this.createFadeInTween(_loc3_);
               _loc2_.position = Tween(_loc1_[_loc3_]).position;
               _loc3_++;
            }
            removeTweens(_loc1_);
         }
      }
      
      private function setupLines(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         while(_loc5_ < this._lines)
         {
            _loc4_ = this._linesMC[_loc5_];
            if(param3)
            {
               _loc4_.width = param1;
               _loc4_.height = param2;
            }
            _loc4_.x = param1 / 2;
            _loc4_.y = param2 / 2;
            _loc5_++;
         }
      }
      
      private function disposeTweens() : void
      {
         removeTweens(this._fadeInTweens);
         removeTweens(this._fadeOutTweens);
         this._scheduler.cancelTask(this.finishLastLineAnimation);
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
      
      private function animItemStart(param1:Number) : void
      {
         var _loc2_:int = 0;
         gotoAndPlay(LABEL_APPEAR);
         if(param1 > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1)
            {
               this.runFadeInFxLine(_loc2_);
               _loc2_++;
            }
         }
         else
         {
            this._scheduler.scheduleTask(this.finishLastLineAnimation,this._tweenTime);
         }
      }
      
      private function startItemAnimation() : void
      {
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
         if(param1 <= this._linesMC.length)
         {
            this._lines = param1;
         }
         else
         {
            DebugUtils.LOG_ERROR(COUNT_LINES_ERROR);
         }
      }
      
      public function set tweenTime(param1:Number) : void
      {
         this._tweenTime = param1;
      }
      
      public function set fastDisappear(param1:Boolean) : void
      {
         this._fastDisappear = param1;
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
