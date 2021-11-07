package net.wg.gui.battle.views.destroyTimers.utils.pairs
{
   import flash.utils.getTimer;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.views.destroyTimers.components.notifiers.CollapsedTimerNotifier;
   import net.wg.gui.battle.views.destroyTimers.components.notifiers.NormalTimerNotifier;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IScheduler;
   
   public class TimerNotifierPair extends NotifierPair
   {
       
      
      private var _normal:NormalTimerNotifier;
      
      private var _collapsed:CollapsedTimerNotifier;
      
      private var _timeLeft:int;
      
      private var _totalTime:int;
      
      private var _speed:Number = 1;
      
      private var _scheduler:IScheduler;
      
      private var _prevTime:Number;
      
      private var _message:String = "";
      
      public function TimerNotifierPair()
      {
         this._scheduler = App.utils.scheduler;
         var _loc1_:IClassFactory = App.utils.classFactory;
         this._normal = _loc1_.getComponent(Linkages.EVENT_GOTO_POINT_TIMER_UI,NormalTimerNotifier);
         this._collapsed = _loc1_.getComponent(Linkages.SECONDARY_EVENT_GOTO_POINT_TIMER_UI,CollapsedTimerNotifier);
         super(this._normal,this._collapsed);
      }
      
      override protected function onDispose() : void
      {
         this._collapsed = null;
         this._normal = null;
         this._scheduler.cancelTask(this.enterFrameHandler);
         this._scheduler = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._collapsed.visible)
         {
            this._collapsed.setData(this._timeLeft,this._totalTime);
         }
         if(this._normal.visible)
         {
            this._normal.setData(this._timeLeft,this._totalTime);
            this._normal.setText(this._message);
         }
      }
      
      public function setData(param1:int, param2:int) : void
      {
         this._timeLeft = param1 * Time.MILLISECOND_IN_SECOND;
         this._totalTime = param2 * Time.MILLISECOND_IN_SECOND;
         this.draw();
      }
      
      public function setMessage(param1:String) : void
      {
         if(this._message == param1)
         {
            return;
         }
         this._message = param1;
         if(this._normal.visible)
         {
            this._normal.setText(param1);
         }
      }
      
      public function setSpeed(param1:Number) : void
      {
         this._speed = param1;
      }
      
      private function enterFrameHandler() : void
      {
         var _loc1_:int = getTimer();
         var _loc2_:int = this._speed * (_loc1_ - this._prevTime);
         this._timeLeft -= _loc2_;
         if(this._timeLeft < 0)
         {
            this._timeLeft = 0;
         }
         this.draw();
         if(this.isActive)
         {
            this._prevTime = _loc1_;
            this._scheduler.scheduleOnNextFrame(this.enterFrameHandler);
         }
      }
      
      override public function set state(param1:int) : void
      {
         super.state = param1;
         if(param1 == NotifierPairState.INACTIVE)
         {
            this._scheduler.cancelTask(this.enterFrameHandler);
         }
         else if(this.isActive)
         {
            this._prevTime = getTimer();
            this._scheduler.scheduleOnNextFrame(this.enterFrameHandler);
         }
      }
      
      private function get isActive() : Boolean
      {
         return state == NotifierPairState.NORMAL || state == NotifierPairState.COLLAPSED;
      }
   }
}
