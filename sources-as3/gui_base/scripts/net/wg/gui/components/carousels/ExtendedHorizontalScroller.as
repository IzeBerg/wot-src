package net.wg.gui.components.carousels
{
   public class ExtendedHorizontalScroller extends HorizontalScroller
   {
       
      
      public function ExtendedHorizontalScroller()
      {
         super();
      }
      
      override public function get viewPortClass() : Class
      {
         return !!useExtendedViewPort ? ExtendedHorizontalScrollerViewPort : HorizontalScrollerViewPort;
      }
   }
}
