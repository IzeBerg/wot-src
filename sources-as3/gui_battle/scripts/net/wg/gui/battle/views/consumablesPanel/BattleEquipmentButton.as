package net.wg.gui.battle.views.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ANIMATION_TYPES;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.CoolDownTimer;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleEquipmentButtonGlow;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.utils.IScheduler;
   
   public class BattleEquipmentButton extends BattleToolTipButton implements IConsumablesButton, ICoolDownCompleteHandler
   {
      
      protected static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const COOLDOWN_COUNTER_BG_RED:String = "red";
      
      private static const COOLDOWN_COUNTER_BG_GREEN:String = "green";
      
      private static const COOLDOWN_COUNTER_BG_HIDE:String = "hide";
      
      private static const COOLDOWN_START_FRAME:int = 1;
      
      private static const COOLDOWN_END_FRAME:int = 49;
      
      private static const COOLDOWN_FRAME_COUNT:int = COOLDOWN_END_FRAME - COOLDOWN_START_FRAME;
      
      private static const DEFAULT_TIME_COEF:int = 1;
      
      private static const INTERVAL_SIZE:int = 1000;
      
      private static const SMALL_INTERVAL_SIZE:int = 100;
      
      private static const INTERVALS_RATIO:int = INTERVAL_SIZE / SMALL_INTERVAL_SIZE;
      
      private static const COOLDOWN_TEXT_COLOR:uint = 16768409;
      
      private static const NORMAL_TEXT_COLOR:uint = 11854471;
      
      private static const GREEN_GLOW_MC_SHOW:String = "show";
      
      private static const GREEN_GLOW_MC_HIDE:String = "hide";
       
      
      public var iconLoader:UILoaderAlt = null;
      
      public var hit:MovieClip = null;
      
      public var consumableBackground:MovieClip = null;
      
      public var glow:IBattleEquipmentButtonGlow = null;
      
      public var cooldownTimerTf:TextField = null;
      
      public var counterBg:MovieClip = null;
      
      public var cooldownMc:MovieClip = null;
      
      public var bigCooldownTimerTf:TextField = null;
      
      public var greenGlowMc:MovieClip = null;
      
      protected var isActivated:Boolean;
      
      private var _isReplay:Boolean;
      
      private var _lockColorTransform:Boolean = false;
      
      private var _isPermanent:Boolean;
      
      private var _bindSfKeyCode:Number;
      
      private var _isEmpty:Boolean;
      
      private var _delayColorTransform:ColorTransform = null;
      
      private var _consumablesVO:ConsumablesVO = null;
      
      private var _isReloading:Boolean = false;
      
      private var _coolDownTimer:CoolDownTimer = null;
      
      private var _currentIntervalTime:int;
      
      private var _baseTime:int = 0;
      
      private var _firstShow:Boolean = true;
      
      private var _isBaseTimeSnapshot:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _prevAnimation:int = 0;
      
      private var _currentPercent:Number = 0;
      
      private var _currReloadingInPercent:Number = 0;
      
      private var _curAnimReversed:Boolean = false;
      
      private var _useBigTimer:Boolean = false;
      
      private var _isFillPartially:Boolean = false;
      
      public function BattleEquipmentButton()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this.greenGlowMc.visible = false;
         this.cooldownMc.visible = false;
         this._coolDownTimer = new CoolDownTimer(this.cooldownMc);
         this._coolDownTimer.setFrames(COOLDOWN_START_FRAME,COOLDOWN_END_FRAME);
         isAllowedToShowToolTipOnDisabledState = true;
         hideToolTipOnClickActions = false;
         this._consumablesVO = new ConsumablesVO();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hit.mouseEnabled = false;
         hitArea = this.hit;
         this.consumableBackground.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(KEY_VALIDATION))
         {
            this.setBindKeyText();
         }
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.onIntervalEnd);
         this._scheduler.cancelTask(this.intervalRun);
         this._scheduler = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.glow.dispose();
         this.glow = null;
         this.cooldownTimerTf = null;
         this.bigCooldownTimerTf = null;
         this.counterBg = null;
         this.cooldownMc = null;
         this.greenGlowMc = null;
         this.consumableBackground = null;
         this.hit = null;
         this._consumablesVO = null;
         this._coolDownTimer.dispose();
         this._coolDownTimer = null;
         this._delayColorTransform = null;
         super.onDispose();
      }
      
      override protected function getFrameLabel(param1:String) : String
      {
         return !!this._isReloading ? BATTLE_ITEM_STATES.COOLDOWN : param1;
      }
      
      public function clearColorTransform() : void
      {
         if(this._isReloading)
         {
            return;
         }
         this._delayColorTransform = null;
         if(this._lockColorTransform)
         {
            return;
         }
         this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
      }
      
      public function clearCoolDownTime() : void
      {
         this.isActivated = false;
         this.endCooldownTimer();
         this._isReloading = false;
         this.state = InteractiveStates.UP;
         if(this._baseTime > 0)
         {
            if(!this._firstShow)
            {
               this.cooldownTimerTf.text = this._baseTime.toString();
            }
         }
         else
         {
            this.clearCoolDownText();
         }
      }
      
      public function flushColorTransform() : void
      {
         this._lockColorTransform = this._isEmpty;
         if(this._delayColorTransform)
         {
            if(!this._lockColorTransform)
            {
               this.setColorTransform(this._delayColorTransform);
               this._delayColorTransform = null;
            }
         }
         else
         {
            this.clearColorTransform();
         }
      }
      
      public function hideGlow() : void
      {
         this.glow.hideGlow();
      }
      
      public function onCoolDownComplete() : void
      {
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         if(this._lockColorTransform)
         {
            this._delayColorTransform = param1;
            return;
         }
         if(param1)
         {
            this.iconLoader.transform.colorTransform = param1;
         }
      }
      
      public function setCoolDownPosAsPercent(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         this._currentPercent = param1;
         if(param1 < 100)
         {
            _loc2_ = !!this._curAnimReversed ? Number(100 - this._currentPercent) : Number(this._currentPercent);
            if(this._isFillPartially)
            {
               _loc2_ -= 100 * this._currReloadingInPercent;
            }
            this._coolDownTimer.setPositionAsPercent(_loc2_);
         }
         else if(!this._isReplay)
         {
            this.setCoolDownTime(0,this._baseTime,0);
         }
      }
      
      public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         var _loc5_:int = 0;
         this.isActivated = false;
         this._isPermanent = false;
         this._baseTime = param2;
         this.greenGlowMc.visible = false;
         this.bigCooldownTimerTf.visible = false;
         this.endCooldownTimer();
         this.enableMouse();
         this._scheduler.cancelTask(this.intervalRun);
         this._scheduler.cancelTask(this.onIntervalEnd);
         if(param1 > 0)
         {
            this.updateStateBeforeCooldown();
            this.state = BATTLE_ITEM_STATES.COOLDOWN;
            this._firstShow = false;
            this._isReloading = true;
            this.cooldownMc.visible = false;
            this._curAnimReversed = false;
            if((param4 & ANIMATION_TYPES.MOVE_GREEN_BAR_DOWN) > 0)
            {
               this.cooldownMc.transform.colorTransform = COLOR_STATES.GREEN_COOLDOWN_COLOR_TRANSFORM;
               this._currReloadingInPercent = param1 / param2;
               this._curAnimReversed = true;
            }
            else if((param4 & ANIMATION_TYPES.MOVE_GREEN_BAR_UP) > 0)
            {
               this.cooldownMc.transform.colorTransform = COLOR_STATES.GREEN_COOLDOWN_COLOR_TRANSFORM;
               this._currReloadingInPercent = param3 / param2;
            }
            else if((param4 & ANIMATION_TYPES.MOVE_ORANGE_BAR_DOWN) > 0)
            {
               this.cooldownMc.transform.colorTransform = COLOR_STATES.ORANGE_COOLDOWN_COLOR_TRANSFORM;
               this._currReloadingInPercent = param1 / param2;
               this._curAnimReversed = true;
            }
            else if((param4 & ANIMATION_TYPES.MOVE_ORANGE_BAR_UP) > 0)
            {
               this.cooldownMc.transform.colorTransform = COLOR_STATES.ORANGE_COOLDOWN_COLOR_TRANSFORM;
               this._currReloadingInPercent = param3 / param2;
            }
            this._isFillPartially = false;
            if((param4 & ANIMATION_TYPES.FILL_PARTIALLY) > 0)
            {
               param3 = 0;
               this._isFillPartially = true;
            }
            this._currentIntervalTime = param2 - param3;
            this._useBigTimer = (param4 & ANIMATION_TYPES.CENTER_COUNTER) > 0;
            this.cooldownTimerTf.visible = this.counterBg.visible = !this._useBigTimer;
            if(this._useBigTimer)
            {
               this.bigCooldownTimerTf.visible = true;
               this._currentIntervalTime *= INTERVALS_RATIO;
               param2 *= INTERVALS_RATIO;
            }
            this._currentIntervalTime += 1;
            if((param4 & ANIMATION_TYPES.SHOW_COUNTER_GREEN) > 0)
            {
               this.cooldownTimerTf.textColor = NORMAL_TEXT_COLOR;
               this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_GREEN);
            }
            else if((param4 & ANIMATION_TYPES.SHOW_COUNTER_ORANGE) > 0)
            {
               this.cooldownTimerTf.textColor = COOLDOWN_TEXT_COLOR;
               this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_RED);
            }
            if((param4 & ANIMATION_TYPES.GREEN_GLOW_SHOW) > 0)
            {
               this.greenGlowMc.visible = true;
               if(this._prevAnimation != param4)
               {
                  this.greenGlowMc.gotoAndPlay(GREEN_GLOW_MC_SHOW);
               }
            }
            else if((param4 & ANIMATION_TYPES.GREEN_GLOW_HIDE) > 0)
            {
               this.greenGlowMc.visible = true;
               if(this._prevAnimation != param4)
               {
                  this.greenGlowMc.gotoAndPlay(GREEN_GLOW_MC_HIDE);
               }
            }
            this._prevAnimation = param4;
            this._lockColorTransform = false;
            if((param4 & ANIMATION_TYPES.DARK_COLOR_TRANSFORM) > 0)
            {
               this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
               this._delayColorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
            }
            else
            {
               this.clearColorTransform();
            }
            this._lockColorTransform = true;
            this.cooldownMc.visible = true;
            this.intervalRun(this._useBigTimer);
            if(!this._isReplay)
            {
               _loc5_ = !!this._useBigTimer ? int(SMALL_INTERVAL_SIZE) : int(INTERVAL_SIZE);
               this.startCooldownTimer(param1,this._currReloadingInPercent,this._curAnimReversed,this._isFillPartially);
               this.disableMouse();
               this._scheduler.scheduleRepeatableTask(this.intervalRun,_loc5_,param2,this._useBigTimer);
            }
         }
         else
         {
            this._isReloading = false;
            this._delayColorTransform = null;
            this.flushColorTransform();
            this.enableMouse();
            this.cooldownTimerTf.textColor = NORMAL_TEXT_COLOR;
            this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_GREEN);
            if(param2 > 0)
            {
               this.cooldownTimerTf.text = param2.toString();
            }
            if(param1 == -1)
            {
               this.clearCoolDownText();
               this._isPermanent = true;
               super.state = BATTLE_ITEM_STATES.PERMANENT;
            }
            else if(param1 == 0)
            {
               this.clearCoolDownTime();
               this.clearCoolDownText();
            }
         }
      }
      
      public function setTimerSnapshot(param1:int, param2:Boolean) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._useBigTimer)
         {
            _loc3_ = (!!this._curAnimReversed ? 100 - this._currentPercent : this._currentPercent) / 100;
            _loc4_ = _loc3_ * this._baseTime;
            this.bigCooldownTimerTf.text = _loc4_.toFixed(_loc4_ < 10);
         }
         else if(param1 > 0)
         {
            if(this._isFillPartially)
            {
               this.cooldownTimerTf.text = (this._baseTime - this._baseTime * (1 - this._currReloadingInPercent) + param1).toString();
            }
            else
            {
               this.cooldownTimerTf.text = param1.toString();
            }
            if(this._isBaseTimeSnapshot != param2)
            {
               this._isBaseTimeSnapshot = param2;
               if(param2)
               {
                  this.cooldownTimerTf.textColor = NORMAL_TEXT_COLOR;
                  this.clearColorTransform();
               }
               else
               {
                  this.cooldownTimerTf.textColor = COOLDOWN_TEXT_COLOR;
                  this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
               }
            }
         }
      }
      
      public function showGlow(param1:int) : void
      {
         if(this._isReloading || !enabled)
         {
            return;
         }
         this.glow.showGlow(param1);
      }
      
      public function updateLevelInformation(param1:int) : void
      {
      }
      
      public function updateLockedInformation(param1:int, param2:String) : void
      {
      }
      
      protected function setBindKeyText() : void
      {
         if(this._bindSfKeyCode == KeyProps.KEY_NONE)
         {
            this.glow.setBindKeyText(App.utils.locale.makeString(READABLE_KEY_NAMES.KEY_NONE_ALT));
         }
         else
         {
            this.glow.setBindKeyText(App.utils.commons.keyToString(this._bindSfKeyCode).keyName);
         }
      }
      
      public function setStage(param1:int) : void
      {
      }
      
      protected function updateStateBeforeCooldown() : void
      {
      }
      
      protected function enableMouse() : void
      {
         if(enabled)
         {
            buttonMode = true;
         }
      }
      
      protected function disableMouse() : void
      {
         buttonMode = false;
      }
      
      private function intervalRun(param1:Boolean) : void
      {
         this._currentIntervalTime -= 1;
         if(param1)
         {
            this.bigCooldownTimerTf.text = (this._currentIntervalTime / INTERVALS_RATIO).toFixed(this._currentIntervalTime < 100);
         }
         else
         {
            this.cooldownTimerTf.text = this._currentIntervalTime.toString();
         }
         if(!this._currentIntervalTime)
         {
            this._scheduler.scheduleTask(this.onIntervalEnd,!!this._useBigTimer ? Number(SMALL_INTERVAL_SIZE) : Number(INTERVAL_SIZE));
         }
      }
      
      private function onIntervalEnd() : void
      {
         this.enableMouse();
         this.endCooldownTimer();
         this.clearCoolDownText();
      }
      
      private function endCooldownTimer() : void
      {
         if(this._coolDownTimer)
         {
            this._coolDownTimer.end();
         }
         if(this.cooldownMc)
         {
            this.cooldownMc.visible = false;
         }
      }
      
      private function startCooldownTimer(param1:Number, param2:Number, param3:Boolean, param4:Boolean = false) : void
      {
         this._coolDownTimer.start(param1,this,Math.round(COOLDOWN_FRAME_COUNT * param2),DEFAULT_TIME_COEF,param3,param4);
      }
      
      protected function clearCoolDownText() : void
      {
         this.cooldownTimerTf.text = Values.EMPTY_STR;
         this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_HIDE);
      }
      
      override public function set state(param1:String) : void
      {
         if(!this._isPermanent && !this.isActivated)
         {
            super.state = param1;
         }
      }
      
      public function set activated(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         this.state = BATTLE_ITEM_STATES.RELOADED;
         this.isActivated = true;
      }
      
      public function get consumablesVO() : ConsumablesVO
      {
         return this._consumablesVO;
      }
      
      public function get icon() : String
      {
         return this.iconLoader.source;
      }
      
      public function set icon(param1:String) : void
      {
         this.iconLoader.source = param1;
      }
      
      public function set quantity(param1:int) : void
      {
         this.empty = param1 == 0;
      }
      
      public function get bindSfKeyCode() : Number
      {
         return this._bindSfKeyCode;
      }
      
      public function set key(param1:Number) : void
      {
         if(this._bindSfKeyCode == param1)
         {
            return;
         }
         this._bindSfKeyCode = param1;
         invalidate(KEY_VALIDATION);
      }
      
      public function get empty() : Boolean
      {
         return this._isEmpty;
      }
      
      public function set empty(param1:Boolean) : void
      {
         if(this._isEmpty == param1)
         {
            return;
         }
         this._isEmpty = param1;
         enabled = !param1;
         if(param1)
         {
            this.state = InteractiveStates.EMPTY_UP;
            if(this.icon)
            {
               this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
               this._lockColorTransform = true;
            }
         }
         else
         {
            this.state = InteractiveStates.UP;
            if(this.icon)
            {
               this.flushColorTransform();
            }
         }
      }
      
      public function get showConsumableBorder() : Boolean
      {
         return this.consumableBackground.visible;
      }
      
      public function set showConsumableBorder(param1:Boolean) : void
      {
         this.consumableBackground.visible = param1;
      }
      
      public function set isReplay(param1:Boolean) : void
      {
         this._isReplay = param1;
      }
      
      protected function get isReloading() : Boolean
      {
         return this._isReloading;
      }
      
      protected function get cooldownTimer() : CoolDownTimer
      {
         return this._coolDownTimer;
      }
   }
}
