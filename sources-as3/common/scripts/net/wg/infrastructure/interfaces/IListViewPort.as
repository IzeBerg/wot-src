package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface IListViewPort extends IViewPort
   {
       
      
      function get owner() : IUIComponentEx;
      
      function set owner(param1:IUIComponentEx) : void;
      
      function set itemRendererFactory(param1:Class) : void;
      
      function get dataProvider() : IDataProvider;
      
      function set dataProvider(param1:IDataProvider) : void;
      
      function set tooltipDecorator(param1:ITooltipMgr) : void;
   }
}
