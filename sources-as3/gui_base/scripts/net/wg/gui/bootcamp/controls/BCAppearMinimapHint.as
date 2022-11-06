package net.wg.gui.bootcamp.controls
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.bootcamp.containers.TipHintAnimation;
   import net.wg.gui.bootcamp.events.AppearEvent;
   
   public class BCAppearMinimapHint extends BCHighlightRendererBase
   {
       
      
      public var animationMC:BCLobbyTintHint = null;
      
      public var hint:TipHintAnimation = null;
      
      private var _isStartAnimation:Boolean = false;
      
      public function BCAppearMinimapHint()
      {
         super();
         this.hint.setLabel(BOOTCAMP.PREBATTLE_HINT_MINIMAP);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.animationMC.isCycle = false;
         this.animationMC.addEventListener(Event.COMPLETE,this.onHintRendrererCompleteHandler);
      }
      
      override public function setProperties(param1:Number, param2:Number, param3:Boolean) : void
      {
         this.animationMC.setProperties(param1,param2,param3);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this.animationMC.removeEventListener(Event.COMPLETE,this.onHintRendrererCompleteHandler);
         this.animationMC.dispose();
         this.animationMC = null;
         this.hint.dispose();
         this.hint = null;
         super.onDispose();
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         if(!this._isStartAnimation)
         {
            this._isStartAnimation = true;
            dispatchEvent(new AppearEvent(AppearEvent.PREPARE,Values.EMPTY_STR,Values.EMPTY_STR,true));
         }
      }
      
      private function onHintRendrererCompleteHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}
