package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class BCLobbySlotHint extends BCHighlightRendererBase
   {
       
      
      public var animationMC:MovieClip;
      
      public function BCLobbySlotHint()
      {
         super();
         this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,this.onAnimationComplete);
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         this.animationMC.x = param1 >> 1;
         this.animationMC.y = param2 >> 1;
      }
      
      override protected function onDispose() : void
      {
         this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,null);
         this.animationMC = null;
         super.onDispose();
      }
      
      private function onAnimationComplete() : void
      {
         this.animationMC.addFrameScript(this.animationMC.totalFrames - 1,null);
         stop();
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
