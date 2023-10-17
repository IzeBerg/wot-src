package net.wg.gui.battle.battleRoyale.views.components.timersPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.IScheduler;
   import scaleform.gfx.TextFieldEx;
   
   public class AirDropTimer extends BattleUIComponent
   {
      
      private static const FINISH_TIME:int = 0;
      
      private static const ANIM_NORMAL:String = "normal";
      
      private static const ANIM_FINISH:String = "finish";
      
      private static const ANIM_START:String = "start";
       
      
      public var timerMC:TimerTextField = null;
      
      private var _scheduler:IScheduler;
      
      private var _isReplay:Boolean = false;
      
      private var _animState:String = "normal";
      
      private var _timeLeft:int = -1;
      
      public function AirDropTimer()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._timeLeft == FINISH_TIME && this._animState != ANIM_FINISH)
            {
               this._animState = ANIM_FINISH;
               invalidateState();
            }
            this.timerMC.time = this._timeLeft < 0 ? Number(0) : Number(this._timeLeft);
         }
         if(isInvalid(InvalidationType.STATE))
         {
            gotoAndPlay(this._animState);
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearTime();
         this._scheduler = null;
         this.timerMC.dispose();
         this.timerMC = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         TextFieldEx.setNoTranslate(this.timerMC.textField,true);
      }
      
      public function clearTime() : void
      {
         this._timeLeft = 0;
         if(!this._isReplay)
         {
            this._scheduler.cancelTask(this.clearTime);
            this._scheduler.cancelTask(this.onTick);
         }
      }
      
      public function setTime(param1:Number) : void
      {
         if(this._timeLeft == param1)
         {
            return;
         }
         this.clearTime();
         if(param1 >= 0)
         {
            if(this._timeLeft != Values.DEFAULT_INT && param1 > this._timeLeft && this._animState != ANIM_NORMAL)
            {
               this._animState = ANIM_START;
               invalidateState();
            }
            this._timeLeft = param1;
            if(!this._isReplay)
            {
               this._scheduler.scheduleRepeatableTask(this.onTick,Time.MILLISECOND_IN_SECOND,this._timeLeft);
            }
            invalidateData();
            validateNow();
         }
      }
      
      private function onTick() : void
      {
         if(this._timeLeft < 1)
         {
            if(!this._isReplay)
            {
               this._scheduler.scheduleOnNextFrame(this.clearTime);
            }
            this._timeLeft = 0;
         }
         else
         {
            this._timeLeft -= 1;
         }
         invalidateData();
      }
      
      public function set isReplay(param1:Boolean) : void
      {
         this._isReplay = param1;
      }
   }
}
