package net.wg.gui.battle.views.damagePanel.components.modules
{
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   
   public class ModuleRepairAnim extends DamagePanelItemFrameStates
   {
      
      private static const DEFAULT_DELAY:int = 20;
      
      private static const REPAIR_ANIM_COUNT_FRAMES:int = 42;
      
      private static const FIRST_FRAME_REPAIR_ANIM:int = 1;
      
      private static const DEFAULT_PLAYBACK_SPEED:Number = 1;
      
      private static const REPAIRING_PROGRESS_INVALID_MASK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const IS_REPAIRING_INVALID_MASK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const LABEL_UPDATE_TIME:Number = 100;
       
      
      public var repairTimeTF:TextField;
      
      private var _showRepairTimer:Boolean = false;
      
      private var _animationTimer:Timer;
      
      private var _labelTimer:Timer;
      
      private var _startTime:int;
      
      private var _animDuration:int;
      
      private var _playbackSpeed:Number = 1;
      
      private var _repairPercents:int = 0;
      
      private var _isRepairing:Boolean = false;
      
      private var _repairTime:Number = 0;
      
      public function ModuleRepairAnim()
      {
         super();
         stop();
         this.repairTimeTF.visible = false;
         var _loc1_:int = REPAIR_ANIM_COUNT_FRAMES + FIRST_FRAME_REPAIR_ANIM - currentFrame + 1;
         this._animationTimer = new Timer(DEFAULT_DELAY,_loc1_);
         this._animationTimer.addEventListener(TimerEvent.TIMER,this.onAnimationTimerHandler);
         this._animationTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onAnimationTimerCompleteHandler);
         this._labelTimer = new Timer(LABEL_UPDATE_TIME);
         this._labelTimer.addEventListener(TimerEvent.TIMER,this.onLabelTimerHandler);
      }
      
      override protected function onDispose() : void
      {
         this._animationTimer.stop();
         this._animationTimer.removeEventListener(TimerEvent.TIMER,this.onAnimationTimerHandler);
         this._animationTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onAnimationTimerCompleteHandler);
         this._animationTimer = null;
         this._labelTimer.stop();
         this._labelTimer.removeEventListener(TimerEvent.TIMER,this.onLabelTimerHandler);
         this._labelTimer = null;
         this.repairTimeTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            visible = state != BATTLE_ITEM_STATES.DESTROYED && state != BATTLE_ITEM_STATES.NORMAL;
         }
         if(isInvalid(IS_REPAIRING_INVALID_MASK))
         {
            visible = this._isRepairing;
            if(this._showRepairTimer)
            {
               this.repairTimeTF.visible = this._isRepairing;
            }
         }
         if(isInvalid(REPAIRING_PROGRESS_INVALID_MASK))
         {
            gotoAndStop(this.currentRepairFrame(this._repairPercents));
         }
      }
      
      public function setPlaybackSpeed(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(param1 < 0.0001)
         {
            param1 = 0.0001;
            this._animationTimer.stop();
         }
         if(this._animationTimer.running)
         {
            _loc2_ = this._playbackSpeed / param1;
            _loc3_ = getTimer();
            this._startTime = _loc3_ - (_loc3_ - this._startTime) * _loc2_;
            this._animDuration *= _loc2_;
            this._animationTimer.delay *= _loc2_;
         }
         if(this._labelTimer.running)
         {
            this._labelTimer.stop();
            this._labelTimer.delay = LABEL_UPDATE_TIME * (1 / param1);
            this._labelTimer.start();
         }
         this._playbackSpeed = param1;
      }
      
      public function setRepairSeconds(param1:int, param2:int) : void
      {
         this.setRepairing(true);
         this.updateTimer(param1,param2);
         this._repairPercents = param1;
         if(!this._labelTimer.running || param2 > this._repairTime)
         {
            this._repairTime = param2;
            this._labelTimer.reset();
            this._labelTimer.delay = LABEL_UPDATE_TIME * (1 / this._playbackSpeed);
            this._labelTimer.start();
         }
         invalidate(REPAIRING_PROGRESS_INVALID_MASK);
      }
      
      private function updateTimer(param1:int, param2:int) : void
      {
         param2 /= this._playbackSpeed;
         var _loc3_:int = param1 * (param2 / (100 - param1));
         var _loc4_:int = getTimer();
         this._startTime = _loc4_ - _loc3_;
         var _loc5_:int = _loc4_ + param2;
         this._animDuration = _loc5_ - this._startTime;
         var _loc6_:int = REPAIR_ANIM_COUNT_FRAMES + FIRST_FRAME_REPAIR_ANIM - this.currentRepairFrame(param1);
         var _loc7_:int = param2 / _loc6_;
         this._animationTimer.reset();
         this._animationTimer.delay = _loc7_;
         this._animationTimer.repeatCount = _loc6_;
         this._animationTimer.start();
         this._repairTime = Math.min(_loc7_ * _loc6_,this._repairTime);
      }
      
      private function currentRepairFrame(param1:int) : int
      {
         return FIRST_FRAME_REPAIR_ANIM + param1 * REPAIR_ANIM_COUNT_FRAMES / 100 | 0;
      }
      
      private function setRepairing(param1:Boolean) : void
      {
         if(this._isRepairing == param1)
         {
            return;
         }
         this._isRepairing = param1;
         invalidate(IS_REPAIRING_INVALID_MASK);
      }
      
      override public function set state(param1:String) : void
      {
         super.state = param1;
         this.setRepairing(false);
         this._animationTimer.stop();
         this._labelTimer.stop();
      }
      
      private function onAnimationTimerHandler(param1:TimerEvent) : void
      {
         this._repairPercents = 100 * (getTimer() - this._startTime) / this._animDuration;
         invalidate(REPAIRING_PROGRESS_INVALID_MASK);
      }
      
      private function onLabelTimerHandler(param1:TimerEvent) : void
      {
         this._repairTime -= LABEL_UPDATE_TIME;
         this._repairTime = Math.max(this._repairTime,0);
         this.repairTimeTF.text = (this._repairTime / Time.MILLISECOND_IN_SECOND).toFixed(1);
      }
      
      private function onAnimationTimerCompleteHandler(param1:TimerEvent = null) : void
      {
         this.setRepairing(false);
      }
      
      public function setRepairTimeVisible(param1:Boolean) : void
      {
         this._showRepairTimer = param1;
         if(this._labelTimer.running)
         {
            this.repairTimeTF.visible = param1;
         }
      }
   }
}
