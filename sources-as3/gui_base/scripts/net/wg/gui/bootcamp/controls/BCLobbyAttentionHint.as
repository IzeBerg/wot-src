package net.wg.gui.bootcamp.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.bootcamp.events.AppearEvent;
   
   public class BCLobbyAttentionHint extends BCCirclesTintHint
   {
      
      private static const ATTENTION_SCALE:Number = 2;
      
      private static const ATTENTION_LINES:Number = 4;
      
      private static const TWEEN_TIME:Number = 600;
       
      
      public var flare:MovieClip = null;
      
      public function BCLobbyAttentionHint()
      {
         super();
         animationMC.longScale = ATTENTION_SCALE;
         animationMC.isCycle = true;
         animationMC.lines = ATTENTION_LINES;
         animationMC.tweenTime = TWEEN_TIME;
         animationMC.fastDisappear = true;
         animationMC.addEventListener(AppearEvent.PREPARE,this.onAnimationPrepareHandler);
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         super.setProperties(param1,param2,param3);
         this.flare.x = param1 >> 1;
         this.flare.y = param2 >> 1;
      }
      
      override protected function onDispose() : void
      {
         animationMC.removeEventListener(Event.COMPLETE,this.onAnimationPrepareHandler);
         this.flare = null;
         super.onDispose();
      }
      
      private function onAnimationPrepareHandler(param1:Event) : void
      {
         this.flare.gotoAndPlay(1);
      }
   }
}
