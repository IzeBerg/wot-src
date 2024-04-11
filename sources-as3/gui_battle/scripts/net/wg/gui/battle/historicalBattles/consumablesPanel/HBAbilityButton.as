package net.wg.gui.battle.historicalBattles.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.historicalBattles.constants.HB_EQUIPMENT_STAGES;
   
   public class HBAbilityButton extends HBEquipmentButtonBase
   {
      
      private static const INTERACTIVE_STATES:Vector.<int> = new <int>[HB_EQUIPMENT_STAGES.READY,HB_EQUIPMENT_STAGES.PREPARING];
      
      private static const GLOW_GREEN:String = "green";
      
      private static const GLOW_RED:String = "red";
      
      private static const GLOW_NONE:String = "none";
       
      
      public var cooldownTimerTf:TextField = null;
      
      public var timeLeftTf:TextField = null;
      
      public var counterHighlight:MovieClip = null;
      
      private var _stage:int = -1;
      
      private var _currentCooldownTf:TextField;
      
      public function HBAbilityButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._currentCooldownTf = null;
         this.timeLeftTf = null;
         this.counterHighlight = null;
         this.cooldownTimerTf = null;
         super.onDispose();
      }
      
      override protected function drawCountdownText(param1:int) : void
      {
         if(this._currentCooldownTf == null)
         {
            return;
         }
         this._currentCooldownTf.text = param1 > 0 ? param1.toString() : Values.EMPTY_STR;
      }
      
      override protected function startCooldown(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:Boolean = this._stage == HB_EQUIPMENT_STAGES.COOLDOWN;
         if(_loc4_)
         {
            this._currentCooldownTf = this.cooldownTimerTf;
            this.counterHighlight.gotoAndStop(GLOW_RED);
         }
         else
         {
            this._currentCooldownTf = this.timeLeftTf;
            this.counterHighlight.gotoAndStop(GLOW_GREEN);
         }
         if(_baseDisposed)
         {
            return;
         }
         if(!_isReplay)
         {
            _scheduler.scheduleRepeatableTask(updateCountdownText,Time.MILLISECOND_IN_SECOND,param1);
            if(_loc4_)
            {
               _loc5_ = param2 / param3;
               _coolDownTimer.start(param1,this,Math.round((_cooldownEndFrame - COOLDOWN_START_FRAME) * _loc5_),TIME_SPEED,false,false);
               cooldownMc.visible = true;
            }
         }
      }
      
      override protected function endCountdown() : void
      {
         super.endCountdown();
         if(this._currentCooldownTf)
         {
            this._currentCooldownTf.text = Values.EMPTY_STR;
            this._currentCooldownTf = null;
         }
         this.counterHighlight.gotoAndStop(GLOW_NONE);
      }
      
      override protected function resolveIconTransparency() : void
      {
      }
      
      public function setStage(param1:int) : void
      {
         if(this._stage == param1)
         {
            return;
         }
         this._stage = param1;
         state = HB_EQUIPMENT_STAGES.getState(this._stage);
         buttonMode = enabled = INTERACTIVE_STATES.indexOf(param1) != -1;
      }
   }
}
