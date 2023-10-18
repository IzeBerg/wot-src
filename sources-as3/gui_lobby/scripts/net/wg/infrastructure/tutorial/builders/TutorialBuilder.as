package net.wg.infrastructure.tutorial.builders
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.ITutorialBuilder;
   import net.wg.infrastructure.interfaces.ITutorialView;
   import net.wg.utils.IAssertable;
   
   public class TutorialBuilder extends EventDispatcher implements ITutorialBuilder
   {
       
      
      private var _view:ITutorialView = null;
      
      private var _asserter:IAssertable;
      
      private var _disposed:Boolean = false;
      
      public function TutorialBuilder()
      {
         super();
         this._asserter = App.utils.asserter;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function externalUpdate() : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setView(param1:ITutorialView) : void
      {
         this._asserter.assertNotNull(param1,"view for tutorial builder" + Errors.CANT_NULL);
         this._view = param1;
         if(param1.isResizable)
         {
            param1.addEventListener(Event.RESIZE,this.onViewResizeHandler);
         }
         param1.addEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewDisposeHandler);
      }
      
      public function stopEffect() : void
      {
      }
      
      public function updateData(param1:Object) : void
      {
         this._asserter.assertNotNull(param1,"data for tutorial builder" + Errors.CANT_NULL);
      }
      
      protected function onDispose() : void
      {
         if(this._view)
         {
            this._view.removeEventListener(Event.RESIZE,this.onViewResizeHandler);
            this._view.removeEventListener(LifeCycleEvent.ON_DISPOSE,this.onViewDisposeHandler);
            this._view = null;
         }
         this._asserter = null;
      }
      
      protected function onViewResize() : void
      {
         var _loc1_:String = "onViewResize" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc1_);
         throw new AbstractException(_loc1_);
      }
      
      public function set component(param1:DisplayObject) : void
      {
      }
      
      public function get view() : ITutorialView
      {
         return this._view;
      }
      
      private function onViewResizeHandler(param1:Event) : void
      {
         this.onViewResize();
      }
      
      private function onViewDisposeHandler(param1:LifeCycleEvent) : void
      {
         this.dispose();
      }
   }
}
