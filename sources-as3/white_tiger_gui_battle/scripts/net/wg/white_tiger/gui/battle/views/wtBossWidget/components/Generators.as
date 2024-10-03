package net.wg.white_tiger.gui.battle.views.wtBossWidget.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.utils.IScheduler;
   import net.wg.white_tiger.gui.battle.views.wtBossWidget.BossWidget;
   
   public class Generators extends BattleUIComponent
   {
      
      private static const GENERATOR_CHILD_NAME_PREFIX:String = "generator";
      
      private static const GENERATORS_TOTAL_COUNT:int = 4;
      
      private static const GENERATOR_MAX_PROGRESS:uint = 100;
      
      private static const GENERATOR_PROGRESS_MULTIPLIER:uint = 3;
      
      private static const INVALIDATE_CHARGING:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALIDATE_GENERATORS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALIDATE_DEBUFF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const INVALIDATE_BATTERY_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const STATE_OFF:String = "state_off";
      
      private static const STATE_SHOW:String = "state_show";
      
      private static const STATE_HIDE_BATTERY:String = "state_hide_battery";
      
      private static const FRAME_ANIM_START:String = "start";
      
      private static const FRAME_ANIM_SHOW:String = "show";
      
      private static const FRAME_ANIM_HIDE:String = "hide";
      
      private static const FRAME_SHOW_TIMER:int = 13;
      
      private static const FRAME_CHANGE_TO_HIDE_ICON:int = 29;
      
      private static const GENERATOR_ICON_DESTROYED:String = "destroyed";
      
      private static const GENERATOR_ICON_ON:String = "on";
      
      private static const GENERATOR_ICON_ON50:String = "on50";
      
      private static const GENERATOR_ICON_DEBUFF:String = "debuff";
      
      private static const DELAY_GENERATOR_SHOW:int = 200;
      
      private static const DELAY_SHOW_BATTERY:int = 1000;
      
      private static const DELAY_CHANGE_GENERATORS_STATE_ON:int = 320;
      
      private static const DELAY_CHANGE_GENERATOR_STATE_ON:int = 120;
       
      
      public var batteryProgress:ProgressBar = null;
      
      public var timerTF:TextFieldContainer = null;
      
      public var batteryBg:Sprite = null;
      
      public var bg:MovieClip = null;
      
      public var generatorsActiveAnimation:MovieClip = null;
      
      private var _isDebuff:Boolean = false;
      
      private var _availableGenerators:int = -1;
      
      private var _isAvailableGeneratorsDown:int = 0;
      
      private var _chargingRemainingTime:int = 0;
      
      private var _chargingTotalTime:int = 0;
      
      private var _isBatteryVisible:Boolean = false;
      
      private var _isChargingAnimationShowed:Boolean = false;
      
      private var _isChargingAnimationInProgress:Boolean = false;
      
      private var _isDebuffAnimationInProgress:Boolean = false;
      
      private var _debuffHideGeneratorIdx:int = -1;
      
      private var _currentGeneratorCount:int = 0;
      
      private var _scheduler:IScheduler;
      
      private var _isInited:Boolean = false;
      
      public function Generators()
      {
         this._scheduler = App.utils.scheduler;
         super();
         gotoAndStop(STATE_OFF);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addFrameScript(FRAME_SHOW_TIMER - 1,this.playTimerSound);
      }
      
      override protected function onDispose() : void
      {
         this.addFrameScript(FRAME_SHOW_TIMER - 1,null);
         this._scheduler.cancelTask(this.startChangeGeneratorsOn);
         this._scheduler.cancelTask(this.showGenerator);
         this._scheduler.cancelTask(this.showBattery);
         this._scheduler.cancelTask(this.changeGeneratorOn);
         this._scheduler.cancelTask(this.startShowDestroyGenerator);
         this._scheduler = null;
         this.batteryProgress.dispose();
         this.batteryProgress = null;
         this.timerTF.dispose();
         this.timerTF = null;
         this.batteryBg = null;
         this.bg = null;
         this.generatorsActiveAnimation = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._isInited)
         {
            return;
         }
         var _loc1_:Boolean = isInvalid(INVALIDATE_DEBUFF);
         var _loc2_:Boolean = isInvalid(INVALIDATE_GENERATORS);
         var _loc3_:Boolean = isInvalid(INVALIDATE_CHARGING);
         var _loc4_:Boolean = isInvalid(INVALIDATE_BATTERY_VISIBILITY);
         if(_loc2_ && !this._isChargingAnimationInProgress && !this._isChargingAnimationShowed && this._isAvailableGeneratorsDown > Values.ZERO)
         {
            this._isChargingAnimationInProgress = true;
            this._isAvailableGeneratorsDown = Values.ZERO;
            this.startShowAnimation();
         }
         if(_loc3_ && this._isBatteryVisible)
         {
            this.timerTF.label = App.utils.dateTime.formatSecondsToString(this._chargingRemainingTime);
            this.batteryProgress.value = GENERATOR_PROGRESS_MULTIPLIER * (GENERATOR_MAX_PROGRESS - ProgressBar.getProgress(this._chargingTotalTime,this._chargingRemainingTime));
            if(!_loc4_)
            {
               this.setBatteryVisibility(this._isBatteryVisible);
            }
         }
         if(_loc1_ && !this._isDebuff && !this._isDebuffAnimationInProgress && !this._isChargingAnimationInProgress)
         {
            this._currentGeneratorCount = GENERATORS_TOTAL_COUNT - 1;
            this._scheduler.scheduleTask(this.startChangeGeneratorsOn,DELAY_CHANGE_GENERATORS_STATE_ON);
         }
         if(_loc4_)
         {
            if(!this._isBatteryVisible && _loc3_)
            {
               this.showHideBatteryAnimation();
            }
            if(this._isBatteryVisible && !this._isChargingAnimationInProgress && this._availableGenerators > Values.DEFAULT_INT)
            {
               this._isChargingAnimationInProgress = true;
               this._scheduler.scheduleTask(this.showBattery,DELAY_SHOW_BATTERY);
            }
         }
         if(_loc2_ || _loc1_)
         {
            if(this._isDebuff && !this._isDebuffAnimationInProgress && !this._isChargingAnimationInProgress && this._availableGenerators > Values.DEFAULT_INT)
            {
               this._isDebuffAnimationInProgress = true;
               this._scheduler.scheduleTask(this.startShowDestroyGenerator,DELAY_GENERATOR_SHOW);
            }
         }
      }
      
      public function updateCharging(param1:int, param2:int) : void
      {
         if(this._chargingTotalTime == param1 && this._chargingRemainingTime == param2)
         {
            return;
         }
         if(!this._isInited)
         {
            this._isInited = true;
         }
         if(this._chargingRemainingTime > 0 && param2 <= 0)
         {
            BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_GENERATORS_ACTIVE_SHOW);
         }
         this._chargingTotalTime = param1;
         this._chargingRemainingTime = param2;
         this.isBatteryVisible = param2 > 0;
         invalidate(INVALIDATE_CHARGING);
      }
      
      private function showHideBatteryAnimation() : void
      {
         this.gotoAndStop(STATE_HIDE_BATTERY);
         this._currentGeneratorCount = GENERATORS_TOTAL_COUNT - 1;
         this._scheduler.scheduleTask(this.startChangeGeneratorsOn,DELAY_CHANGE_GENERATORS_STATE_ON);
         this.generatorsActiveAnimation.gotoAndPlay(FRAME_ANIM_START);
      }
      
      private function startShowAnimation() : void
      {
         this.bg.gotoAndPlay(FRAME_ANIM_START);
         BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_GENERATORS_SHOW);
         this._currentGeneratorCount = 0;
         this._scheduler.scheduleRepeatableTask(this.showGenerator,DELAY_GENERATOR_SHOW,GENERATORS_TOTAL_COUNT);
         this._scheduler.scheduleTask(this.showBattery,DELAY_SHOW_BATTERY);
      }
      
      private function showGenerator() : void
      {
         var _loc1_:MovieClip = this.getGeneratorById(this._currentGeneratorCount);
         if(_loc1_ != null)
         {
            this.updateGenerator(this._currentGeneratorCount);
            _loc1_.gotoAndPlay(FRAME_ANIM_SHOW);
            BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_GENERATOR_SHOW);
         }
         ++this._currentGeneratorCount;
      }
      
      private function showBattery() : void
      {
         if(this._isBatteryVisible)
         {
            this.gotoAndPlay(STATE_SHOW);
            BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_TIME_SHOW);
         }
         else
         {
            this._isChargingAnimationInProgress = false;
            this.gotoAndStop(STATE_HIDE_BATTERY);
         }
      }
      
      private function playTimerSound() : void
      {
         BossWidget.playSound(SoundTypes.WT_EVENT_BOSS_TIME_TICK_SHOW);
      }
      
      private function startChangeGeneratorsOn() : void
      {
         this.changeGeneratorOn();
         this._scheduler.scheduleRepeatableTask(this.changeGeneratorOn,DELAY_CHANGE_GENERATOR_STATE_ON,GENERATORS_TOTAL_COUNT);
      }
      
      private function changeGeneratorOn() : void
      {
         if(this._currentGeneratorCount > -1)
         {
            this.updateGenerator(this._currentGeneratorCount);
            --this._currentGeneratorCount;
         }
         else
         {
            this._isChargingAnimationInProgress = false;
            this._isChargingAnimationShowed = true;
         }
      }
      
      private function startShowDestroyGenerator() : void
      {
         var _loc1_:MovieClip = this.getGeneratorById(this._availableGenerators);
         if(_loc1_ != null)
         {
            this._debuffHideGeneratorIdx = this._availableGenerators;
            _loc1_.addFrameScript(FRAME_CHANGE_TO_HIDE_ICON - 1,this.changeIcon);
            _loc1_.gotoAndPlay(FRAME_ANIM_HIDE);
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._availableGenerators)
         {
            this.updateGenerator(_loc2_);
            _loc2_++;
         }
      }
      
      private function getGeneratorById(param1:int) : MovieClip
      {
         if(param1 > -1 && param1 < GENERATORS_TOTAL_COUNT)
         {
            return MovieClip(this[GENERATOR_CHILD_NAME_PREFIX + param1]);
         }
         return null;
      }
      
      private function changeIcon() : void
      {
         var _loc1_:MovieClip = this.getGeneratorById(this._debuffHideGeneratorIdx);
         if(_loc1_ != null)
         {
            _loc1_.addFrameScript(FRAME_CHANGE_TO_HIDE_ICON - 1,null);
            _loc1_.icon.gotoAndStop(GENERATOR_ICON_DESTROYED);
         }
         this._debuffHideGeneratorIdx = Values.DEFAULT_INT;
         this._isDebuffAnimationInProgress = false;
      }
      
      private function updateGenerator(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = param1 < this._availableGenerators;
         if(_loc2_)
         {
            if(this._isDebuff)
            {
               _loc3_ = GENERATOR_ICON_DEBUFF;
            }
            else if(this._chargingRemainingTime > 0)
            {
               _loc3_ = GENERATOR_ICON_ON50;
            }
            else
            {
               _loc3_ = GENERATOR_ICON_ON;
            }
         }
         else
         {
            _loc3_ = GENERATOR_ICON_DESTROYED;
         }
         var _loc4_:MovieClip = this.getGeneratorById(param1);
         if(_loc4_ != null)
         {
            _loc4_.icon.gotoAndStop(_loc3_);
         }
      }
      
      private function setBatteryVisibility(param1:Boolean) : void
      {
         this.batteryProgress.visible = this.batteryBg.visible = this.timerTF.visible = param1;
      }
      
      public function set isDebuff(param1:Boolean) : void
      {
         if(this._isDebuff == param1)
         {
            return;
         }
         if(!this._isInited)
         {
            this._isInited = true;
         }
         this._isDebuff = param1;
         invalidate(INVALIDATE_DEBUFF);
      }
      
      public function set availableGenerators(param1:int) : void
      {
         if(this._availableGenerators == param1)
         {
            return;
         }
         if(!this._isInited)
         {
            this._isInited = true;
         }
         this._isAvailableGeneratorsDown = param1 > this._availableGenerators ? int(1) : int(-1);
         this._availableGenerators = param1;
         if(this._availableGenerators == 0)
         {
            this.isDebuff = true;
         }
         invalidate(INVALIDATE_GENERATORS);
      }
      
      private function set isBatteryVisible(param1:Boolean) : void
      {
         if(this._isBatteryVisible == param1)
         {
            return;
         }
         this._isBatteryVisible = param1;
         invalidate(INVALIDATE_BATTERY_VISIBILITY);
      }
   }
}
