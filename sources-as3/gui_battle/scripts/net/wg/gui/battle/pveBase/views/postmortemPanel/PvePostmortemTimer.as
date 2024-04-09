package net.wg.gui.battle.pveBase.views.postmortemPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.FrameAnimationTimer;
   
   public class PvePostmortemTimer extends FrameAnimationTimer
   {
      
      private static const START_FRAME:int = 1;
      
      private static const END_FRAME:int = 145;
      
      private static const ICON_FRAME:int = 1;
      
      private static const ICON_LOCK_FRAME:int = 2;
       
      
      public var graphicsSpr:PvePostmortemTimerContainer = null;
      
      public function PvePostmortemTimer()
      {
         super();
         init(true,true);
      }
      
      public function setLockedState(param1:Boolean) : void
      {
         this.graphicsSpr.setIconFrame(!!param1 ? int(ICON_LOCK_FRAME) : int(ICON_FRAME));
         this.getTimerTF().visible = !param1;
         this.getProgressBarMc().gotoAndStop(START_FRAME);
      }
      
      public function stopTimer() : void
      {
         pauseRadialTimer();
         pauseHideTimer();
      }
      
      override protected function invokeAdditionalActionOnIntervalUpdate() : void
      {
      }
      
      override protected function getProgressBarMc() : MovieClip
      {
         return this.graphicsSpr.progressBar;
      }
      
      override protected function getTimerTF() : TextField
      {
         return this.graphicsSpr.textField;
      }
      
      override protected function onIntervalHideUpdateHandler() : void
      {
         this.stopTimer();
      }
      
      override protected function getStartFrame() : int
      {
         return START_FRAME;
      }
      
      override protected function getEndFrame() : int
      {
         return END_FRAME;
      }
      
      override protected function resetAnimState() : void
      {
      }
      
      override protected function onDispose() : void
      {
         this.graphicsSpr.dispose();
         this.graphicsSpr = null;
         super.onDispose();
      }
   }
}
