package net.wg.gui.lobby.missions
{
   import fl.motion.easing.Cubic;
   import flash.display.InteractiveObject;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.events.ComponentEvent;
   import scaleform.clik.motion.Tween;
   
   public class MissionsGFContainerView extends GFInjectComponent implements IViewStackContent
   {
      
      protected static const SMALL_FADE_IN_DELAY:Number = 250;
      
      private static const FADE_IN_DURATION:Number = 1500;
       
      
      private var _fadeInTween:Tween;
      
      private var _hasBeenShownBefore:Boolean = false;
      
      public function MissionsGFContainerView()
      {
         super();
         setManageSize(true);
         addEventListener(ComponentEvent.SHOW,this.onShowHandler);
      }
      
      private function onShowHandler(param1:ComponentEvent) : void
      {
         this.clearFadeInTween();
         this.playFadeInTween();
      }
      
      private function clearFadeInTween() : void
      {
         if(this._fadeInTween)
         {
            this._fadeInTween.dispose();
            this._fadeInTween = null;
         }
      }
      
      protected function setFadeInTween(param1:int) : void
      {
         this._fadeInTween = new Tween(FADE_IN_DURATION,this,{"alpha":1},{
            "paused":false,
            "ease":Cubic.easeOut,
            "delay":param1,
            "onComplete":null
         });
         this._fadeInTween.fastTransform = false;
      }
      
      protected function playFadeInTween() : void
      {
         alpha = 0;
         var _loc1_:int = !!this._hasBeenShownBefore ? int(SMALL_FADE_IN_DELAY) : int(0);
         this.setFadeInTween(_loc1_);
         this._hasBeenShownBefore = true;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function update(param1:Object) : void
      {
      }
   }
}
