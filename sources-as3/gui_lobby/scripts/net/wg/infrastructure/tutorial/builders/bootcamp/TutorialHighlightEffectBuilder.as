package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.controls.BCHighlightRendererBase;
   import net.wg.gui.components.advanced.vo.TutorialHighlightEffectVO;
   import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TutorialHighlightEffectBuilder extends TutorialEffectBuilder
   {
      
      private static const HINT:String = "_hint";
       
      
      private var _model:TutorialHighlightEffectVO = null;
      
      private var _hint:BCHighlightRendererBase = null;
      
      private var _rect:Matrix = null;
      
      private const DEFAULT_LINKAGE:String = "BCLobbyHintUI";
      
      public function TutorialHighlightEffectBuilder()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.removeEffect();
         super.onDispose();
      }
      
      override protected function onViewResize() : void
      {
         if(component != null && this._model != null)
         {
            this.layoutHint();
         }
      }
      
      override protected function createEffect(param1:Object) : void
      {
         this.removeEffect();
         this._model = new TutorialHighlightEffectVO(param1);
         var _loc2_:String = this._model.customLinkage;
         var _loc3_:String = !!StringUtils.isEmpty(_loc2_) ? this.DEFAULT_LINKAGE : _loc2_;
         this._hint = App.utils.classFactory.getComponent(_loc3_,BCHighlightRendererBase);
         App.utils.asserter.assertNotNull(this._hint,HINT + Errors.CANT_NULL);
         this._rect = component.transform.concatenatedMatrix;
         view.addChild(this._hint);
         component.addEventListener(Event.RENDER,this.onComponentRenderHandler);
         this.layoutHint();
      }
      
      override protected function removeEffect() : void
      {
         this.disposeHint();
         this.disposeModel();
         if(component != null)
         {
            component.removeEventListener(Event.RENDER,this.onComponentRenderHandler);
         }
      }
      
      override public function externalUpdate() : void
      {
         super.externalUpdate();
         this.onViewResize();
      }
      
      protected function layoutHint() : void
      {
         var _loc1_:Point = component.localToGlobal(new Point(0,0));
         _loc1_ = view.globalToLocal(_loc1_);
         var _loc2_:PaddingVO = this._model.padding;
         if(!_loc2_)
         {
            _loc2_ = new PaddingVO({});
         }
         this._hint.x = _loc1_.x + _loc2_.left | 0;
         this._hint.y = _loc1_.y + _loc2_.top | 0;
         this._hint.setProperties(component.width - _loc2_.left - _loc2_.right,component.height - _loc2_.top - _loc2_.bottom,!this._model.hideBorder);
      }
      
      private function disposeHint() : void
      {
         if(this._hint != null)
         {
            view.removeChild(this._hint);
            this._hint.dispose();
            this._hint = null;
         }
      }
      
      private function disposeModel() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
            this._model = null;
         }
      }
      
      private function onComponentRenderHandler(param1:Event) : void
      {
         var _loc2_:Matrix = null;
         if(component != null && this._model != null)
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
