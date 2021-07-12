package net.wg.gui.components.containers
{
   import net.wg.infrastructure.interfaces.IBaseLayout;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface IGroupEx extends IUIComponentEx
   {
       
      
      function invalidateLayout() : void;
      
      function getProviderLength() : uint;
      
      function get layout() : IBaseLayout;
      
      function set layout(param1:IBaseLayout) : void;
      
      function set itemRendererLinkage(param1:String) : void;
      
      function set dataProvider(param1:IDataProvider) : void;
   }
}
