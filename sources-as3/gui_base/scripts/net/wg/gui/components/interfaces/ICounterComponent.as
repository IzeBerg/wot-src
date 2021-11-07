package net.wg.gui.components.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface ICounterComponent extends IUIComponentEx
   {
       
      
      function get text() : String;
      
      function set text(param1:String) : void;
   }
}
