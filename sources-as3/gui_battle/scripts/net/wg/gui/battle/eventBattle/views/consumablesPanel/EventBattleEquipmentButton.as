package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import net.wg.utils.IScheduler;
   
   public class EventBattleEquipmentButton extends BattleEquipmentButton
   {
      
      private static const EQUIPMENT_STAGES_ACTIVE:int = 5;
      
      private static const BG_ACTIVE:String = "active";
      
      private static const BG_INACTIVE:String = "inactive";
       
      
      public var activeGlow:EventBattleEquipmentActiveGlow = null;
      
      public var activeNormal:MovieClip = null;
      
      public var background:MovieClip = null;
      
      private var _currentTime:int = 0;
      
      private var _stage:int = 0;
      
      private var _scheduler:IScheduler = null;
      
      public function EventBattleEquipmentButton()
      {
         super();
         this._scheduler = App.utils.scheduler;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.activeNormal.mouseEnabled = false;
         this.activeNormal.mouseChildren = false;
      }
      
      override public function showGlow(param1:int) : void
      {
         (glow as EventBattleEquipmentButtonGlow).glowYellow();
      }
      
      override public function set activated(param1:Boolean) : void
      {
         super.activated = param1;
         (glow as EventBattleEquipmentButtonGlow).hideText();
         this.activeGlow.glowYellow();
      }
      
      override public function clearCoolDownTime() : void
      {
         super.clearCoolDownTime();
         this.activeGlow.hideGlow();
         this._scheduler.cancelTask(this.updateCoolDown);
      }
      
      override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         this._scheduler.cancelTask(this.updateCoolDown);
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
         var _loc5_:String = consumablesVO.tag;
         if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM && param1 > 0 && this._stage == EQUIPMENT_STAGES_ACTIVE)
         {
            this.activeGlow.glowYellow();
            this._currentTime = param1;
            super.setCoolDownTime(-1,param1,0,param4);
            counterBg.gotoAndStop(BattleEquipmentButton.COOLDOWN_COUNTER_BG_GREEN);
            cooldownTimerTf.text = this._currentTime.toString();
            this._scheduler.scheduleRepeatableTask(this.updateCoolDown,Time.MILLISECOND_IN_SECOND,param1);
         }
         else
         {
            super.setCoolDownTime(param1,param2,param3,param4);
         }
         if(param1 > 0 && this._stage != EQUIPMENT_STAGES_ACTIVE)
         {
            this.activeGlow.hideGlow();
         }
         if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM)
         {
            if(param1 <= 0)
            {
               (glow as EventBattleEquipmentButtonGlow).glowYellow();
               if(param1 == -1)
               {
                  (glow as EventBattleEquipmentButtonGlow).hideText();
               }
               this.activeGlow.glowYellow();
               clearCoolDownText();
            }
            else
            {
               this.hideGlow();
            }
            this.activeNormal.visible = false;
         }
         else
         {
            this.activeNormal.visible = param1 <= 0;
         }
         if(_loc5_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ITEM)
         {
            glow.visible = false;
            this.updatePassiveState();
         }
         this.updateButtonEnabled(param1 <= 0);
      }
      
      private function updateButtonEnabled(param1:Boolean) : void
      {
         _isEnabled = param1 && consumablesVO.tag != BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ITEM;
         buttonMode = _isEnabled;
         mouseEnabled = !!isAllowedToShowToolTipOnDisabledState ? Boolean(true) : Boolean(_isEnabled);
      }
      
      override public function setStage(param1:int) : void
      {
         this._stage = param1;
      }
      
      override public function set empty(param1:Boolean) : void
      {
         super.empty = param1;
         if(param1)
         {
            this.hideGlow();
            glow.setBindKeyText(Values.EMPTY_STR);
         }
         else
         {
            invalidate(KEY_VALIDATION);
         }
         if(consumablesVO.tag == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ITEM)
         {
            this.updatePassiveState();
            clearColorTransform();
         }
         else if(consumablesVO.tag == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM)
         {
            glow.visible = this.activeGlow.visible = !param1;
         }
      }
      
      override public function setColorTransform(param1:ColorTransform) : void
      {
         if(consumablesVO.tag == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ITEM)
         {
            return;
         }
         super.setColorTransform(param1);
      }
      
      override public function hideGlow() : void
      {
         super.hideGlow();
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateCoolDown);
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
         this._scheduler = null;
         this.activeGlow.dispose();
         this.activeGlow = null;
         this.activeNormal = null;
         this.background = null;
         super.onDispose();
      }
      
      private function updatePassiveState() : void
      {
         this.background.gotoAndStop(!!empty ? BG_INACTIVE : BG_ACTIVE);
      }
      
      private function hideGlowOnTimeout() : void
      {
         (glow as EventBattleEquipmentButtonGlow).hideOnTimeout();
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
   }
}
