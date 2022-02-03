package net.wg.infrastructure.base
{
   import net.wg.infrastructure.interfaces.IBaseLayout;
   
   public class BaseLayout implements IBaseLayout
   {
       
      
      private var _target:Object;
      
      private var _disposed:Boolean = false;
      
      public function BaseLayout()
      {
         super();
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function invokeLayout() : Object
      {
         return null;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._target = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
