package net.wg.gui.bootcamp.controls
{
   import flash.events.Event;
   
   public class BCCirclesTintHint extends BCHighlightRendererBase
   {
       
      
      public var animationMC:BCLobbyTintHint = null;
      
      public function BCCirclesTintHint()
      {
         super();
         this.animationMC.isCycle = false;
         this.animationMC.addEventListener(Event.COMPLETE,this.onHintRendrererCompleteHandler);
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         this.animationMC.setProperties(param1,param2,param3);
      }
      
      override protected function onDispose() : void
      {
         this.animationMC.removeEventListener(Event.COMPLETE,this.onHintRendrererCompleteHandler);
         this.animationMC.dispose();
         this.animationMC = null;
         super.onDispose();
      }
      
      private function onHintRendrererCompleteHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
