package net.wg.infrastructure.base
{
   import net.wg.infrastructure.interfaces.IBaseLayout;
   
   public class BaseLayout implements IBaseLayout
   {
       
      
      private var _target:Object;
      
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
         this._target = null;
      }
   }
}
