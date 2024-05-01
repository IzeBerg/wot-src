package net.wg.infrastructure.tutorial.builders
{
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.tutorial.TutorialHint;
   import net.wg.gui.components.advanced.vo.TutorialHintVO;
   import net.wg.gui.components.common.HighlightRendererBase;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TutorialHintBuilder extends TutorialEffectBuilder
   {
      
      public static const HINT_GLOW_OFFSET:int = 13;
      
      private static const EMPTY_POINT:Point = new Point();
       
      
      private var _hint:TutorialHint = null;
      
      private var _hintHighLight:HighlightRendererBase = null;
      
      private var _model:TutorialHintVO = null;
      
      private var _componentPosition:Point;
      
      private var _componentWidth:Number = 0;
      
      private var _componentHeight:Number = 0;
      
      private var _hintChanged:Boolean = false;
      
      private var _classFactory:IClassFactory;
      
      public function TutorialHintBuilder()
      {
         this._componentPosition = new Point();
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override public function externalUpdate() : void
      {
         super.externalUpdate();
         this.onViewResize();
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
         this._classFactory = null;
         if(this._hintHighLight)
         {
            this._hintHighLight.dispose();
         }
         this._hintHighLight = null;
         this.disposeHint();
         this.disposeModel();
         if(component != null)
         {
            component.removeEventListener(Event.ENTER_FRAME,this.onComponentEnterFrame);
         }
         this._componentPosition = null;
         super.onDispose();
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
         if(this._hint)
         {
            this._hint.show();
         }
         if(this._hintHighLight != null)
         {
            this._hintHighLight.visible = true;
         }
      }
      
      override protected function removeEffect() : void
      {
         if(this._hint != null)
         {
            this._hint.hide();
         }
         if(this._hintHighLight != null)
         {
            this._hintHighLight.visible = false;
         }
         if(this._model != null && this._model.updateRuntime && component != null)
         {
            component.removeEventListener(Event.ENTER_FRAME,this.onComponentEnterFrame);
         }
      }
      
      protected function layoutHint() : void
      {
         var _loc1_:Point = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:PaddingVO = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(component == null)
         {
            return;
         }
         _loc1_ = component.localToGlobal(EMPTY_POINT);
         _loc1_ = view.globalToLocal(_loc1_);
         var _loc2_:Number = component.width * view.scaleX;
         var _loc3_:Number = component.height * view.scaleY;
         if(this._componentPosition.x != _loc1_.x || this._componentPosition.y != _loc1_.y || this._componentWidth != _loc2_ || this._componentHeight != _loc3_)
         {
            this._componentPosition.x = _loc1_.x;
            this._componentPosition.y = _loc1_.y;
            this._componentWidth = _loc2_;
            this._componentHeight = _loc3_;
            if(this._hint)
            {
               _loc4_ = 1 / view.scaleX;
               _loc5_ = 1 / view.scaleY;
               this._hint.scaleX = _loc4_;
               this._hint.scaleY = _loc5_;
               _loc6_ = this._model.padding;
               this._hint.x = _loc1_.x + (_loc6_.left - HINT_GLOW_OFFSET * _loc4_) | 0;
               this._hint.y = _loc1_.y + (_loc6_.top - HINT_GLOW_OFFSET * _loc5_) | 0;
               _loc7_ = this._componentWidth - _loc6_.left - _loc6_.right | 0;
               _loc8_ = this._componentHeight - _loc6_.top - _loc6_.bottom | 0;
               this._hint.setSize(_loc7_,_loc8_);
            }
            if(this._hintHighLight != null)
            {
               this.layoutHighLight();
            }
            this._hintChanged = true;
         }
      }
      
      private function layoutHighLight() : void
      {
         var _loc1_:Point = component.localToGlobal(new Point(0,0));
         _loc1_ = view.globalToLocal(_loc1_);
         var _loc2_:PaddingVO = this._model.padding;
         if(!_loc2_)
         {
            _loc2_ = new PaddingVO({});
         }
         this._hintHighLight.x = _loc1_.x + _loc2_.left | 0;
         this._hintHighLight.y = _loc1_.y + _loc2_.top | 0;
         this._hintHighLight.setProperties(component.width - _loc2_.left - _loc2_.right,component.height - _loc2_.top - _loc2_.bottom,false);
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
         if(this._hint)
         {
            view.removeChild(this._hint);
            this._hint.dispose();
            this._hint = null;
         }
         if(this._hintHighLight != null)
         {
            view.removeChild(this._hintHighLight);
            this._hintHighLight.dispose();
            this._hintHighLight = null;
         }
      }
      
      private function createAndLayoutHint() : void
      {
         this.disposeHint();
         this._componentPosition.x = this._componentPosition.y = 0;
         if(!this.model.hasArrow && StringUtils.isEmpty(this.model.hintText))
         {
            this._hintHighLight = this._classFactory.getComponent(Linkages.TUTORIAL_SIMPLE_HINT_UI,HighlightRendererBase);
            view.addChild(this._hintHighLight);
         }
         else
         {
            this._hint = this._classFactory.getComponent(Linkages.TUTORIAL_HINT_UI,TutorialHint,{"model":this._model});
            view.addChild(this._hint);
         }
         this.layoutHint();
      }
      
      private function updateHintRuntime() : void
      {
         var _loc1_:Number = NaN;
         this.layoutHint();
         if(this._hint)
         {
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
         }
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
