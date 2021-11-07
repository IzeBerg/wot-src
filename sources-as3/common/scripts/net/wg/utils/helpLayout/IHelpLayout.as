package net.wg.utils.helpLayout
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IHelpLayout extends IDisposable
   {
       
      
      function isShown() : Boolean;
      
      function registerComponent(param1:IHelpLayoutComponent) : void;
      
      function unregisterComponent(param1:IHelpLayoutComponent) : void;
      
      function show() : void;
      
      function hide() : void;
   }
}
