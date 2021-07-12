package net.wg.gui.bootcamp.interfaces
{
   import net.wg.infrastructure.interfaces.IDisplayObjectContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IAnimatedRenderer extends IDisplayObjectContainer, IDisposable
   {
       
      
      function get text() : String;
      
      function set text(param1:String) : void;
      
      function set htmlText(param1:String) : void;
      
      function get contentHeight() : int;
      
      function get contentWidth() : int;
   }
}
