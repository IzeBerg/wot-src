package net.wg.gui.battle.eventBattle.views.battleHints
{
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.Values;
   import net.wg.utils.IScheduler;
   
   public class TextContainerTimer extends TextContainer
   {
      
      private static const ZERO_STRING:String = "0";
      
      private static const SEMICOLON_STRING:String = ":";
      
      private static const ZERO_PREFIX_THRESHOLD:int = 10;
      
      private static const TIMER_OFFSET:int = 2;
       
      
      public var txtTimer:TextField = null;
      
      private var _scheduler:IScheduler;
      
      private var _timerTime:Number = 90;
      
      public function TextContainerTimer()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.updateCurrentTime);
         this._scheduler = null;
         this.txtTimer = null;
         super.onDispose();
      }
      
      public function setTimer(param1:int) : void
      {
         var _loc2_:Rectangle = null;
         this._timerTime = param1;
         if(this._timerTime > 0)
         {
            this.txtTimer.visible = true;
            this._scheduler.scheduleRepeatableTask(this.updateCurrentTime,Time.MILLISECOND_IN_SECOND,this._timerTime);
            this.updateTimerText();
            txt.x = -(txt.width + this.txtTimer.textWidth) >> 1;
            _loc2_ = txt.getCharBoundaries(txt.length - 1);
            this.txtTimer.x = txt.x + _loc2_.right | 0;
            this.txtTimer.y = txt.y + _loc2_.top - TIMER_OFFSET | 0;
         }
         else
         {
            txt.x = -txt.width >> 1;
            this.txtTimer.visible = false;
         }
      }
      
      private function updateCurrentTime() : void
      {
         if(this._timerTime > 0)
         {
            --this._timerTime;
            this.updateTimerText();
         }
      }
      
      private function updateTimerText() : void
      {
         var _loc1_:Number = this._timerTime % Time.SECONDS_IN_MINUTE;
         var _loc2_:Number = Math.floor(this._timerTime / Time.SECONDS_IN_MINUTE);
         this.txtTimer.text = (_loc2_ >= ZERO_PREFIX_THRESHOLD ? Values.EMPTY_STR : ZERO_STRING) + _loc2_.toString() + SEMICOLON_STRING + (_loc1_ >= ZERO_PREFIX_THRESHOLD ? Values.EMPTY_STR : ZERO_STRING) + Math.floor(_loc1_).toString();
      }
   }
}
