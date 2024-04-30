package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   
   public class HBEquipmentButton extends HBEquipmentButtonBase
   {
       
      
      public var cooldownTimerTf:TextField = null;
      
      private var _isGlowed:Boolean = false;
      
      public function HBEquipmentButton()
      {
         super();
      }
      
      override public function hideGlow() : void
      {
         this._isGlowed = false;
         super.hideGlow();
      }
      
      override public function showGlow(param1:int) : void
      {
         this._isGlowed = true;
         super.showGlow(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         state = InteractiveStates.UP;
      }
      
      override protected function onDispose() : void
      {
         this.cooldownTimerTf = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            buttonMode = this._isGlowed;
         }
      }
      
      override protected function startCooldown(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = NaN;
         if(!_isReplay)
         {
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
