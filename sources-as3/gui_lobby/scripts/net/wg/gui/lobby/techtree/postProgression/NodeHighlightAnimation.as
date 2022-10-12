package net.wg.gui.lobby.techtree.postProgression
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class NodeHighlightAnimation extends UIComponentEx
   {
      
      private static const FADE_DURATION:int = 200;
       
      
      private var _fadeTween:Tween = null;
      
      private var _isShowingUp:Boolean;
      
      public function NodeHighlightAnimation()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = this.mouseEnabled = false;
         this.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.clearTween();
            if(this._isShowingUp)
            {
               this.visible = true;
               this._fadeTween = new Tween(FADE_DURATION,this,{"alpha":1});
            }
            else
            {
               this._fadeTween = new Tween(FADE_DURATION,this,{"alpha":0},{"onComplete":this.onFadeOutComplete});
            }
         }
      }
      
      private function clearTween() : void
      {
         if(this._fadeTween)
         {
            this._fadeTween.paused = true;
            this._fadeTween.dispose();
            this._fadeTween.onComplete = null;
            this._fadeTween = null;
         }
      }
      
      private function onFadeOutComplete() : void
      {
         this.visible = false;
      }
      
      public function get isHighlighted() : Boolean
      {
         return this._isShowingUp;
      }
      
      public function set isHighlighted(param1:Boolean) : void
      {
         if(this._isShowingUp == param1)
         {
            return;
         }
         this._isShowingUp = param1;
         invalidateState();
      }
   }
}
