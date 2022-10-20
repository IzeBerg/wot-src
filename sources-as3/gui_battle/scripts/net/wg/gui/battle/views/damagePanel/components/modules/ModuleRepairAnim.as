package net.wg.gui.battle.views.damagePanel.components.modules
{
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.generated.BATTLE_DEVICES_REPAIR_MODES;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.events.RepairAnimEvent;
   import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
   import net.wg.gui.utils.FrameHelper;
   
   public class ModuleRepairAnim extends DamagePanelItemFrameStates
   {
      
      private static const DEFAULT_DELAY:int = 20;
      
      private static const REPAIR_ANIM_COUNT_FRAMES:int = 42;
      
      private static const FIRST_FRAME_REPAIR_ANIM:int = 1;
      
      private static const REPAIR_ANIM_MAX_FRAME:int = REPAIR_ANIM_COUNT_FRAMES + FIRST_FRAME_REPAIR_ANIM;
      
      private static const DEFAULT_PLAYBACK_SPEED:int = 1;
      
      private static const REPAIRING_PROGRESS_INVALID_MASK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const IS_REPAIRING_INVALID_MASK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const LABEL_UPDATE_TIME:int = 100;
      
      private static const PERCENTS_100:int = 100;
      
      private static const PAUSED_ANIM_SPEED:Number = 0.0001;
      
      private static const LBL_END_POSTFIX:String = "_end";
      
      private static const LBL_REPAIRED_END:String = BATTLE_ITEM_STATES.REPAIRED + LBL_END_POSTFIX;
      
      private static const LBL_REPAIRED_FULL_END:String = BATTLE_ITEM_STATES.REPAIRED_FULL + LBL_END_POSTFIX;
      
      private static const LBL_REPAIRED_FULL_HIDE:String = BATTLE_ITEM_STATES.REPAIRED_FULL + "_hide";
       
      
      public var repairTimeTF:TextField;
      
      public var highlightRepairTimeTF:TextField;
      
      public var warningMc:Sprite;
      
      private var _showRepairTimer:Boolean = false;
      
      private var _animationTimer:Timer;
      
      private var _labelTimer:Timer;
      
      private var _startTime:int;
      
      private var _animDuration:int;
      
      private var _playbackSpeed:Number = 1;
      
      private var _repairPercents:int = 0;
      
      private var _isRepairing:Boolean = false;
      
      private var _repairTime:Number = 0;
      
      private var _needsHighlightText:Boolean = false;
      
      private var _needsShowWarning:Boolean = false;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _needsApplyLocalPercents:Boolean = false;
      
      public function ModuleRepairAnim()
      {
         super();
         stop();
         this.repairTimeTF.visible = false;
         this.highlightRepairTimeTF.visible = false;
         var _loc1_:int = REPAIR_ANIM_MAX_FRAME - currentFrame + 1;
         this._animationTimer = new Timer(DEFAULT_DELAY,_loc1_);
         this._animationTimer.addEventListener(TimerEvent.TIMER,this.onAnimationTimerHandler);
         this._animationTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onAnimationTimerCompleteHandler);
         this._labelTimer = new Timer(LABEL_UPDATE_TIME);
         this._labelTimer.addEventListener(TimerEvent.TIMER,this.onLabelTimerHandler);
         this._frameHelper = new FrameHelper(this);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(LBL_REPAIRED_END),this.repairAnimEndHandler);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(LBL_REPAIRED_FULL_END),this.repairFullAnimEndHandler);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(LBL_REPAIRED_FULL_HIDE),this.repairFullAnimHideHandler);
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
         this.highlightRepairTimeTF = null;
         this.warningMc = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         super.onDispose();
      }
      
      override protected function applyState() : void
      {
         stop();
         if(state == BATTLE_ITEM_STATES.CRITICAL || state == BATTLE_ITEM_STATES.DESTROYED)
         {
            gotoAndStop(state);
         }
         else
         {
            gotoAndPlay(state);
         }
      }
      
      override protected function calcVisibility() : Boolean
      {
         return state != BATTLE_ITEM_STATES.DESTROYED && state != BATTLE_ITEM_STATES.NORMAL;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(IS_REPAIRING_INVALID_MASK | InvalidationType.STATE))
         {
            if(!this._isRepairing && (state == BATTLE_ITEM_STATES.REPAIRED || state == BATTLE_ITEM_STATES.REPAIRED_FULL))
            {
               this.updateElementsVisibility();
            }
            else
            {
               visible = this._isRepairing;
            }
         }
         if(!(state == BATTLE_ITEM_STATES.REPAIRED || state == BATTLE_ITEM_STATES.REPAIRED_FULL) && isInvalid(REPAIRING_PROGRESS_INVALID_MASK))
         {
            gotoAndStop(this.currentRepairFrame(this._repairPercents));
            this.updateElementsVisibility();
         }
      }
      
      public function setPlaybackSpeed(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(param1 < PAUSED_ANIM_SPEED)
         {
            param1 = PAUSED_ANIM_SPEED;
            this._animationTimer.stop();
            this._labelTimer.stop();
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
      
      public function setRepairSeconds(param1:int, param2:int, param3:int = 0) : void
      {
         this.setRepairing(true);
         param2 /= this._playbackSpeed;
         var _loc4_:int = param1 * (param2 / (PERCENTS_100 - param1));
         var _loc5_:int = getTimer();
         this._startTime = _loc5_ - _loc4_;
         var _loc6_:int = _loc5_ + param2;
         this._animDuration = _loc6_ - this._startTime;
         this._needsHighlightText = param3 == BATTLE_DEVICES_REPAIR_MODES.SLOWED;
         this._needsShowWarning = param3 == BATTLE_DEVICES_REPAIR_MODES.SUSPENDED;
         if(!this._needsApplyLocalPercents && this._needsShowWarning)
         {
            this._needsApplyLocalPercents = true;
         }
         else if(!this._needsShowWarning)
         {
            this._needsApplyLocalPercents = false;
         }
         var _loc7_:int = REPAIR_ANIM_MAX_FRAME - this.currentRepairFrame(param1);
         var _loc8_:int = param2 / _loc7_;
         this._animationTimer.reset();
         if(!this._needsShowWarning)
         {
            this._animationTimer.delay = _loc8_;
            this._animationTimer.repeatCount = _loc7_;
            this._animationTimer.start();
         }
         if(!this._needsApplyLocalPercents)
         {
            this._repairPercents = param1;
         }
         if(!this._labelTimer.running || param2 > this._repairTime)
         {
            this._repairTime = param2;
            this._labelTimer.reset();
            if(!this._needsShowWarning)
            {
               this._labelTimer.delay = LABEL_UPDATE_TIME * (1 / this._playbackSpeed);
               this._labelTimer.start();
            }
         }
         else
         {
            this._repairTime = Math.min(_loc8_ * _loc7_,this._repairTime);
         }
         invalidate(REPAIRING_PROGRESS_INVALID_MASK);
      }
      
      public function setRepairTimeVisible(param1:Boolean) : void
      {
         this._showRepairTimer = param1;
      }
      
      private function repairFullAnimEndHandler() : void
      {
         this.dispatchRepairAnimComplete();
      }
      
      private function repairAnimEndHandler() : void
      {
         this.dispatchRepairAnimComplete();
      }
      
      private function repairFullAnimHideHandler() : void
      {
         dispatchEvent(new RepairAnimEvent(RepairAnimEvent.ANIM_HIDE));
      }
      
      private function dispatchRepairAnimComplete() : void
      {
         this._repairPercents = 0;
         this._needsApplyLocalPercents = false;
         dispatchEvent(new RepairAnimEvent(RepairAnimEvent.ANIM_COMPLETE));
      }
      
      private function currentRepairFrame(param1:int) : int
      {
         return FIRST_FRAME_REPAIR_ANIM + param1 * REPAIR_ANIM_COUNT_FRAMES / PERCENTS_100 | 0;
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
         setStateManually(param1);
         this.setRepairing(false);
         this._animationTimer.stop();
         this._labelTimer.stop();
      }
      
      private function onAnimationTimerHandler(param1:TimerEvent) : void
      {
         this._repairPercents = PERCENTS_100 * (getTimer() - this._startTime) / this._animDuration;
         invalidate(REPAIRING_PROGRESS_INVALID_MASK);
      }
      
      private function onLabelTimerHandler(param1:TimerEvent) : void
      {
         this._repairTime -= LABEL_UPDATE_TIME;
         this._repairTime = Math.max(this._repairTime,0);
         var _loc2_:String = (this._repairTime * this._playbackSpeed / Time.MILLISECOND_IN_SECOND).toFixed(1);
         if(this._needsHighlightText)
         {
            this.highlightRepairTimeTF.text = _loc2_;
         }
         else
         {
            this.repairTimeTF.text = _loc2_;
         }
         this.updateElementsVisibility();
      }
      
      private function updateElementsVisibility() : void
      {
         var _loc1_:Boolean = this._showRepairTimer && this._isRepairing;
         var _loc2_:Boolean = _loc1_ && !this._needsShowWarning;
         this.highlightRepairTimeTF.visible = _loc2_ && this._needsHighlightText;
         this.repairTimeTF.visible = _loc2_ && !this._needsHighlightText;
         this.warningMc.visible = _loc1_ && this._needsShowWarning;
      }
      
      private function onAnimationTimerCompleteHandler(param1:TimerEvent = null) : void
      {
         this.setRepairing(false);
      }
   }
}
