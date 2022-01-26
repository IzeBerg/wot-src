package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.TUTORIAL_EFFECT_TYPES;
   import net.wg.gui.bootcamp.controls.BCHighlightRendererBase;
   import net.wg.gui.components.advanced.vo.TutorialClipEffectVO;
   import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
   
   public class TutorialClipEffectBuilder extends TutorialEffectBuilder
   {
       
      
      private var _model:TutorialClipEffectVO = null;
      
      private var _clip:BCHighlightRendererBase = null;
      
      private var _rect:Matrix = null;
      
      public function TutorialClipEffectBuilder()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(component != null)
         {
            component.removeEventListener(Event.RENDER,this.onComponentRenderHandler);
         }
         this._rect = null;
         this.disposeModel();
         this.disposeClip();
         super.onDispose();
      }
      
      override protected function onViewResize() : void
      {
         if(component != null && this._model != null && this._clip != null)
         {
            this.layoutHint();
         }
      }
      
      override public function externalUpdate() : void
      {
         super.externalUpdate();
         this.onViewResize();
      }
      
      override protected function createEffect(param1:Object) : void
      {
         this.disposeModel();
         this.disposeClip();
         this._model = new TutorialClipEffectVO(param1);
         this._clip = App.utils.classFactory.getComponent(this._model.linkage,BCHighlightRendererBase);
         view.addChild(this._clip);
         this._clip.addEventListener(Event.COMPLETE,this.onClipCompleteHandler);
         this._rect = component.transform.concatenatedMatrix;
         component.addEventListener(Event.RENDER,this.onComponentRenderHandler);
         this.layoutHint();
      }
      
      protected function layoutHint() : void
      {
         var _loc1_:Rectangle = null;
         _loc1_ = component.getRect(DisplayObject(view));
         this._clip.x = _loc1_.x + (_loc1_.width >> 1) + this._model.offsetX | 0;
         this._clip.y = _loc1_.y + (_loc1_.height >> 1) + this._model.offsetY | 0;
      }
      
      private function disposeModel() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
            this._model = null;
         }
      }
      
      private function disposeClip() : void
      {
         if(this._clip != null)
         {
            this._clip.stop();
            view.removeChild(this._clip);
            this._clip.removeEventListener(Event.COMPLETE,this.onClipCompleteHandler);
            this._clip.dispose();
            this._clip = null;
         }
      }
      
      private function onClipCompleteHandler(param1:Event) : void
      {
         this.disposeClip();
         App.tutorialMgr.onEffectComplete(component,TUTORIAL_EFFECT_TYPES.CLIP);
      }
      
      private function onComponentRenderHandler(param1:Event) : void
      {
         var _loc2_:Matrix = null;
         if(component != null && this._model != null && this._clip != null)
         {
            _loc2_ = component.transform.concatenatedMatrix;
            if(_loc2_.tx != this._rect.tx || _loc2_.ty != this._rect.ty)
            {
               this._rect = _loc2_;
               this.layoutHint();
            }
         }
      }
   }
}
