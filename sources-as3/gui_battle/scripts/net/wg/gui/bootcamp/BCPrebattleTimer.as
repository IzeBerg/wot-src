package net.wg.gui.bootcamp
{
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBase;
   import net.wg.utils.IScheduler;
   
   public class BCPrebattleTimer extends PrebattleTimerBase
   {
      
      private static const HIDE_TIMER_STEPS:int = 100;
      
      private static const HIDE_STEP_DURATION:int = 17;
      
      private static const HIDE_ALPHA_STEP:Number = 0.01;
       
      
      private var _scheduler:IScheduler = null;
      
      private var _currentAlphaHideStep:int = 0;
      
      public function BCPrebattleTimer()
      {
         super();
         this._scheduler = App.utils.scheduler;
         isNeedWinChangePosition = false;
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.hideTimer);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function hideComponent(param1:Boolean) : void
      {
         if(param1)
         {
            alpha = Values.DEFAULT_ALPHA;
            this._scheduler.cancelTask(this.hideTimer);
            this._currentAlphaHideStep = HIDE_TIMER_STEPS;
            this._scheduler.scheduleRepeatableTask(this.hideTimer,HIDE_STEP_DURATION,HIDE_TIMER_STEPS);
         }
         else
         {
            alpha = Values.ZERO;
            hideFinalize();
         }
      }
      
      private function hideTimer() : void
      {
         --this._currentAlphaHideStep;
         alpha -= HIDE_ALPHA_STEP;
         if(this._currentAlphaHideStep == 0)
         {
            this._scheduler.cancelTask(this.hideTimer);
            hideFinalize();
         }
      }
   }
}
