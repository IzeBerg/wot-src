package net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SecondaryTimerFXAnimation extends MovieClip implements IDisposable
   {
       
      
      public function SecondaryTimerFXAnimation()
      {
         super();
         this.init();
      }
      
      public function dispose() : void
      {
         addFrameScript(totalFrames - 1,null);
      }
      
      public function resetAnimation() : void
      {
         visible = false;
         gotoAndStop(1);
      }
      
      private function init() : void
      {
         visible = false;
         addFrameScript(totalFrames - 1,this.resetAnimation);
      }
   }
}
