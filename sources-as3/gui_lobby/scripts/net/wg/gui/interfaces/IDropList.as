package net.wg.gui.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IDropList extends IUIComponentEx
   {
       
      
      function highlightList() : void;
      
      function hideHighLight() : void;
      
      function get selectable() : Boolean;
      
      function set selectable(param1:Boolean) : void;
   }
}
