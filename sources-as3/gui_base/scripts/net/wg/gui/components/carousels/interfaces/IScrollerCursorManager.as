package net.wg.gui.components.carousels.interfaces
{
   import flash.geom.Rectangle;
   import net.wg.infrastructure.helpers.interfaces.IDragDelegate;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   
   public interface IScrollerCursorManager extends IDragDelegate, IDragDropHitArea
   {
       
      
      function startTouchScroll() : void;
      
      function stopTouchScroll() : void;
      
      function setTouchRect(param1:Rectangle) : void;
      
      function get enable() : Boolean;
      
      function set enable(param1:Boolean) : void;
   }
}
