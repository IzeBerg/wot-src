package net.wg.gui.battle.pveBase.views.primaryObjective
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.pveBase.views.primaryObjective.controls.PrimaryObjectiveMessage;
   import net.wg.gui.battle.pveBase.views.primaryObjective.controls.PrimaryObjectiveMovie;
   import net.wg.gui.battle.pveBase.views.primaryObjective.controls.PrimaryObjectiveResult;
   import net.wg.gui.battle.pveBase.views.primaryObjective.controls.PrimaryObjectiveTask;
   import net.wg.gui.battle.pveBase.views.primaryObjective.data.PvePrimaryObjectiveVO;
   import net.wg.infrastructure.base.meta.IPvePrimaryObjectiveMeta;
   import net.wg.infrastructure.base.meta.impl.PvePrimaryObjectiveMeta;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class PvePrimaryObjective extends PvePrimaryObjectiveMeta implements IPvePrimaryObjectiveMeta
   {
      
      private static const STATE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const STATE_SHOW_RESULT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const STATE_HIDE_RESULT:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const STATE_SMALL_ID:int = 0;
      
      private static const STATE_NO_TIMER_ID:int = 2;
      
      private static const STATE_BIG:String = "go_big";
      
      private static const STATE_BIG_IDLE:String = "big";
      
      private static const STATE_SMALL:String = "go_small";
      
      private static const STATE_SMALL_IDLE:String = "small";
      
      private static const STATE_NO_TIMER:String = "no_timer";
      
      private static const STATE_APPEAR:String = "appear";
      
      private static const STATE_LONG_APPEAR:String = "long_appear";
      
      private static const STATE_DISAPPEAR:String = "disappear";
      
      private static const HINT_NO_TIMER_Y:int = 43;
      
      private static const HINT_TIMER_Y:int = 84;
      
      private static const HINT_TASK_OFFSET:int = 7;
       
      
      public var timer:PrimaryObjectiveMovie = null;
      
      public var hintBg:MovieClip = null;
      
      public var hintTask:PrimaryObjectiveTask = null;
      
      public var hintResult:PrimaryObjectiveResult = null;
      
      public var timerMessage:PrimaryObjectiveMessage = null;
      
      public var shadow:MovieClip = null;
      
      private var _state:int = -1;
      
      private var _header:String = "";
      
      private var _objective:String = "";
      
      private var _title:String = "";
      
      private var _time:String = "";
      
      private var _firstTime:Boolean = true;
      
      private var _hintState:Boolean = false;
      
      private var _isWin:Boolean = false;
      
      private var _iconResult:String = "";
      
      private var _headerResult:String = "";
      
      private var _isVisibleHintBg:Boolean = false;
      
      private var _isSmall:Boolean = false;
      
      private var _isShadowEnabled:Boolean = false;
      
      private var _isShowResult:Boolean = false;
      
      public function PvePrimaryObjective()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      private function isShadowEnabled() : Boolean
      {
         return Boolean(this._header.length != 0 || this._objective.length != 0 || this._title.length != 0 || this._time.length != 0);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(STATE_VALIDATION))
         {
            this.hintTask.setText(this._header,this._objective);
            this.timer.setText(this._title);
            this.timer.setTimer(this._time);
            _loc1_ = this.isShadowEnabled();
            if(this._isShadowEnabled != _loc1_)
            {
               this._isShadowEnabled = _loc1_;
               this.shadow.gotoAndPlay(!!this._isShadowEnabled ? STATE_APPEAR : STATE_DISAPPEAR);
            }
         }
         if(isInvalid(STATE_SHOW_RESULT))
         {
            this.hintResult.setData(this._isWin,this._iconResult,this._headerResult);
            this.hintResult.gotoAndPlay(STATE_APPEAR);
            this.timer.setTaskBarVisibility(false);
            if(!this._isShadowEnabled)
            {
               this._isShadowEnabled = true;
               this.shadow.gotoAndPlay(STATE_APPEAR);
            }
         }
         if(isInvalid(STATE_HIDE_RESULT))
         {
            this.hintResult.gotoAndPlay(STATE_DISAPPEAR);
            this.timer.setTaskBarVisibility(true);
            if(this._isShadowEnabled)
            {
               this._isShadowEnabled = false;
               this.shadow.gotoAndPlay(STATE_DISAPPEAR);
            }
         }
      }
      
      private function updateHintTaskPosition() : void
      {
         if(StringUtils.isEmpty(this._time))
         {
            this.hintTask.y = HINT_NO_TIMER_Y;
         }
         else
         {
            this.hintTask.y = HINT_TIMER_Y;
         }
         if(this._isSmall)
         {
            this.hintTask.y -= HINT_TASK_OFFSET;
         }
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this._isSmall = param1 <= StageSizeBoundaries.WIDTH_1366 || param2 <= StageSizeBoundaries.HEIGHT_768;
         this.hintBg.width = param1;
         this.hintBg.x = -this.hintBg.width >> 1;
         this.hintTask.updateStage(this._isSmall);
         this.hintResult.updateStage(this._isSmall);
         this.timer.updateStage(this._isSmall);
         this.updateHintTaskPosition();
      }
      
      override protected function onDispose() : void
      {
         this.timerMessage.dispose();
         this.timerMessage = null;
         this.timer.dispose();
         this.timer = null;
         this.hintTask.dispose();
         this.hintTask = null;
         this.hintResult.dispose();
         this.hintResult = null;
         this.hintBg = null;
         this.shadow = null;
         super.onDispose();
      }
      
      public function as_showMessage(param1:String) : void
      {
         this.timerMessage.showMessage(param1);
      }
      
      public function as_hideMessage() : void
      {
         this.timerMessage.hideMessage();
      }
      
      public function as_playFx(param1:Boolean, param2:Boolean) : void
      {
         this.timer.playFx(param1,param2);
      }
      
      public function as_setHintState(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? STATE_APPEAR : STATE_DISAPPEAR;
         this._hintState = param1;
         if(this.hintTask)
         {
            if(this._firstTime && _loc2_ == STATE_APPEAR)
            {
               this._firstTime = false;
               _loc2_ = STATE_LONG_APPEAR;
            }
            this.hintTask.gotoAndPlay(_loc2_);
         }
         this.timer.setTaskBarVisibility(!param1);
         invalidate(STATE_VALIDATION);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      public function as_setTimerBackground(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(this._isVisibleHintBg != param1)
         {
            this._isVisibleHintBg = param1;
            if(this.hintBg)
            {
               _loc2_ = !!param1 ? STATE_APPEAR : STATE_DISAPPEAR;
               this.hintBg.gotoAndPlay(_loc2_);
            }
         }
      }
      
      public function as_setTimerState(param1:int) : void
      {
         var _loc2_:String = null;
         if(this._state != param1)
         {
            this._state = param1;
            if(param1 == STATE_NO_TIMER_ID)
            {
               this.timer.gotoAndStop(STATE_NO_TIMER);
            }
            else if(param1 == STATE_SMALL_ID)
            {
               this.timer.gotoAndPlay(STATE_SMALL);
            }
            else
            {
               this.timer.gotoAndPlay(STATE_BIG);
            }
            invalidate(STATE_VALIDATION);
            dispatchEvent(new Event(Event.RESIZE));
         }
         else if(param1 == STATE_NO_TIMER_ID)
         {
            this.timer.gotoAndStop(STATE_NO_TIMER);
         }
         else
         {
            _loc2_ = param1 == STATE_SMALL_ID ? STATE_SMALL_IDLE : STATE_BIG_IDLE;
            if(_loc2_ != this.timer.currentLabel)
            {
               this.timer.gotoAndStop(_loc2_);
               invalidate(STATE_VALIDATION);
            }
         }
      }
      
      public function as_updateTime(param1:String) : void
      {
         if(this._time != param1)
         {
            if(StringUtils.isEmpty(this._time) != StringUtils.isEmpty(param1))
            {
               this._time = param1;
               this.updateHintTaskPosition();
            }
            else
            {
               this._time = param1;
            }
            invalidate(STATE_VALIDATION);
         }
      }
      
      public function as_updateProgressBar(param1:int, param2:Boolean) : void
      {
         this.timer.updateProgressBar(param1,param2);
      }
      
      override protected function setData(param1:PvePrimaryObjectiveVO) : void
      {
         this._header = param1.header;
         this._objective = param1.objective;
         this._title = param1.title;
         invalidate(STATE_VALIDATION);
      }
      
      public function as_showResult(param1:Boolean, param2:String, param3:String) : void
      {
         this._isWin = param1;
         this._iconResult = param2;
         this._headerResult = param3;
         this._isShowResult = true;
         invalidate(STATE_SHOW_RESULT);
      }
      
      public function as_hideResult() : void
      {
         if(this._isShowResult)
         {
            this._isShowResult = false;
            invalidate(STATE_HIDE_RESULT);
         }
      }
   }
}
