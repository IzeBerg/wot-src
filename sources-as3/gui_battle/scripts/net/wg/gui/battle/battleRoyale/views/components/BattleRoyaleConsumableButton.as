package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Time;
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
   import scaleform.gfx.TextFieldEx;
   
   public class BattleRoyaleConsumableButton extends BattleToolTipButton implements IConsumablesButton, ICoolDownCompleteHandler
   {
      
      private static const ORANGE_COOLDOWN_START_FRAME:uint = 1;
      
      private static const ORANGE_COOLDOWN_END_FRAME:uint = 49;
      
      private static const GREEN_COOLDOWN_START_FRAME:uint = 50;
      
      private static const GREEN_COOLDOWN_END_FRAME:uint = 98;
      
      private static const GRAY_COOLDOWN_START_FRAME:uint = 99;
      
      private static const GRAY_COOLDOWN_END_FRAME:uint = 147;
      
      private static const TOTAL_COOLDOWN_FRAMES:uint = 48;
      
      private static const KEY_VALIDATION_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const GLOW_VALIDATION_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const ACTIVATED_VALIDATION_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const STATUS_VALIDATION_FLAG:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const STATUS_AVAILABLE:uint = 0;
      
      private static const EMPTY_FLAG:uint = 1;
      
      private static const IN_USE_FLAG:uint = 2;
      
      private static const COOLDOWN_FLAG:uint = 4;
      
      private static const COOLDOWN_INTERVAL:uint = Time.MILLISECOND_IN_SECOND;
      
      private static const ORANGE_COOLDOWN_TEXT_COLOR:uint = 16768409;
      
      private static const GREEN_COOLDOWN_TEXT_COLOR:uint = 14548889;
      
      private static const EMPTY_SATURATION:int = 0;
      
      private static const EMPTY_ALPHA:Number = 0.5;
       
      
      public var hit:Sprite = null;
      
      public var itemQuantityTf:TextField = null;
      
      public var cooldownTimerTf:TextField = null;
      
      public var iconLoader:UILoaderAlt = null;
      
      public var cooldownMc:MovieClip = null;
      
      public var glow:IBattleEquipmentButtonGlow = null;
      
      public var activatedIndicator:MovieClip = null;
      
      private var _quantity:int = -1;
      
      private var _cooldown:uint = 0;
      
      private var _cooldownTimer:CoolDownTimer = null;
      
      private var _consumablesVo:ConsumablesVO = null;
      
      private var _bindSfKeyCode:Number = 777;
      
      private var _statusMask:uint = 0;
      
      private var _glowId:int = 0;
      
      private var _showGlow:Boolean = false;
      
      private var _scheduler:IScheduler;
      
      private var _isActivated:Boolean = false;
      
      private var _isReplay:Boolean = false;
      
      private var _emptyFilters:Array = null;
      
      public function BattleRoyaleConsumableButton()
      {
         this._scheduler = App.utils.scheduler;
         super();
         App.utils.commons.setSaturation(this.iconLoader,EMPTY_SATURATION);
         this._emptyFilters = this.iconLoader.filters;
         this.iconLoader.filters = [];
         this._cooldownTimer = new CoolDownTimer(this.cooldownMc);
         this._cooldownTimer.setFrames(ORANGE_COOLDOWN_START_FRAME,ORANGE_COOLDOWN_END_FRAME);
         this._consumablesVo = new ConsumablesVO();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         isAllowedToShowToolTipOnDisabledState = true;
         TextFieldEx.setNoTranslate(this.itemQuantityTf,true);
         TextFieldEx.setNoTranslate(this.cooldownTimerTf,true);
         this.activatedIndicator.visible = false;
         this.cooldownTimerTf.visible = false;
         this.cooldownMc.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         super.draw();
         if(isInvalid(STATUS_VALIDATION_FLAG))
         {
            if(this.isCooldown)
            {
               this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
               this.cooldownMc.visible = true;
               if(this.isInUse)
               {
                  this.cooldownTimerTf.visible = true;
                  this._cooldownTimer.setFrames(GREEN_COOLDOWN_START_FRAME,GREEN_COOLDOWN_END_FRAME);
               }
               else if(this.isEmpty)
               {
                  this.cooldownTimerTf.visible = false;
                  this._cooldownTimer.setFrames(GRAY_COOLDOWN_START_FRAME,GRAY_COOLDOWN_END_FRAME);
               }
               else
               {
                  this.cooldownTimerTf.visible = true;
                  this._cooldownTimer.setFrames(ORANGE_COOLDOWN_START_FRAME,ORANGE_COOLDOWN_END_FRAME);
               }
               this._cooldownTimer.moveToFrame(this._cooldownTimer.currentFrame);
            }
            else
            {
               this.clearColorTransform();
               this.cooldownTimerTf.visible = this.cooldownMc.visible = false;
            }
            if(this.isEmpty && !this.isInUse)
            {
               this.iconLoader.filters = this._emptyFilters;
               this.iconLoader.alpha = EMPTY_ALPHA;
            }
            else
            {
               this.iconLoader.filters = [];
               this.iconLoader.alpha = 1;
            }
            this.itemQuantityTf.visible = this.isAvailable;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.itemQuantityTf.text = this._quantity > 0 ? this._quantity.toString() : Values.EMPTY_STR;
            if(this.isCooldown)
            {
               _loc1_ = Math.LN10 * Math.log(Time.MILLISECOND_IN_SECOND / COOLDOWN_INTERVAL);
               _loc2_ = this._cooldown / Time.MILLISECOND_IN_SECOND;
               this.cooldownTimerTf.text = _loc2_.toFixed(_loc1_);
            }
         }
         if(isInvalid(GLOW_VALIDATION_FLAG))
         {
            if(this._showGlow)
            {
               this.glow.showGlow(this._glowId);
               this._showGlow = false;
            }
            else
            {
               this.glow.hideGlow();
            }
         }
         if(isInvalid(ACTIVATED_VALIDATION_FLAG))
         {
            this.activatedIndicator.visible = this._isActivated;
            if(this._isActivated)
            {
               this.activatedIndicator.gotoAndPlay(BATTLE_ITEM_STATES.SHOW);
            }
         }
         if(isInvalid(KEY_VALIDATION_FLAG))
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
      }
      
      override protected function onDispose() : void
      {
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.glow.dispose();
         this.glow = null;
         this.activatedIndicator = null;
         this.cooldownTimerTf = null;
         this.itemQuantityTf = null;
         this.cooldownMc = null;
         this.hit = null;
         this._consumablesVo = null;
         this._scheduler.cancelTask(this.onCooldownTick);
         this._scheduler.cancelTask(this.clearCoolDownTime);
         this._scheduler = null;
         this._cooldownTimer.dispose();
         this._cooldownTimer = null;
         this._emptyFilters.length = 0;
         this._emptyFilters = null;
         super.onDispose();
      }
      
      override protected function invokeEnableActions() : void
      {
         super.state = InteractiveStates.UP;
         buttonMode = true;
      }
      
      override protected function invokeDisableActions() : void
      {
         super.state = InteractiveStates.DISABLED;
         buttonMode = false;
         this.activated = false;
      }
      
      public function clearColorTransform() : void
      {
         this.iconLoader.transform.colorTransform = null;
      }
      
      public function clearCoolDownTime() : void
      {
         this._cooldown = 0;
         this.status &= ~(COOLDOWN_FLAG | IN_USE_FLAG);
         if(!this._isReplay)
         {
            this._scheduler.cancelTask(this.clearCoolDownTime);
            this._scheduler.cancelTask(this.onCooldownTick);
            this._cooldownTimer.end();
         }
      }
      
      public function hideGlow() : void
      {
         this._showGlow = false;
         invalidate(GLOW_VALIDATION_FLAG);
      }
      
      public function onCoolDownComplete() : void
      {
         this.clearCoolDownTime();
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         this.iconLoader.transform.colorTransform = param1;
      }
      
      public function setCoolDownPosAsPercent(param1:Number) : void
      {
         if(param1 < 100)
         {
            this._cooldownTimer.setPositionAsPercent(param1);
         }
         else
         {
            this._cooldownTimer.setPositionAsPercent(0);
         }
      }
      
      public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 0) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc5_:uint = Math.ceil(param1 * Time.MILLISECOND_IN_SECOND);
         if(this._cooldown == _loc5_)
         {
            return;
         }
         this.clearCoolDownTime();
         if(_loc5_ > 0)
         {
            this._cooldown = _loc5_;
            _loc6_ = (param4 & (ANIMATION_TYPES.MOVE_GREEN_BAR_UP | ANIMATION_TYPES.MOVE_GREEN_BAR_DOWN)) > 0;
            this.cooldownTimerTf.textColor = !!_loc6_ ? uint(GREEN_COOLDOWN_TEXT_COLOR) : uint(ORANGE_COOLDOWN_TEXT_COLOR);
            this.status |= !!_loc6_ ? IN_USE_FLAG : COOLDOWN_FLAG;
            _loc7_ = (param4 & (ANIMATION_TYPES.MOVE_GREEN_BAR_DOWN | ANIMATION_TYPES.MOVE_ORANGE_BAR_DOWN)) > 0;
            param2 = param2 > param1 ? Number(param2) : Number(param1);
            param3 = param2 - param1;
            _loc8_ = !!_loc7_ ? Number(param1 / param2) : Number(param3 / param2);
            _loc9_ = TOTAL_COOLDOWN_FRAMES * _loc8_;
            if(!this._isReplay)
            {
               this.onCooldownTick();
               this._cooldownTimer.start(param1,this,_loc9_,1,_loc7_);
               this._scheduler.scheduleRepeatableTask(this.onCooldownTick,COOLDOWN_INTERVAL,_loc5_ / COOLDOWN_INTERVAL);
            }
            else
            {
               this._cooldownTimer.step(this,_loc9_,1,_loc7_);
            }
         }
      }
      
      public function setTimerSnapshot(param1:int, param2:Boolean) : void
      {
         var _loc3_:uint = 0;
         if(param1 > 0)
         {
            this.cooldownTimerTf.text = param1.toString();
            _loc3_ = this.status;
            _loc3_ |= COOLDOWN_FLAG;
            if(this.status != _loc3_)
            {
               this.status |= COOLDOWN_FLAG;
            }
            if(param2)
            {
               this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
               this.cooldownMc.visible = true;
               this.cooldownTimerTf.visible = true;
               this._cooldownTimer.setFrames(GREEN_COOLDOWN_START_FRAME,GREEN_COOLDOWN_END_FRAME,true);
            }
            enabled = !this._isReplay;
         }
         else
         {
            this.cooldownTimerTf.text = Values.EMPTY_STR;
         }
      }
      
      public function showGlow(param1:int) : void
      {
         this._glowId = param1;
         this._showGlow = true;
         invalidate(GLOW_VALIDATION_FLAG);
      }
      
      private function onCooldownTick() : void
      {
         if(this._cooldown < COOLDOWN_INTERVAL)
         {
            if(!this._isReplay)
            {
               this._scheduler.scheduleTask(this.clearCoolDownTime,this._cooldown);
            }
            this._cooldown = 0;
         }
         else
         {
            this._cooldown -= COOLDOWN_INTERVAL;
         }
         invalidateData();
      }
      
      override public function get enabled() : Boolean
      {
         if(this.isCooldown)
         {
            return true;
         }
         return super.enabled;
      }
      
      override public function set state(param1:String) : void
      {
         if(this.isCooldown)
         {
            return;
         }
         super.state = param1;
      }
      
      public function get consumablesVO() : ConsumablesVO
      {
         return this._consumablesVo;
      }
      
      public function set key(param1:Number) : void
      {
         if(this._bindSfKeyCode == param1)
         {
            return;
         }
         this._bindSfKeyCode = param1;
         invalidate(KEY_VALIDATION_FLAG);
      }
      
      public function set quantity(param1:int) : void
      {
         param1 = param1 < 0 ? int(-1) : int(param1);
         if(param1 == this._quantity)
         {
            return;
         }
         if(param1 == 0)
         {
            this.status |= EMPTY_FLAG;
         }
         else
         {
            this.status &= ~EMPTY_FLAG;
         }
         this._quantity = param1;
         invalidateData();
      }
      
      public function set icon(param1:String) : void
      {
         this.iconLoader.source = param1;
      }
      
      public function get showConsumableBorder() : Boolean
      {
         return false;
      }
      
      public function set showConsumableBorder(param1:Boolean) : void
      {
      }
      
      public function set isReplay(param1:Boolean) : void
      {
         this._isReplay = param1;
         enabled = !this._isReplay;
      }
      
      public function set activated(param1:Boolean) : void
      {
         if(param1 == this._isActivated)
         {
            return;
         }
         this._isActivated = param1;
         invalidate(ACTIVATED_VALIDATION_FLAG);
      }
      
      public function updateLockedInformation(param1:int, param2:String) : void
      {
      }
      
      public function updateLevelInformation(param1:int) : void
      {
      }
      
      private function get status() : uint
      {
         return this._statusMask;
      }
      
      private function set status(param1:uint) : void
      {
         var _loc2_:uint = param1 ^ this._statusMask;
         if(_loc2_ == 0)
         {
            return;
         }
         this._statusMask = param1;
         enabled = this.isAvailable;
         invalidate(STATUS_VALIDATION_FLAG);
      }
      
      private function get isAvailable() : Boolean
      {
         return this._statusMask == STATUS_AVAILABLE;
      }
      
      private function get isEmpty() : Boolean
      {
         return (this._statusMask & EMPTY_FLAG) > 0;
      }
      
      private function get isCooldown() : Boolean
      {
         return (this._statusMask & (COOLDOWN_FLAG | IN_USE_FLAG)) > 0;
      }
      
      private function get isInUse() : Boolean
      {
         return (this._statusMask & IN_USE_FLAG) > 0;
      }
      
      public function setStage(param1:int) : void
      {
      }
   }
}
