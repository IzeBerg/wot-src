package net.wg.infrastructure.tutorial.builders
{
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.tutorial.TutorialHint;
   import net.wg.gui.components.advanced.vo.TutorialHintVO;
   
   public class TutorialHintBuilder extends TutorialEffectBuilder
   {
      
      public static const HINT_GLOW_OFFSET:int = 13;
      
      private static const EMPTY_POINT:Point = new Point();
       
      
      private var _hint:TutorialHint = null;
      
      private var _model:TutorialHintVO = null;
      
      private var _componentPosition:Point;
      
      private var _componentWidth:Number = 0;
      
      private var _componentHeight:Number = 0;
      
      private var _hintChanged:Boolean = false;
      
      public function TutorialHintBuilder()
      {
         this._componentPosition = new Point();
         super();
      }
      
      override public function updateData(param1:Object) : void
      {
         super.updateData(param1);
         if(this._model.updateRuntime && component != null)
         {
            component.addEventListener(Event.ENTER_FRAME,this.onComponentEnterFrame);
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeHint();
         this.disposeModel();
         if(component != null)
         {
            component.removeEventListener(Event.ENTER_FRAME,this.onComponentEnterFrame);
         }
         this._componentPosition = null;
         super.onDispose();
      }
      
      override public function externalUpdate() : void
      {
         super.externalUpdate();
         this.onViewResize();
      }
      
      override protected function onViewResize() : void
      {
         if(component != null)
         {
            this.layoutHint();
         }
      }
      
      override protected function createEffect(param1:Object) : void
      {
         if(this._model == null || param1 != null && this._model.uniqueID != param1.uniqueID)
         {
            this.disposeModel();
            this._model = new TutorialHintVO(param1);
            this.createAndLayoutHint();
         }
         this._hint.show();
      }
      
      override protected function removeEffect() : void
      {
         if(this._hint != null)
         {
            this._hint.hide();
         }
         if(this._model.updateRuntime && component != null)
         {
            component.removeEventListener(Event.ENTER_FRAME,this.onComponentEnterFrame);
         }
      }
      
      protected function layoutHint() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(component == null)
         {
            return;
         }
         var _loc1_:Point = component.localToGlobal(EMPTY_POINT);
         _loc1_ = view.globalToLocal(_loc1_);
         if(this._componentPosition.x != _loc1_.x || this._componentPosition.y != _loc1_.y || this._componentWidth != component.width || this._componentHeight != component.height)
         {
            this._componentPosition.x = _loc1_.x;
            this._componentPosition.y = _loc1_.y;
            this._componentWidth = component.width;
            this._componentHeight = component.height;
            _loc2_ = Number(component.scaleX) || Number(1);
            _loc3_ = Number(component.scaleY) || Number(1);
            this._hint.x = _loc1_.x - HINT_GLOW_OFFSET + this._model.padding.left * _loc2_ | 0;
            this._hint.y = _loc1_.y - HINT_GLOW_OFFSET + this._model.padding.top * _loc3_ | 0;
            _loc4_ = component.width - (this._model.padding.left + this._model.padding.right) * _loc2_ | 0;
            _loc5_ = component.height - (this._model.padding.top + this._model.padding.bottom) * _loc3_ | 0;
            this._hint.setSize(_loc4_,_loc5_);
            this._hintChanged = true;
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
      
      private function disposeHint() : void
      {
         if(this._hint != null)
         {
            view.removeChild(this._hint);
            this._hint.dispose();
            this._hint = null;
         }
      }
      
      private function createAndLayoutHint() : void
      {
         this.disposeHint();
         this._hint = App.utils.classFactory.getComponent(Linkages.TUTORIAL_HINT_UI,TutorialHint,{"model":this._model});
         App.utils.asserter.assertNotNull(this._hint,"_hint" + Errors.CANT_NULL);
         view.addChild(this._hint);
         this.layoutHint();
      }
      
      private function updateHintRuntime() : void
      {
         var _loc1_:Number = NaN;
         this.layoutHint();
         if(this._hintChanged && this._model.checkViewArea && view.width > 0)
         {
            _loc1_ = component.width - this._model.padding.left - this._model.padding.right;
            if(this._hint.x < -_loc1_ - HINT_GLOW_OFFSET)
            {
               this._hint.x = -_loc1_ - HINT_GLOW_OFFSET;
               this._hint.hideTextRuntime(true);
            }
            else if(this._hint.x > view.width - HINT_GLOW_OFFSET)
            {
               this._hint.x = view.width - HINT_GLOW_OFFSET;
               this._hint.hideTextRuntime(true);
            }
            else
            {
               this._hint.hideTextRuntime(false);
            }
            if(this._model.arrowDir == Directions.LEFT && this._hint.x < -HINT_GLOW_OFFSET - this._hint.expectedBorderLeft)
            {
               this._hint.forcedDirection = Directions.RIGHT;
            }
            else if(this._model.arrowDir == Directions.RIGHT && this._hint.x > view.width - HINT_GLOW_OFFSET - this._hint.expectedBorderRight)
            {
               this._hint.forcedDirection = Directions.LEFT;
            }
            else
            {
               this._hint.forcedDirection = null;
            }
         }
         this._hint.updateRuntime();
         this._hintChanged = false;
      }
      
      public function get model() : TutorialHintVO
      {
         return this._model;
      }
      
      public function get hint() : TutorialHint
      {
         return this._hint;
      }
      
      private function onComponentEnterFrame(param1:Event) : void
      {
         this.updateHintRuntime();
      }
   }
}
