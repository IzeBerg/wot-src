package net.wg.infrastructure.base
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.base.meta.impl.BaseDAAPIComponentMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   import net.wg.infrastructure.interfaces.IBaseDAAPIComponent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IGraphicsOptimizationComponent;
   
   public class BaseDAAPIComponent extends BaseDAAPIComponentMeta implements IBaseDAAPIComponent, IGraphicsOptimizationComponent
   {
       
      
      private var _isDAAPIInited:Boolean = false;
      
      public function BaseDAAPIComponent()
      {
         super();
      }
      
      public final function as_populate() : void
      {
         try
         {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
            this._isDAAPIInited = true;
            this.onPopulate();
            App.graphicsOptimizationMgr.register(this);
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
         }
         catch(error:WGGUIException)
         {
            DebugUtils.LOG_WARNING(error.getStackTrace());
         }
         catch(error:Error)
         {
            DebugUtils.LOG_ERROR(error.getStackTrace());
         }
      }
      
      public final function as_dispose() : void
      {
         try
         {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            dispose();
            if(parent)
            {
               parent.removeChild(this);
            }
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
         }
         catch(error:WGGUIException)
         {
            DebugUtils.LOG_WARNING(error.getStackTrace());
         }
         catch(error:Error)
         {
            DebugUtils.LOG_ERROR(error.getStackTrace());
         }
      }
      
      public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible || !stage)
         {
            return null;
         }
         return new <Rectangle>[getBounds(App.stage)];
      }
      
      public function get disposed() : Boolean
      {
         return isDisposed();
      }
      
      protected function onPopulate() : void
      {
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      protected function getComponentVo(param1:String, param2:IDAAPIModule) : Object
      {
         return {
            "alias":param1,
            "component":param2
         };
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         App.utils.commons.releaseReferences(this);
      }
   }
}
