package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.vo.TutorialOverlayEffectVO;
   import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
   
   public class TutorialOverlayEffectBuilder extends TutorialEffectBuilder
   {
      
      private static const FILL_ALPHA:Number = 0.7;
       
      
      private var _model:TutorialOverlayEffectVO = null;
      
      private var _overlay:MovieClip;
      
      public function TutorialOverlayEffectBuilder()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.disposeModel();
         this._overlay = null;
         super.onDispose();
      }
      
      override protected function createEffect(param1:Object) : void
      {
         if(this._model != null)
         {
            this.disposeModel();
         }
         if(!this._overlay)
         {
            this._overlay = new MovieClip();
         }
         this._model = new TutorialOverlayEffectVO(param1);
         view.addChild(this._overlay);
         var _loc2_:Graphics = this._overlay.graphics;
         _loc2_.clear();
         _loc2_.beginFill(0,FILL_ALPHA);
         _loc2_.drawRect(this._model.x,this._model.y,this._model.width,this._model.height);
         _loc2_.endFill();
      }
      
      private function disposeModel() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
            this._model = null;
         }
      }
   }
}
