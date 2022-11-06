package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IBaseLayout extends IDisposable
   {
       
      
      function set target(param1:Object) : void;
      
      function get target() : Object;
      
      function invokeLayout() : Object;
   }
}
