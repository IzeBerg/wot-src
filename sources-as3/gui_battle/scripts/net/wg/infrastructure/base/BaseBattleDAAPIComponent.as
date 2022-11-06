package net.wg.infrastructure.base
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.base.meta.IBaseDAAPIComponentMeta;
   import net.wg.infrastructure.base.meta.impl.BaseBattleDAAPIComponentMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.interfaces.IGraphicsOptimizationComponent;
   
   public class BaseBattleDAAPIComponent extends BaseBattleDAAPIComponentMeta implements IBaseDAAPIComponentMeta, IDAAPIModule, IGraphicsOptimizationComponent
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _isDAAPIInited:Boolean = false;
      
      public function BaseBattleDAAPIComponent()
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
            this._disposed = true;
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
         if(!visible)
         {
            return null;
         }
         return new <Rectangle>[getBounds(App.stage)];
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
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
   }
}
