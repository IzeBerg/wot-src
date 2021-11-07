package net.wg.infrastructure.base
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.impl.BaseDAAPIModuleMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.exceptions.base.WGGUIException;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   [Event(name="onAfterDispose",type="net.wg.infrastructure.events.LifeCycleEvent")]
   [Event(name="onBeforeDispose",type="net.wg.infrastructure.events.LifeCycleEvent")]
   [Event(name="onAfterPopulate",type="net.wg.infrastructure.events.LifeCycleEvent")]
   [Event(name="onBeforePopulate",type="net.wg.infrastructure.events.LifeCycleEvent")]
   public class BaseDAAPIModule extends BaseDAAPIModuleMeta implements IDAAPIModule
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _isDAAPIInited:Boolean = false;
      
      public function BaseDAAPIModule()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function onPopulate() : void
      {
      }
      
      protected function onDispose() : void
      {
      }
      
      [Event(name="onAfterPopulate",type="net.wg.infrastructure.events.LifeCycleEvent")]
      [Event(name="onBeforePopulate",type="net.wg.infrastructure.events.LifeCycleEvent")]
      public final function as_populate() : void
      {
         try
         {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
            this._isDAAPIInited = true;
            this.onPopulate();
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
      
      [Event(name="onAfterDispose",type="net.wg.infrastructure.events.LifeCycleEvent")]
      [Event(name="onBeforeDispose",type="net.wg.infrastructure.events.LifeCycleEvent")]
      public final function as_dispose() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
         this.onDispose();
         this._disposed = true;
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
      }
      
      protected final function assert(param1:Boolean, param2:String = "failed assert") : void
      {
         App.utils.asserter.assert(param1,param2);
      }
      
      protected final function assertNotNull(param1:Object, param2:String = "object") : void
      {
         App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL);
      }
      
      protected final function assertNull(param1:Object, param2:String = "object") : void
      {
         App.utils.asserter.assertNull(param1,param2 + Errors.MUST_NULL);
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
   }
}
