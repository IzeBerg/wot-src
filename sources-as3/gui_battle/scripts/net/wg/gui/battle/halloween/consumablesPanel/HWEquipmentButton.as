package net.wg.gui.battle.halloween.consumablesPanel
{
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   
   public class HWEquipmentButton extends HWEquipmentButtonBase
   {
       
      
      public var cooldownTimerTf:TextField = null;
      
      private var _isGlowed:Boolean = false;
      
      public function HWEquipmentButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(state != BATTLE_ITEM_STATES.PERMANENT)
         {
            this.setPermanentState(InteractiveStates.UP);
         }
      }
      
      override protected function onDispose() : void
      {
         this.cooldownTimerTf = null;
         super.onDispose();
      }
      
      override public function showGlow(param1:int) : void
      {
         this._isGlowed = true;
         this.dropPermanentState();
         super.showGlow(param1);
      }
      
      override public function hideGlow() : void
      {
         this._isGlowed = false;
         this.setPermanentState(InteractiveStates.UP);
         super.hideGlow();
      }
      
      override protected function dropPermanentState() : void
      {
         if(this._isGlowed || state == BATTLE_ITEM_STATES.PERMANENT)
         {
            super.dropPermanentState();
            if(this._isGlowed)
            {
               buttonMode = true;
            }
         }
      }
      
      override protected function setPermanentState(param1:String) : void
      {
         super.setPermanentState(param1);
         buttonMode = false;
      }
      
      override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
      {
         super.setCoolDownTime(param1,param2,param3,param4);
         if(param1 == -1)
         {
            this.setPermanentState(BATTLE_ITEM_STATES.PERMANENT);
         }
         else if(param1 == 0)
         {
            clearCoolDownTime();
         }
      }
      
      override protected function startCooldown(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         if(!_isReplay)
         {
            this.setPermanentState(InteractiveStates.UP);
            _scheduler.scheduleRepeatableTask(updateCountdownText,Time.MILLISECOND_IN_SECOND,param1);
            _loc4_ = param2 / param3;
            _coolDownTimer.start(param1,this,Math.round((_cooldownEndFrame - COOLDOWN_START_FRAME) * _loc4_),TIME_SPEED,false,false);
            cooldownMc.visible = true;
         }
      }
      
      override protected function drawCountdownText(param1:int) : void
      {
         this.cooldownTimerTf.text = param1 > 0 ? param1.toString() : Values.EMPTY_STR;
      }
      
      override protected function endCountdown() : void
      {
         super.endCountdown();
         this.cooldownTimerTf.text = Values.EMPTY_STR;
      }
   }
}
