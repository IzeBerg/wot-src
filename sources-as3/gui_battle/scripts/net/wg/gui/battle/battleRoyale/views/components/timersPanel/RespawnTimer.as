package net.wg.gui.battle.battleRoyale.views.components.timersPanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.IScheduler;
   import scaleform.gfx.TextFieldEx;
   
   public class RespawnTimer extends BattleUIComponent
   {
      
      private static const ALERT_TIME:int = 60;
      
      private static const ANIM_NORMAL:String = "normal";
      
      private static const ANIM_ALERT:String = "alert";
      
      private static const ANIM_EMPTY:String = "empty";
       
      
      public var timerMC:TimerTextField = null;
      
      public var glowMC:MovieClip = null;
      
      private var _scheduler:IScheduler;
      
      private var _isReplay:Boolean = false;
      
      private var _isAvailable:Boolean = false;
      
      private var _timeLeft:uint = 0;
      
      public function RespawnTimer()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._timeLeft <= 0)
            {
               gotoAndPlay(ANIM_EMPTY);
            }
            else if(this.isInAlertMode)
            {
               gotoAndStop(ANIM_ALERT);
            }
            else
            {
               gotoAndStop(ANIM_NORMAL);
            }
            this.timerMC.time = this._timeLeft;
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearTime();
         this._scheduler = null;
         this.glowMC = null;
         this.timerMC.dispose();
         this.timerMC = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         gotoAndStop(ANIM_NORMAL);
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
            this._timeLeft = param1;
            if(!this._isReplay)
            {
               this.onTick();
               this._scheduler.scheduleRepeatableTask(this.onTick,Time.MILLISECOND_IN_SECOND,this._timeLeft);
            }
            else
            {
               invalidateData();
               validateNow();
            }
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
      
      public function set isAvailable(param1:Boolean) : void
      {
         this._isAvailable = param1;
         invalidateData();
      }
      
      private function get isInAlertMode() : Boolean
      {
         return this._timeLeft <= ALERT_TIME && !this._isAvailable;
      }
   }
}
