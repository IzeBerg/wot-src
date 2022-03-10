package net.wg.infrastructure.tutorial.builders
{
   import flash.display.DisplayObject;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.events.LifeCycleEvent;
   
   public class TutorialEffectBuilder extends TutorialBuilder
   {
      
      private static const COMPONENT_FOR_EFFECT:String = "component for effect";
       
      
      private var _component:DisplayObject = null;
      
      public function TutorialEffectBuilder()
      {
         super();
      }
      
      override public function stopEffect() : void
      {
         super.stopEffect();
         this.removeEffect();
      }
      
      override public function updateData(param1:Object) : void
      {
         this.createEffect(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._component != null)
         {
            this._component.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onComponentOnDisposeHandler);
            this._component = null;
         }
         super.onDispose();
      }
      
      override protected function onViewResize() : void
      {
      }
      
      protected function createEffect(param1:Object) : void
      {
      }
      
      protected function removeEffect() : void
      {
      }
      
      public function get component() : DisplayObject
      {
         return this._component;
      }
      
      override public function set component(param1:DisplayObject) : void
      {
         App.utils.asserter.assertNotNull(param1,COMPONENT_FOR_EFFECT + Errors.CANT_NULL);
         this._component = param1;
         this._component.addEventListener(LifeCycleEvent.ON_DISPOSE,this.onComponentOnDisposeHandler);
      }
      
      private function onComponentOnDisposeHandler(param1:LifeCycleEvent) : void
      {
         this.removeEffect();
         if(this._component != null)
         {
            this._component.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onComponentOnDisposeHandler);
            this._component = null;
         }
      }
   }
}
