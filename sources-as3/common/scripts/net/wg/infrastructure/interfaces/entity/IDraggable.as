package net.wg.infrastructure.interfaces.entity
{
   public interface IDraggable extends IDragDropHitArea
   {
       
      
      function onStartDrag() : void;
      
      function onDragging(param1:Number, param2:Number) : void;
      
      function onEndDrag() : void;
      
      function getDragType() : String;
   }
}
