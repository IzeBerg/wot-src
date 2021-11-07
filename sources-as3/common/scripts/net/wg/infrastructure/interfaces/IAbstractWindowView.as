package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.IWindowViewMeta;
   
   public interface IAbstractWindowView extends IAbstractWrapperView, IWindowViewMeta
   {
       
      
      function handleWindowMinimize() : void;
      
      function handleWindowClose() : void;
      
      function setWindow(param1:IWindow) : void;
      
      function get window() : IWindow;
      
      function get canDrag() : Boolean;
      
      function get showWindowBgForm() : Boolean;
      
      function get showWindowBg() : Boolean;
      
      function get canMinimize() : Boolean;
      
      function get canResize() : Boolean;
      
      function get canClose() : Boolean;
      
      function get enabledCloseBtn() : Boolean;
      
      function get isCentered() : Boolean;
      
      function get geometry() : IWindowGeometry;
      
      function get isSourceTracked() : Boolean;
   }
}
