package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import flash.text.TextField;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_CONSUMABLES_PANEL_TAGS;
   import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import net.wg.utils.IScheduler;
   import scaleform.gfx.TextFieldEx;
   
   public class EventBattleEquipmentButton extends BattleEquipmentButton
   {
      
      private static const EQUIPMENT_STAGES_ACTIVE:int = 5;
       
      
      public var activeGlow:EventBattleEquipmentActiveGlow = null;
      
      public var modifierTF:TextField = null;
      
      private var _currentTime:int = 0;
      
      private var _stage:int = 0;
      
      private var _scheduler:IScheduler;
      
      public function EventBattleEquipmentButton()
      {
         this._scheduler = App.utils.scheduler;
         super();
         TextFieldEx.setNoTranslate(this.modifierTF,true);
         this.modifierTF.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.activeGlow.mouseEnabled = this.activeGlow.mouseChildren = false;
      }
      
      override public function showGlow(param1:int) : void
      {
         if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE)
         {
            EventBattleEquipmentButtonGlow(glow).showGlow(param1);
         }
      }
      
      override public function set activated(param1:Boolean) : void
      {
         super.activated = param1;
         EventBattleEquipmentButtonGlow(glow).hideText();
         this.activeGlow.glowYellow();
      }
      
      override public function clearCoolDownTime() : void
      {
         super.clearCoolDownTime();
         this.activeGlow.hideGlow();
         this._scheduler.cancelTask(this.updateCoolDown);
      }
      
      override protected function disableMouse() : void
      {
      }
      
      override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1, param5:Boolean = false) : void
      {
         this._scheduler.cancelTask(this.updateCoolDown);
         this._scheduler.cancelTask(this.hideGlowOnTimeout);
         var _loc6_:String = consumablesVO.tag;
         if((_loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_NITRO || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_BUFF || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.REPAIR_AND_CREW_HEAL) && param1 > 0 && this._stage == EQUIPMENT_STAGES_ACTIVE)
         {
            this._currentTime = param1;
            super.setCoolDownTime(-1,param1,0);
            counterBg.gotoAndStop(BattleEquipmentButton.COOLDOWN_COUNTER_BG_GREEN);
            if(_baseDisposed)
            {
               return;
            }
            cooldownTimerTf.text = this._currentTime.toString();
            this._scheduler.scheduleRepeatableTask(this.updateCoolDown,Time.MILLISECOND_IN_SECOND,param1);
         }
         else
         {
            super.setCoolDownTime(param1,param2,param3,param4,param5);
         }
         if(param1 > 0 && this._stage != EQUIPMENT_STAGES_ACTIVE)
         {
            this.activeGlow.hideGlow();
         }
         if(_loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.TRIGGER || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_NITRO || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.SUPER_SHELL || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_BUFF || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_ITEM || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.REPAIR_AND_CREW_HEAL || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.INSTANT_RELOAD)
         {
            if(param1 <= 0)
            {
               EventBattleEquipmentButtonGlow(glow).glowYellow();
               this.activeGlow.glowYellow();
               clearCoolDownText();
            }
            else
            {
               this.hideGlow();
            }
         }
         if(_loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.EVENT_PASSIVE_ABILITY || _loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.SUPER_SHELL)
         {
            this.modifierTF.visible = param1 <= 0 && param2 > 0;
            if(param1 == -1)
            {
               EventBattleEquipmentButtonGlow(glow).hideText();
            }
            if(this.modifierTF.visible)
            {
               this.modifierTF.text = param2.toString();
            }
         }
         if(_loc6_ == BATTLE_CONSUMABLES_PANEL_TAGS.RESURRECT)
         {
            EventBattleEquipmentButtonGlow(glow).hideTFContainer();
         }
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
         this.modifierTF = null;
         this.activeGlow.dispose();
         this.activeGlow = null;
         super.onDispose();
      }
      
      private function hideGlowOnTimeout() : void
      {
         EventBattleEquipmentButtonGlow(glow).hideOnTimeout();
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
