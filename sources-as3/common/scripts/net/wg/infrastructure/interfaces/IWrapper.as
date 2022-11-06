package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IWrapper extends IManagedContent, IDisposable
   {
       
      
      function set wrapperContent(param1:IAbstractWrapperView) : void;
      
      function get wrapperContent() : IAbstractWrapperView;
   }
}
