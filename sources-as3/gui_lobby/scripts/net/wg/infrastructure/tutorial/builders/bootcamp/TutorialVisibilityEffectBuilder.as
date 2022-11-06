package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.components.advanced.vo.TutorialDisplayEffectVO;
   import net.wg.infrastructure.tutorial.builders.TutorialEffectBuilder;
   import scaleform.clik.events.ComponentEvent;
   
   public class TutorialVisibilityEffectBuilder extends TutorialEffectBuilder
   {
       
      
      private var _model:TutorialDisplayEffectVO = null;
      
      public function TutorialVisibilityEffectBuilder()
      {
         super();
      }
      
      override public function set component(param1:DisplayObject) : void
      {
         super.component = param1;
         param1.addEventListener(ComponentEvent.SHOW,this.onComponentShowHandler);
      }
      
      override protected function onDispose() : void
      {
         if(component)
         {
            component.removeEventListener(ComponentEvent.SHOW,this.onComponentShowHandler);
         }
         this.disposeModel();
         super.onDispose();
      }
      
      override protected function createEffect(param1:Object) : void
      {
         this.disposeModel();
         this._model = new TutorialDisplayEffectVO(param1);
         this.updateComponent();
      }
      
      protected function updateComponent() : void
      {
         if(component.visible != this._model.visible)
         {
            component.visible = this._model.visible;
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
      
      private function onComponentShowHandler(param1:Event) : void
      {
         this.updateComponent();
      }
   }
}
