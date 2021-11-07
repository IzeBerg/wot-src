package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
   import scaleform.clik.motion.Tween;
   
   public class TutorialAmmunitionEffectBuilder extends TutorialEffectBuilder
   {
      
      private static const SHIFT_DURATION:Number = 250;
       
      
      private var _tweens:Vector.<Tween>;
      
      public function TutorialAmmunitionEffectBuilder()
      {
         this._tweens = new Vector.<Tween>(0);
         super();
      }
      
      override protected function onDispose() : void
      {
         this.disposeTweens();
         this._tweens = null;
         super.onDispose();
      }
      
      public function tweenToX(param1:Sprite, param2:Number) : void
      {
         var _loc3_:Tween = new Tween(SHIFT_DURATION,param1,{"x":param2},{
            "paused":false,
            "ease":Cubic.easeOut
         });
         _loc3_.fastTransform = false;
         this._tweens.push(_loc3_);
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
   }
}
