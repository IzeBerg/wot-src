package net.wg.white_tiger.gui.battle.views.wtBattleTimer
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.utils.StageSizeBoundaries;
   import net.wg.white_tiger.infrastructure.base.meta.IWTBattleTimerMeta;
   import net.wg.white_tiger.infrastructure.base.meta.impl.WTBattleTimerMeta;
   import scaleform.clik.motion.Tween;
   
   public class WTBattleTimer extends WTBattleTimerMeta implements IWTBattleTimerMeta
   {
      
      private static const DEFAULT_X_DELTA:uint = 10;
      
      private static const MINUTES_X_SMALL:uint = 204;
      
      private static const MINUTES_X_BIG:uint = 194;
      
      private static const DOTS_X_SMALL:uint = 241;
      
      private static const DOTS_X_BIG:uint = 235;
      
      private static const SECONDS_X_SMALL:uint = 251;
      
      private static const SECONDS_X_BIG:uint = 246;
      
      private static const PI2:Number = 0.5 * Math.PI;
      
      private static const FRAME_HUNTER:String = "hunter";
      
      private static const FRAME_BOSS:String = "boss";
      
      private static const FRAME_SMALL:String = "small";
      
      private static const FRAME_BIG:String = "big";
      
      private static const ADD_TIME_HIDE_TEXT_DURATION:uint = 970;
      
      private static const ADD_TIME_STEP_DURATION:uint = 10;
      
      private static const ADD_TIME_MAIN_BLUR:uint = 5;
      
      private static const ADD_TIME_GLITCH_DISTANCE:uint = 5;
      
      private static const ADD_TIME_GLITCH_COUNT:uint = 36;
      
      private static const ADD_TIME_GLOW_ALPHA_SHOW:uint = 12;
      
      private static const ADD_TIME_GLITCH_ALPHA_SHOW:uint = 8;
      
      private static const ADD_TIME_GLITCH_ALPHA_HIDE:uint = 24;
      
      private static const ADD_TIME_GLITCH_X_SHOW:uint = 16;
      
      private static const ADD_TIME_GLITCH_X_HIDE:uint = 28;
      
      private static const ADD_TIME_GLITCH_ALPHA_DELAY:uint = 4;
      
      private static const COLOR_ADD_TIME_MAIN_HUNTER:uint = 2065919;
      
      private static const COLOR_ADD_TIME_MAIN_BOSS:uint = 16728899;
      
      private static const MAIN_TWEEN_DURATION:uint = 320;
      
      private static const MAIN_ALPHA_TIMER_DELAY:uint = 80;
      
      private static const MESSAGE_TEXT_SIZE_BIG:uint = 24;
      
      private static const MESSAGE_TEXT_SIZE_SMALL:uint = 18;
      
      private static const MESSAGE_X_DELTA:uint = 10;
      
      private static const MESSAGE_X_START:uint = 291;
      
      private static const MESSAGE_DELAY:uint = 180;
      
      private static const MESSAGE_ALPHA_DELAY:uint = 220;
      
      private static const MESSAGE_GLOW_DELAY:uint = 200;
      
      private static const MESSAGE_TWEEN_DURATION:uint = 320;
      
      private static const MESSAGE_ALPHA_TWEEN_DURATION:uint = 280;
      
      private static const MESSAGE_SHADOW_TWEEN_DURATION:uint = 240;
      
      private static const MESSAGE_Y_SMALL:uint = 72;
      
      private static const MESSAGE_Y_BIG:uint = 80;
       
      
      public var minutesTF:TextFieldContainer = null;
      
      public var secondsTF:TextFieldContainer = null;
      
      public var dots:MovieClip = null;
      
      public var shadow:MovieClip = null;
      
      public var glow:MovieClip = null;
      
      public var messageContainer:WTTextFieldContainer = null;
      
      public var addTimeContainer:AddTimeAnimation = null;
      
      public var sizeRect:Sprite = null;
      
      private var _minutes:String = "";
      
      private var _seconds:String = "";
      
      private var _isBoss:Boolean = false;
      
      private var _isSmall:Boolean = false;
      
      private var _addTime:String = "";
      
      private var _tweensMessage:Vector.<Tween>;
      
      private var _tweensCommon:Vector.<Tween>;
      
      private var _filterAlphaDelta:Number = 0;
      
      private var _filterAlphaDistance:Number = 0;
      
      private var _filterCounter:int = 0;
      
      private var _addAnimationActive:Boolean = false;
      
      public function WTBattleTimer()
      {
         this._tweensMessage = new Vector.<Tween>();
         this._tweensCommon = new Vector.<Tween>();
         super();
         initedWidth = this.sizeRect.width;
         this.messageContainer.alpha = this.shadow.alpha = this.glow.alpha = 0;
         this.minutesTF.alpha = this.secondsTF.alpha = this.dots.alpha = 0;
         this.messageContainer.isUpdateWidth = true;
         this.messageContainer.isMultiline = true;
         this.hideAddTimeMessage();
         this.updateStage(true);
      }
      
      override public function as_setColor(param1:Boolean) : void
      {
      }
      
      override public function as_setTotalTime(param1:String, param2:String) : void
      {
         if(this._minutes != param1)
         {
            this._minutes = param1;
            this.minutesTF.label = param1;
         }
         if(this._seconds != param2)
         {
            this._seconds = param2;
            this.secondsTF.label = param2;
         }
      }
      
      override public function as_showBattleTimer(param1:Boolean) : void
      {
         if(visible != param1)
         {
            visible = param1;
            this.updateVisibility();
         }
      }
      
      override public function updateStage(param1:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = App.appWidth <= StageSizeBoundaries.WIDTH_1366 || App.appHeight <= StageSizeBoundaries.HEIGHT_768;
         if(this._isSmall != _loc2_ || param1)
         {
            this._isSmall = _loc2_;
            _loc3_ = this.addTimeContainer.currentFrame;
            if(this._addAnimationActive)
            {
               this.addTimeContainer.resetAnimation();
            }
            this.addTimeContainer.removeEventListener(BattleTimerEvent.SHOW_GLITCH_ANIMATION,this.onShowGlitchAnimationhandler);
            gotoAndStop(!!this._isSmall ? FRAME_SMALL : FRAME_BIG);
            this.messageContainer.isSmall = this._isSmall;
            this.messageContainer.fontSize = !!this._isSmall ? int(MESSAGE_TEXT_SIZE_SMALL) : int(MESSAGE_TEXT_SIZE_BIG);
            this.messageContainer.y = !!this._isSmall ? Number(MESSAGE_Y_SMALL) : Number(MESSAGE_Y_BIG);
            this.addTimeContainer.addEventListener(BattleTimerEvent.SHOW_GLITCH_ANIMATION,this.onShowGlitchAnimationhandler);
            this.addTimeContainer.isBoss = this._isBoss;
            if(this._addAnimationActive)
            {
               this.addTimeContainer.label = this._addTime;
               this.addTimeContainer.startAnimation(_loc3_);
            }
            this.minutesTF.label = this._minutes;
            this.secondsTF.label = this._seconds;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addTimeContainer.addEventListener(BattleTimerEvent.SHOW_GLITCH_ANIMATION,this.onShowGlitchAnimationhandler);
      }
      
      override protected function updateVisibility() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_isCompVisible)
         {
            _loc1_ = MAIN_TWEEN_DURATION + MAIN_ALPHA_TIMER_DELAY;
            _loc2_ = !!this._isSmall ? int(MINUTES_X_SMALL) : int(MINUTES_X_BIG);
            _loc3_ = !!this._isSmall ? int(DOTS_X_SMALL) : int(DOTS_X_BIG);
            _loc4_ = !!this._isSmall ? int(SECONDS_X_SMALL) : int(SECONDS_X_BIG);
            this.minutesTF.x = _loc2_ + DEFAULT_X_DELTA;
            this.dots.x = _loc3_ + DEFAULT_X_DELTA;
            this.secondsTF.x = _loc4_ + DEFAULT_X_DELTA;
            this.clearTweens(this._tweensCommon);
            this._tweensCommon.push(new Tween(_loc1_,this.minutesTF,{"x":_loc2_},{"ease":Cubic.easeIn}));
            this._tweensCommon.push(new Tween(_loc1_,this.dots,{"x":_loc3_},{"ease":Cubic.easeIn}));
            this._tweensCommon.push(new Tween(_loc1_,this.secondsTF,{"x":_loc4_},{"ease":Cubic.easeIn}));
            this._tweensCommon.push(new Tween(MAIN_TWEEN_DURATION,this.minutesTF,{"alpha":1},{
               "delay":MAIN_ALPHA_TIMER_DELAY,
               "ease":Cubic.easeIn
            }));
            this._tweensCommon.push(new Tween(MAIN_TWEEN_DURATION,this.dots,{"alpha":1},{
               "delay":MAIN_ALPHA_TIMER_DELAY,
               "ease":Cubic.easeIn
            }));
            this._tweensCommon.push(new Tween(MAIN_TWEEN_DURATION,this.secondsTF,{"alpha":1},{
               "delay":MAIN_ALPHA_TIMER_DELAY,
               "ease":Cubic.easeIn
            }));
         }
         else
         {
            this.clearAllTween();
            this.as_hideMessage();
            this.minutesTF.alpha = this.secondsTF.alpha = this.dots.alpha = 0;
         }
         super.updateVisibility();
      }
      
      override protected function onDispose() : void
      {
         this.clearAllTween();
         this._tweensCommon = null;
         this._tweensMessage = null;
         this.minutesTF.dispose();
         this.minutesTF = null;
         this.secondsTF.dispose();
         this.secondsTF = null;
         this.dots = null;
         this.messageContainer.dispose();
         this.messageContainer = null;
         this.addTimeContainer.removeEventListener(BattleTimerEvent.SHOW_GLITCH_ANIMATION,this.onShowGlitchAnimationhandler);
         this.addTimeContainer.dispose();
         this.addTimeContainer = null;
         this.shadow = null;
         this.glow = null;
         this.sizeRect = null;
         super.onDispose();
      }
      
      public function as_hideMessage() : void
      {
         this.messageContainer.alpha = 0;
         this.glow.alpha = this.shadow.alpha = 0;
      }
      
      public function as_setPlayerType(param1:Boolean) : void
      {
         if(this._isBoss != param1)
         {
            this._isBoss = param1;
            this.messageContainer.isBoss = this._isBoss;
         }
      }
      
      public function as_showAdditionalTime(param1:String) : void
      {
         this._addTime = param1;
         this.hideAddTextFilters();
         this._addAnimationActive = true;
         this.addTimeContainer.label = this._addTime;
         this.addTimeContainer.isBoss = this._isBoss;
         this.addTimeContainer.visible = true;
         this.addTimeContainer.startAnimation();
      }
      
      public function as_showMessage(param1:String, param2:Boolean) : void
      {
         this.clearTweens(this._tweensMessage);
         this.as_hideMessage();
         this.messageContainer.x = MESSAGE_X_START + MESSAGE_X_DELTA;
         this.messageContainer.isSmall = this._isSmall;
         this.messageContainer.isOvertime = param2;
         this.messageContainer.label = param1;
         this.messageContainer.fontSize = !!this._isSmall ? int(MESSAGE_TEXT_SIZE_SMALL) : int(MESSAGE_TEXT_SIZE_BIG);
         var _loc3_:String = this._isBoss == param2 ? FRAME_BOSS : FRAME_HUNTER;
         this.glow.gotoAndStop(_loc3_);
         this.shadow.gotoAndStop(_loc3_);
         this._tweensMessage.push(new Tween(MESSAGE_SHADOW_TWEEN_DURATION,this.shadow,{"alpha":1},{"ease":Cubic.easeIn}));
         this._tweensMessage.push(new Tween(MESSAGE_TWEEN_DURATION,this.glow,{"alpha":1},{
            "delay":MESSAGE_GLOW_DELAY,
            "ease":Cubic.easeIn
         }));
         this._tweensMessage.push(new Tween(MESSAGE_TWEEN_DURATION,this.messageContainer,{"x":MESSAGE_X_START},{
            "delay":MESSAGE_DELAY,
            "ease":Cubic.easeIn
         }));
         this._tweensMessage.push(new Tween(MESSAGE_ALPHA_TWEEN_DURATION,this.messageContainer,{"alpha":1},{
            "delay":MESSAGE_ALPHA_DELAY,
            "ease":Cubic.easeIn
         }));
      }
      
      private function startMainTextGlitch() : void
      {
         this._filterCounter = 0;
         this._filterAlphaDelta = 0;
         this._filterAlphaDistance = 0;
         App.utils.scheduler.scheduleRepeatableTask(this.addMainTextGlitch,ADD_TIME_STEP_DURATION,ADD_TIME_GLITCH_COUNT + 1);
      }
      
      private function addMainTextGlitch() : void
      {
         if(this._filterCounter < ADD_TIME_GLITCH_ALPHA_SHOW)
         {
            this._filterAlphaDelta = this._filterCounter / ADD_TIME_GLITCH_ALPHA_SHOW;
         }
         else if(this._filterCounter >= ADD_TIME_GLITCH_ALPHA_HIDE)
         {
            this._filterAlphaDelta = (ADD_TIME_GLITCH_COUNT - this._filterCounter) / (ADD_TIME_GLITCH_COUNT - ADD_TIME_GLITCH_ALPHA_HIDE);
         }
         else
         {
            this._filterAlphaDelta = 1;
         }
         if(this._filterCounter > ADD_TIME_GLITCH_ALPHA_DELAY && this._filterCounter < ADD_TIME_GLITCH_X_HIDE)
         {
            if(this._filterCounter < ADD_TIME_GLITCH_X_SHOW)
            {
               this._filterAlphaDistance = 1 - (ADD_TIME_GLITCH_X_SHOW - this._filterCounter) / (ADD_TIME_GLITCH_X_SHOW - ADD_TIME_GLITCH_ALPHA_DELAY);
            }
            else
            {
               this._filterAlphaDistance = (ADD_TIME_GLITCH_X_HIDE - this._filterCounter) / (ADD_TIME_GLITCH_X_HIDE - ADD_TIME_GLITCH_X_SHOW);
            }
         }
         else
         {
            this._filterAlphaDistance = 0;
         }
         var _loc1_:Number = this._filterCounter < ADD_TIME_GLOW_ALPHA_SHOW ? Number(this._filterCounter / ADD_TIME_GLOW_ALPHA_SHOW) : Number(1);
         var _loc2_:uint = !!this._isBoss ? uint(COLOR_ADD_TIME_MAIN_BOSS) : uint(COLOR_ADD_TIME_MAIN_HUNTER);
         var _loc3_:DropShadowFilter = new DropShadowFilter(0,0,_loc2_,this.easeInSine(_loc1_),ADD_TIME_MAIN_BLUR,ADD_TIME_MAIN_BLUR);
         var _loc4_:DropShadowFilter = new DropShadowFilter(ADD_TIME_GLITCH_DISTANCE * this.easeInSine(this._filterAlphaDistance),0,_loc2_,this.easeInSine(this._filterAlphaDelta),0,0);
         this.minutesTF.filters = [_loc3_,_loc4_];
         this.dots.filters = [_loc3_,_loc4_];
         this.secondsTF.filters = [_loc3_,_loc4_];
         ++this._filterCounter;
         if(this._filterCounter > ADD_TIME_GLITCH_COUNT)
         {
            this.minutesTF.filters = [_loc3_];
            this.dots.filters = [_loc3_];
            this.secondsTF.filters = [_loc3_];
            App.utils.scheduler.cancelTask(this.addMainTextGlitch);
            App.utils.scheduler.scheduleTask(this.hideAddTextFilters,ADD_TIME_HIDE_TEXT_DURATION);
         }
      }
      
      private function easeInSine(param1:Number) : Number
      {
         return 1 - Math.cos(PI2 * (param1 * 0.5));
      }
      
      private function hideAddTextFilters() : void
      {
         App.utils.scheduler.cancelTask(this.hideAddTextFilters);
         this.minutesTF.filters = [];
         this.dots.filters = [];
         this.secondsTF.filters = [];
         this._addAnimationActive = false;
      }
      
      private function clearTweens(param1:Vector.<Tween>) : void
      {
         var _loc2_:Tween = null;
         for each(_loc2_ in param1)
         {
            _loc2_.onComplete = null;
            _loc2_.dispose();
         }
         param1.length = 0;
      }
      
      private function clearAllTween() : void
      {
         this.clearTweens(this._tweensCommon);
         this.clearTweens(this._tweensMessage);
         this.hideAddTimeMessage();
      }
      
      private function hideAddTimeMessage() : void
      {
         App.utils.scheduler.cancelTask(this.hideAddTextFilters);
         App.utils.scheduler.cancelTask(this.addMainTextGlitch);
         this.addTimeContainer.resetAnimation();
         this.addTimeContainer.visible = false;
         this.hideAddTextFilters();
      }
      
      private function onShowGlitchAnimationhandler(param1:BattleTimerEvent) : void
      {
         this.startMainTextGlitch();
      }
   }
}
