package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IWrapperViewMeta;
   
   public interface IAbstractWrapperView extends IWrapperViewMeta, IView
   {
       
      
      function getWrapperLinkage() : String;
      
      function set wrapper(param1:IWrapper) : void;
      
      function get wrapper() : IWrapper;
   }
}
