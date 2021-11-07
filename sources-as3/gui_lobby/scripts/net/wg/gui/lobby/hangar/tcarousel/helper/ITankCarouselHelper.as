package net.wg.gui.lobby.hangar.tcarousel.helper
{
   import scaleform.clik.utils.Padding;
   
   public interface ITankCarouselHelper
   {
       
      
      function get linkRenderer() : String;
      
      function get rendererWidth() : int;
      
      function get rendererHeight() : int;
      
      function get horizontalGap() : int;
      
      function get verticalGap() : int;
      
      function get padding() : Padding;
      
      function get rendererVisibleHeight() : int;
      
      function get rendererHeightDiff() : int;
   }
}
