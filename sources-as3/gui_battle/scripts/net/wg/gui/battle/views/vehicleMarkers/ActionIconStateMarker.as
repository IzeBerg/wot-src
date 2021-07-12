package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ActionIconStateMarker extends MovieClip implements IDisposable
   {
       
      
      public var blinkAnimationMC:MovieClip = null;
      
      public var clickAnimationMC:MovieClip = null;
      
      public function ActionIconStateMarker()
      {
         super();
         this.clickAnimationMC.visible = false;
      }
      
      public function playClickAnimation() : void
      {
         this.clickAnimationMC.visible = true;
         this.clickAnimationMC.play();
      }
      
      public function playBlinkAnimation(param1:Boolean) : void
      {
         this.blinkAnimationMC.visible = param1;
         this.blinkAnimationMC.play();
      }
      
      public final function dispose() : void
      {
         if(this.blinkAnimationMC != null)
         {
            this.blinkAnimationMC.stop();
            this.blinkAnimationMC = null;
         }
         if(this.clickAnimationMC != null)
         {
            this.clickAnimationMC.stop();
            this.clickAnimationMC = null;
         }
      }
   }
}
