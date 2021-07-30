package net.wg.gui.components.controls.scroller.data
{
   public interface IScrollerItemRendererData
   {
       
      
      function get hasExtendedInfo() : Boolean;
      
      function get isItemExtended() : Boolean;
      
      function get isItemExtendendable() : Boolean;
      
      function dataBasedWidth(param1:Boolean, param2:uint) : int;
   }
}
