package net.wg.infrastructure.interfaces
{
   public interface IManagedContent extends IUIComponentEx
   {
       
      
      function get isModal() : Boolean;
      
      function get modalAlpha() : Number;
      
      function get sourceView() : IView;
      
      function get containerContent() : IManagedContent;
   }
}
