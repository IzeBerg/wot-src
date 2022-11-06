package net.wg.gui.components.carousels.interfaces
{
   import net.wg.infrastructure.interfaces.IListViewPort;
   
   public interface IScrollerViewPort extends IListViewPort, IScrollerViewPortBase
   {
       
      
      function get rendererWidth() : int;
      
      function set rendererWidth(param1:int) : void;
      
      function get rendererHeight() : int;
      
      function set rendererHeight(param1:int) : void;
      
      function get horizontalGap() : int;
      
      function set horizontalGap(param1:int) : void;
      
      function get verticalGap() : int;
      
      function set verticalGap(param1:int) : void;
      
      function get selectedIndex() : int;
      
      function set selectedIndex(param1:int) : void;
      
      function get rowCount() : int;
      
      function set rowCount(param1:int) : void;
      
      function get columnCount() : int;
      
      function set columnCount(param1:int) : void;
      
      function get startGap() : int;
      
      function set startGap(param1:int) : void;
      
      function get endGap() : int;
      
      function set endGap(param1:int) : void;
   }
}
