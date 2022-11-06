package net.wg.gui.components.carousels.interfaces
{
   import net.wg.infrastructure.interfaces.IViewPort;
   
   public interface IScrollerViewPortBase extends IViewPort
   {
       
      
      function usesLayoutController() : Boolean;
      
      function setLayoutController(param1:IScrollerLayoutController) : void;
      
      function get showRendererOnlyIfDataExists() : Boolean;
      
      function set showRendererOnlyIfDataExists(param1:Boolean) : void;
   }
}
