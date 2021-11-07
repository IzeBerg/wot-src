package net.wg.gui.components.carousels.interfaces
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public interface IScrollerLayoutController
   {
       
      
      function getLayout() : Vector.<Rectangle>;
      
      function getMaxExtents() : Point;
      
      function getLeftIndex(param1:int) : int;
      
      function getRightIndex(param1:int) : int;
   }
}
