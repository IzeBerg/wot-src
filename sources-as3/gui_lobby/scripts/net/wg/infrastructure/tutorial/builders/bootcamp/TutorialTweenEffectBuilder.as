package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.generated.TUTORIAL_EFFECT_TYPES;
   import net.wg.gui.components.advanced.vo.TutorialTweenEffectVO;
   import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
   import scaleform.clik.motion.Tween;
   
   public class TutorialTweenEffectBuilder extends TutorialEffectBuilder
   {
       
      
      private var _model:TutorialTweenEffectVO = null;
      
      private var _tweenFactory:TweenFactory;
      
      private var _tweens:Vector.<Tween>;
      
      private var _tween:Tween = null;
      
      public function TutorialTweenEffectBuilder()
      {
         this._tweenFactory = new TweenFactory();
         this._tweens = new Vector.<Tween>(0);
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         this.disposeModel();
         this._tweenFactory = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         super.onDispose();
      }
      
      override protected function createEffect(param1:Object) : void
      {
         if(this._model != null)
         {
            this.disposeModel();
         }
         this._model = new TutorialTweenEffectVO(param1);
         this._tween = this._tweenFactory.getTweeForComponent(component,this._model);
         this._tweens.push(this._tween);
         this._tween.onComplete = this.onTweenComplete;
      }
      
      private function disposeModel() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
            this._model = null;
         }
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         App.tutorialMgr.onEffectComplete(DisplayObject(param1.target),TUTORIAL_EFFECT_TYPES.TWEEN);
      }
      
      protected function get tween() : Tween
      {
         return this._tween;
      }
      
      protected function set tween(param1:Tween) : void
      {
         this._tween = param1;
      }
   }
}
