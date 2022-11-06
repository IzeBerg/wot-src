package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.IWaitingViewMeta;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IView;
   
   public interface IWaitingView extends IWaitingViewMeta, IUIComponentEx, IView
   {
       
      
      function get isOnStage() : Boolean;
      
      function get isFocusable() : Boolean;
   }
}
