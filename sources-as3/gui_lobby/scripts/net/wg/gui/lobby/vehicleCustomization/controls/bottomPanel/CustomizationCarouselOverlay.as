package net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.components.TextWrapper;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationCarouselOverlay extends UIComponentEx
   {
      
      private static const NORMAL_HINT_Y_POS:int = 78;
      
      private static const MINRES_HINT_Y_POS:int = 65;
      
      private static const HINT_TWEEN_DELAY:int = 500;
       
      
      public var bg:MovieClip = null;
      
      public var scrollHint:TextWrapper = null;
      
      private var _hintTween:Tween;
      
      private var _isPlayingHide:Boolean;
      
      private var _isMinResolution:Boolean;
      
      public function CustomizationCarouselOverlay()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.scrollHint.dispose();
         this.scrollHint = null;
         this.removeTween();
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.scrollHint.x = this.bg.width >> 1;
            this.scrollHint.y = !!this._isMinResolution ? Number(MINRES_HINT_Y_POS) : Number(NORMAL_HINT_Y_POS);
         }
      }
      
      public function show(param1:String = null, param2:Boolean = false) : void
      {
         this.scrollHint.visible = param2;
         if(param2)
         {
            this.scrollHint.tf.htmlText = param1;
         }
         alpha = 0;
         visible = true;
         this.removeTween();
         this._hintTween = new Tween(HINT_TWEEN_DELAY,this,{"alpha":1});
      }
      
      public function hide() : void
      {
         if(this._isPlayingHide || !visible)
         {
            return;
         }
         this._isPlayingHide = true;
         this.removeTween();
         this._hintTween = new Tween(HINT_TWEEN_DELAY,this,{"alpha":0},{"onComplete":this.onHintHideComplete});
      }
      
      public function updateSize(param1:Number, param2:Number, param3:Boolean) : void
      {
         this._isMinResolution = param3;
         this.bg.width = param1;
         invalidate(InvalidationType.SIZE);
      }
      
      private function onHintHideComplete() : void
      {
         visible = false;
         this._isPlayingHide = false;
      }
      
      private function removeTween() : void
      {
         if(this._hintTween)
         {
            this._hintTween.paused = true;
            this._hintTween.dispose();
            this._hintTween = null;
         }
      }
   }
}
