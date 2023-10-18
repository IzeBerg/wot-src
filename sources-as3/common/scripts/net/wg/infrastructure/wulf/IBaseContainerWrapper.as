package net.wg.infrastructure.wulf
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.IView;
   
   public interface IBaseContainerWrapper extends IUIComponentEx, IView
   {
       
      
      function setAsConfig(param1:Object) : void;
      
      function stopTransition() : void;
      
      function get hitRect() : Rectangle;
      
      function get wrapper() : IViewWrapper;
      
      function get isInTransition() : Boolean;
   }
}
