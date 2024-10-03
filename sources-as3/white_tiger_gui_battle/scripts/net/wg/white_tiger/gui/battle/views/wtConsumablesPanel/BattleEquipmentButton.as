package net.wg.white_tiger.gui.battle.views.wtConsumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
   import net.wg.gui.battle.components.CoolDownTimer;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
   import net.wg.utils.IScheduler;
   
   public class BattleEquipmentButton extends net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton implements IWTConsumablesButton
   {
      
      private static const EQUIPMENT_STAGES_ACTIVE:int = 5;
      
      private static const HYPERION_PROGRESS_TEXT_COLOR:uint = 16768409;
      
      private static const COOLDOWN_COUNTER_BG_RED:String = "red";
      
      private static const COOLDOWN_COUNTER_BG_GREEN:String = "green";
      
      private static const HOVER_CONSUMABLE:String = "consumable";
      
      private static const HOVER_ABILITY:String = "ability";
       
      
      public var progressBar:MovieClip = null;
      
      public var background:MovieClip = null;
      
      public var selected:MovieClip = null;
      
      public var hover:MovieClip = null;
      
      private var _currentTime:int = 0;
      
      private var _stage:int = 0;
      
      private var _scheduler:IScheduler = null;
      
      private var _coolDownTimer:CoolDownTimer = null;
      
      private var _glow:BattleEquipmentButtonGlow = null;
      
      public function BattleEquipmentButton()
      {
         super();
         this._scheduler = App.utils.scheduler;
         this.selected.visible = false;
         this.progressBar.visible = false;
         this._glow = glow as BattleEquipmentButtonGlow;
      }
      
      override public function clearCoolDownTime() : void
      {
         super.clearCoolDownTime();
         this._scheduler.cancelTask(this.updateCoolDown);
      }
      
      override public function hideGlow() : void
      {
         super.hideGlow();
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
      }
      
      override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         this._scheduler.cancelTask(this.updateCoolDown);
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
         var _loc5_:String = consumablesVO.tag;
         if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM && param1 > 0 && this._stage == EQUIPMENT_STAGES_ACTIVE)
         {
            this._currentTime = param1;
            counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_GREEN);
            cooldownTimerTf.text = this._currentTime.toString();
            super.setCoolDownTime(param1,param2,param3,param4);
            this._scheduler.scheduleRepeatableTask(this.updateCoolDown,Time.MILLISECOND_IN_SECOND);
         }
         else
         {
            super.setCoolDownTime(param1,param2,param3,param4);
         }
         if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM)
         {
            if(param1 <= 0)
            {
               this._glow.glowBlue();
               if(param1 == -1)
               {
                  this._glow.hideText();
                  cooldownMc.gotoAndStop(cooldownMc.totalFrames);
                  cooldownMc.transform.colorTransform = COLOR_STATES.GREEN_COOLDOWN_COLOR_TRANSFORM;
                  cooldownMc.visible = true;
               }
               else
               {
                  cooldownMc.visible = false;
               }
               clearCoolDownText();
            }
            else
            {
               this.hideGlow();
            }
         }
         this.updateButtonEnabled(param1 <= 0);
      }
      
      override public function setStage(param1:int) : void
      {
         this._stage = param1;
      }
      
      override public function showGlow(param1:int) : void
      {
         this._glow.glowBlue();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(consumablesVO != null && isInvalid(KEY_VALIDATION))
         {
            this.hover.gotoAndStop(consumablesVO.tag == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM ? HOVER_ABILITY : HOVER_CONSUMABLE);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.selected.mouseEnabled = this.selected.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateCoolDown);
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
         this._scheduler = null;
         this.background = null;
         this.progressBar = null;
         this.hover = null;
         this._glow = null;
         if(this._coolDownTimer)
         {
            this._coolDownTimer.dispose();
            this._coolDownTimer = null;
         }
         super.onDispose();
      }
      
      public function setCharge(param1:int, param2:Number, param3:Boolean) : void
      {
         this.progressBar.visible = param3;
         cooldownTimerTf.visible = param3;
         counterBg.visible = param3;
         if(param3)
         {
            this.hideGlow();
            this.progressBar.gotoAndStop(param2);
            counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_RED);
            cooldownTimerTf.textColor = HYPERION_PROGRESS_TEXT_COLOR;
            cooldownTimerTf.text = param2 + "%";
            cooldownTimer.setPositionAsPercent(param2);
            iconLoader.transform.colorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
         }
      }
      
      public function setDebuffView(param1:Boolean) : void
      {
         cooldownMc.transform.colorTransform = COLOR_STATES.ORANGE_COOLDOWN_COLOR_TRANSFORM;
         cooldownMc.visible = !param1;
      }
      
      public function setSelected(param1:Boolean) : void
      {
         this.selected.visible = param1;
         if(param1)
         {
            this.hideGlow();
            iconLoader.transform.colorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
         }
      }
      
      private function updateButtonEnabled(param1:Boolean) : void
      {
         _isEnabled = param1;
         buttonMode = _isEnabled;
         mouseEnabled = !!isAllowedToShowToolTipOnDisabledState ? Boolean(true) : Boolean(_isEnabled);
      }
      
      private function hideGlowOnTimeout() : void
      {
         this._glow.hideOnTimeout();
      }
      
      private function updateCoolDown() : void
      {
         this._currentTime -= 1;
         cooldownTimerTf.text = this._currentTime.toString();
         if(this._currentTime <= 0)
         {
            this._scheduler.cancelTask(this.updateCoolDown);
         }
      }
      
      override public function set activated(param1:Boolean) : void
      {
         super.activated = param1;
         this._glow.hideText();
      }
      
      override public function set empty(param1:Boolean) : void
      {
         super.empty = param1;
         if(param1)
         {
            this.hideGlow();
            this._glow.setBindKeyText(Values.EMPTY_STR);
         }
         else
         {
            invalidate(KEY_VALIDATION);
         }
         if(consumablesVO.tag == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM)
         {
            this._glow.visible = !param1;
         }
      }
   }
}
