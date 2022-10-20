package net.wg.gui.battle.halloween.consumablesPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   
   public class HWAbilityButton extends HWEquipmentButtonBase
   {
      
      private static const STAGE_READY:int = 3;
      
      private static const STAGE_PREPARING:int = 4;
      
      private static const STAGE_COOLDOWN:int = 6;
      
      private static const INTERACTIVE_STATES:Vector.<int> = new <int>[STAGE_READY,STAGE_PREPARING];
      
      private static const GLOW_GREEN:String = "green";
      
      private static const GLOW_RED:String = "red";
      
      private static const GLOW_NONE:String = "none";
       
      
      public var cooldownTimerTf:TextField = null;
      
      public var timeLeftTf:TextField = null;
      
      public var counterHighlight:MovieClip = null;
      
      public var amountTf:TextField = null;
      
      private var _currentCooldownTf:TextField;
      
      private var _stage:int;
      
      private var _isGlowed:Boolean = false;
      
      public function HWAbilityButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._currentCooldownTf = null;
         this.timeLeftTf = null;
         this.counterHighlight = null;
         this.cooldownTimerTf = null;
         this.amountTf = null;
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
         var _loc4_:Boolean = this._stage == STAGE_COOLDOWN;
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
      
      override public function showGlow(param1:int) : void
      {
         this._isGlowed = true;
         this.updateInteraction();
         super.showGlow(param1);
      }
      
      override public function hideGlow() : void
      {
         this._isGlowed = false;
         this.updateInteraction();
         super.hideGlow();
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
      
      public function setStage(param1:int) : void
      {
         if(this._stage == param1)
         {
            return;
         }
         this._stage = param1;
         this.updateInteraction();
         this.resolveIconTransparency();
      }
      
      private function updateInteraction() : void
      {
         var _loc1_:Boolean = INTERACTIVE_STATES.indexOf(this._stage) != -1 && this._isGlowed;
         buttonMode = _loc1_;
         if(_loc1_)
         {
            super.dropPermanentState();
         }
         else
         {
            super.setPermanentState(InteractiveStates.UP);
         }
      }
      
      override public function set quantity(param1:int) : void
      {
         this.amountTf.text = param1 > 0 ? param1.toString() : Values.EMPTY_STR;
      }
      
      override protected function resolveIconTransparency() : void
      {
         if(this._stage == STAGE_COOLDOWN)
         {
            iconLoader.alpha = this.amountTf.alpha = TRANSPARENT_ALPHA;
         }
         else
         {
            iconLoader.alpha = this.amountTf.alpha = Values.DEFAULT_ALPHA;
         }
      }
      
      override protected function setPermanentState(param1:String) : void
      {
      }
      
      override protected function dropPermanentState() : void
      {
      }
   }
}
