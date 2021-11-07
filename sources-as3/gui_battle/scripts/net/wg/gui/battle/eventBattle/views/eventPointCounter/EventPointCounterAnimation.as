package net.wg.gui.battle.eventBattle.views.eventPointCounter
{
   import flash.display.MovieClip;
   
   public class EventPointCounterAnimation extends MovieClip
   {
       
      
      public var fx1:MovieClip = null;
      
      public var fx2:MovieClip = null;
      
      public var fx3:MovieClip = null;
      
      public function EventPointCounterAnimation()
      {
         super();
      }
      
      public function stopAnimation() : void
      {
         this.fx1.stop();
         this.fx2.stop();
         this.fx3.stop();
      }
      
      public function playAnimation() : void
      {
         this.fx1.play();
         this.fx2.play();
         this.fx3.play();
      }
      
      public final function dispose() : void
      {
         this.fx1 = null;
         this.fx2 = null;
         this.fx3 = null;
      }
   }
}
