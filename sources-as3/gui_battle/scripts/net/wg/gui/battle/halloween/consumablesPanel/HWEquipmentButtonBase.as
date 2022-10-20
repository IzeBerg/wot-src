package net.wg.gui.battle.halloween.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.KeyProps;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.CoolDownTimer;
   import net.wg.gui.battle.components.buttons.BattleToolTipButton;
   import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
   import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
   import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
   import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.utils.IScheduler;
   
   public class HWEquipmentButtonBase extends BattleToolTipButton implements IConsumablesButton, ICoolDownCompleteHandler
   {
      
      protected static const COOLDOWN_START_FRAME:int = 1;
      
      protected static const TIME_SPEED:int = 1;
      
      protected static const TRANSPARENT_ALPHA:Number = 0.5;
       
      
      public var hit:MovieClip = null;
      
      public var glow:HWGlowBase = null;
      
      public var iconLoader:UILoaderAlt = null;
      
      public var cooldownMc:MovieClip = null;
      
      private var _consumablesVO:ConsumablesVO = null;
      
      private var _bindSfKeyCode:Number;
      
      private var _currentTime:int;
      
      private var _baseTime:int;
      
      private var _isPermanentState:Boolean;
      
      private var _isCooldown:Boolean;
      
      private var _lastState:String;
      
      protected var _coolDownTimer:CoolDownTimer = null;
      
      protected var _isReplay:Boolean;
      
      protected var _scheduler:IScheduler;
      
      protected var _cooldownEndFrame:int;
      
      public function HWEquipmentButtonBase()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._cooldownEndFrame = this.cooldownMc.totalFrames;
         this._coolDownTimer = new CoolDownTimer(this.cooldownMc);
         this._coolDownTimer.setFrames(COOLDOWN_START_FRAME,this._cooldownEndFrame);
         isAllowedToShowToolTipOnDisabledState = true;
         hideToolTipOnClickActions = false;
         this._consumablesVO = new ConsumablesVO();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hit.mouseEnabled = false;
         hitArea = this.hit;
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateCountdownText);
         this._scheduler = null;
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.glow.dispose();
         this.glow = null;
         this.cooldownMc = null;
         this.hit = null;
         this._consumablesVO = null;
         this._coolDownTimer.dispose();
         this._coolDownTimer = null;
         super.onDispose();
      }
      
      public function showGlow(param1:int) : void
      {
         this.glow.showGlow(param1);
      }
      
      public function set activated(param1:Boolean) : void
      {
         this.glow.isActive = param1;
      }
      
      public function set key(param1:Number) : void
      {
         if(this._bindSfKeyCode == param1)
         {
            return;
         }
         this._bindSfKeyCode = param1;
         if(this._bindSfKeyCode == KeyProps.KEY_NONE)
         {
            this.glow.setBindKeyText(App.utils.locale.makeString(READABLE_KEY_NAMES.KEY_NONE));
         }
         else
         {
            this.glow.setBindKeyText(App.utils.commons.keyToString(this._bindSfKeyCode).keyName);
         }
      }
      
      public function set quantity(param1:int) : void
      {
      }
      
      public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         this._scheduler.cancelTask(this.updateCountdownText);
         this.endCountdown();
         this._baseTime = param2;
         this._currentTime = Math.round(param1);
         if(param1 > 0)
         {
            this._isCooldown = true;
            this.startCooldown(param1,param3,param2);
            if(_baseDisposed)
            {
               return;
            }
            this.drawCountdownText(this._currentTime);
         }
      }
      
      protected function updateCountdownText() : void
      {
         --this._currentTime;
         this.drawCountdownText(this._currentTime);
         if(this._currentTime < 0)
         {
            this._scheduler.cancelTask(this.updateCountdownText);
            this.endCountdown();
         }
      }
      
      protected function startCooldown(param1:Number, param2:Number, param3:Number) : void
      {
      }
      
      protected function setPermanentState(param1:String) : void
      {
         super.state = param1;
         this._isPermanentState = true;
         this.resolveIconTransparency();
      }
      
      protected function dropPermanentState() : void
      {
         if(!this._isPermanentState)
         {
            return;
         }
         super.state = this._lastState || InteractiveStates.UP;
         this._lastState = null;
         this._isPermanentState = false;
         this.resolveIconTransparency();
      }
      
      protected function resolveIconTransparency() : void
      {
         if(this._isCooldown)
         {
            this.iconLoader.alpha = TRANSPARENT_ALPHA;
         }
         else
         {
            this.iconLoader.alpha = Values.DEFAULT_ALPHA;
         }
      }
      
      protected function endCountdown() : void
      {
         this._isCooldown = false;
         this._coolDownTimer.end();
         this.cooldownMc.visible = false;
         this.dropPermanentState();
      }
      
      override public function set state(param1:String) : void
      {
         if(this._isPermanentState)
         {
            this._lastState = param1;
            return;
         }
         super.state = param1;
      }
      
      public function setCoolDownPosAsPercent(param1:Number) : void
      {
         if(param1 < 100)
         {
            this._coolDownTimer.setPositionAsPercent(param1);
         }
         else if(!this._isReplay)
         {
            this.setCoolDownTime(0,this._baseTime,0);
         }
      }
      
      public function setColorTransform(param1:ColorTransform) : void
      {
         if(param1)
         {
            this.iconLoader.transform.colorTransform = param1;
         }
      }
      
      public function get consumablesVO() : ConsumablesVO
      {
         return this._consumablesVO;
      }
      
      public function set icon(param1:String) : void
      {
         this.iconLoader.source = param1;
      }
      
      public function clearColorTransform() : void
      {
         this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
      }
      
      public function clearCoolDownTime() : void
      {
         this.endCountdown();
      }
      
      public function hideGlow() : void
      {
         this.glow.hideGlow();
      }
      
      public function setTimerSnapshot(param1:int, param2:Boolean) : void
      {
         if(param1 > 0)
         {
            this.drawCountdownText(param1);
         }
      }
      
      public function set isReplay(param1:Boolean) : void
      {
         this._isReplay = param1;
      }
      
      public function updateLockedInformation(param1:int, param2:String) : void
      {
      }
      
      public function updateLevelInformation(param1:int) : void
      {
      }
      
      public function onCoolDownComplete() : void
      {
      }
      
      public function get showConsumableBorder() : Boolean
      {
         return false;
      }
      
      public function set showConsumableBorder(param1:Boolean) : void
      {
      }
      
      protected function drawCountdownText(param1:int) : void
      {
      }
   }
}
