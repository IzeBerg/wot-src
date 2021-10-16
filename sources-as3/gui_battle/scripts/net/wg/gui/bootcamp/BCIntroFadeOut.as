package net.wg.gui.bootcamp
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import net.wg.infrastructure.base.meta.IBCIntroFadeOutMeta;
   import net.wg.infrastructure.base.meta.impl.BCIntroFadeOutMeta;
   import scaleform.clik.motion.Tween;
   
   public class BCIntroFadeOut extends BCIntroFadeOutMeta implements IBCIntroFadeOutMeta
   {
      
      private static const INTRO_INFO_CHANGED:String = "infoChanged";
       
      
      public var background:Sprite = null;
      
      private var _tween:Tween;
      
      private var _duration:Number = -1.0;
      
      public function BCIntroFadeOut()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.background.width = param1;
         this.background.height = param2;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INTRO_INFO_CHANGED))
         {
            this.fadeInBg(this._duration);
         }
      }
      
      override protected function onDispose() : void
      {
         this.removeTween();
         this.background = null;
         super.onDispose();
      }
      
      public function as_startFadeout(param1:Number) : void
      {
         this._duration = param1;
         invalidate(INTRO_INFO_CHANGED);
      }
      
      private function fadeInBg(param1:Number) : void
      {
         this.removeTween();
         this._tween = new Tween(param1,this.background,{"alpha":0},{
            "paused":false,
            "ease":Cubic.easeOut,
            "onComplete":this.onFadeInTweenFinished
         });
      }
      
      private function onFadeInTweenFinished() : void
      {
         finishedS();
      }
      
      private function removeTween() : void
      {
         if(this._tween != null)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
   }
}
