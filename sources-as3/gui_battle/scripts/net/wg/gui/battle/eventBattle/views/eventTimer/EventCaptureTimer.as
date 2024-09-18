package net.wg.gui.battle.eventBattle.views.eventTimer
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.FrameAnimationTimer;
   
   public class EventCaptureTimer extends FrameAnimationTimer
   {
      
      private static const START_FRAME:int = 13;
      
      private static const END_FRAME:int = 157;
       
      
      private var _totalTime:Number = -1;
      
      private var _timeLeft:Number = -1;
      
      public function EventCaptureTimer()
      {
         super();
         init(true,false);
      }
      
      public function updateCaptureTimer(param1:Number, param2:Number, param3:Number) : void
      {
         this._totalTime = param2;
         this._timeLeft = param2 - param1;
         isActive = true;
         this.setSpeed(param3);
      }
      
      public function resetTimer() : void
      {
         updateRadialTimer(this._totalTime,0);
         stop();
      }
      
      override protected function draw() : void
      {
         super.draw();
         updateRadialTimer(this._totalTime,this._timeLeft);
      }
      
      override protected function onDispose() : void
      {
         stop();
         super.onDispose();
      }
      
      override protected function getStartFrame() : int
      {
         return START_FRAME;
      }
      
      override protected function getEndFrame() : int
      {
         return END_FRAME;
      }
      
      override public function setSpeed(param1:Number) : void
      {
         super.setSpeed(param1);
      }
      
      override protected function getProgressBarMc() : MovieClip
      {
         return this;
      }
      
      override protected function getTimerTF() : TextField
      {
         return new TextField();
      }
      
      override protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
      }
      
      override protected function resetAnimState() : void
      {
      }
      
      override protected function onIntervalHideUpdateHandler() : void
      {
      }
      
      override protected function pauseRadialTimer() : void
      {
         super.pauseRadialTimer();
      }
   }
}
