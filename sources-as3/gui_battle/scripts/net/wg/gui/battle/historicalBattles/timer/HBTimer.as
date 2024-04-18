package net.wg.gui.battle.historicalBattles.timer
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.historicalBattles.timer.controls.TimerMessage;
   import net.wg.gui.battle.historicalBattles.timer.controls.TimerMovie;
   import net.wg.gui.battle.historicalBattles.timer.controls.TimerTask;
   import net.wg.infrastructure.base.meta.IHBTimerMeta;
   import net.wg.infrastructure.base.meta.impl.HBTimerMeta;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class HBTimer extends HBTimerMeta implements IHBTimerMeta
   {
      
      private static const STATE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const STATE_SMALL:String = "go_small";
      
      private static const STATE_BIG:String = "go_big";
      
      private static const STATE_SMALL_IDLE:String = "small";
      
      private static const STATE_BIG_IDLE:String = "big";
      
      private static const STATE_APPEAR:String = "appear";
      
      private static const STATE_LONG_APPEAR:String = "long_appear";
      
      private static const STATE_DISAPPEAR:String = "disappear";
      
      private static const HINT_NO_TIMER_Y:int = 43;
      
      private static const HINT_TIMER_Y:int = 84;
      
      private static const TOP_SMALL_OFFSET:int = 89;
      
      private static const HINT_OFFSET:int = 39;
      
      private static const TOP_BIG_OFFSET:int = 124;
      
      private static const STATE_SMALL_ID:int = 0;
       
      
      public var timer:TimerMovie = null;
      
      public var hintBg:MovieClip = null;
      
      public var hintTask:TimerTask = null;
      
      public var timerMessage:TimerMessage = null;
      
      private var _state:int = -1;
      
      private var _header:String = "";
      
      private var _objective:String = "";
      
      private var _objectiveBig:String = "";
      
      private var _time:String = "";
      
      private var _firstTime:Boolean = true;
      
      private var _hintState:Boolean = false;
      
      public function HBTimer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.hintBg.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(STATE_VALIDATION))
         {
            if(StringUtils.isEmpty(this._time))
            {
               this.hintTask.y = HINT_NO_TIMER_Y;
            }
            else
            {
               this.hintTask.y = HINT_TIMER_Y;
            }
            this.hintTask.setText(this._header,this._objectiveBig);
            this.timer.setText(this._objective);
            this.timer.setTimer(this._time);
         }
      }
      
      override protected function onDispose() : void
      {
         this.timerMessage.dispose();
         this.timerMessage = null;
         this.timer.dispose();
         this.timer = null;
         this.hintTask.dispose();
         this.hintTask = null;
         this.hintBg = null;
         super.onDispose();
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
         _loc2_ = !!param1 ? STATE_APPEAR : STATE_DISAPPEAR;
         if(this.hintBg)
         {
            this.hintBg.visible = true;
            this.hintBg.gotoAndPlay(_loc2_);
         }
      }
      
      public function as_setTimerState(param1:int) : void
      {
         var _loc2_:String = null;
         if(this._state != param1)
         {
            this._state = param1;
            if(param1 == STATE_SMALL_ID)
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
      
      public function as_showMessage(param1:String) : void
      {
         this.timerMessage.showMessage(param1);
      }
      
      public function as_updateObjective(param1:String) : void
      {
         this._objective = param1;
         invalidate(STATE_VALIDATION);
      }
      
      public function as_updateObjectiveBig(param1:String) : void
      {
         this._objectiveBig = param1;
         invalidate(STATE_VALIDATION);
      }
      
      public function as_updateProgressBar(param1:int, param2:Boolean) : void
      {
         this.timer.updateProgressBar(param1,param2);
      }
      
      public function as_updateTime(param1:String) : void
      {
         this._time = param1;
         invalidate(STATE_VALIDATION);
      }
      
      public function as_updateTitle(param1:String) : void
      {
         this._header = param1;
         invalidate(STATE_VALIDATION);
      }
      
      public function getTopOffset() : int
      {
         var _loc1_:int = 0;
         if(this._state == STATE_SMALL_ID || StringUtils.isEmpty(this._time))
         {
            _loc1_ = TOP_SMALL_OFFSET;
         }
         else
         {
            _loc1_ = TOP_BIG_OFFSET;
            if(this._hintState)
            {
               _loc1_ += HINT_OFFSET;
            }
         }
         return _loc1_;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.hintBg.width = param1;
         this.hintBg.x = -this.hintBg.width >> 1;
         this.hintTask.updateStageWidth(param1);
      }
   }
}
