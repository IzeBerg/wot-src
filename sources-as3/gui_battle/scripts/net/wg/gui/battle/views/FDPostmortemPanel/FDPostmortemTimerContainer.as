package net.wg.gui.battle.views.FDPostmortemPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.destroyTimers.components.TimerContainer;
   
   public class FDPostmortemTimerContainer extends TimerContainer
   {
       
      
      public function FDPostmortemTimerContainer()
      {
         super();
      }
      
      public function setIconFrame(param1:int) : void
      {
         MovieClip(iconSpr).gotoAndStop(param1);
      }
      
      override protected function onDispose() : void
      {
         progressBar.stop();
         super.onDispose();
      }
   }
}
