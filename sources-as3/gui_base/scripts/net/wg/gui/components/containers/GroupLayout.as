package net.wg.gui.components.containers
{
   import net.wg.infrastructure.interfaces.IBaseLayout;
   
   public class GroupLayout implements IBaseLayout
   {
       
      
      protected var _target:Group;
      
      private var _gap:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function GroupLayout()
      {
         super();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this._target = null;
      }
      
      public function invokeLayout() : Object
      {
         return null;
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = Group(param1);
      }
      
      public function get gap() : int
      {
         return this._gap;
      }
      
      public function set gap(param1:int) : void
      {
         this._gap = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
