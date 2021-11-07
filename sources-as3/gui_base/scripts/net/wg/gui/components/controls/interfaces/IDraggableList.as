package net.wg.gui.components.controls.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   
   public interface IDraggableList extends IDraggable
   {
       
      
      function set isMoving(param1:Boolean) : void;
      
      function get isMoving() : Boolean;
      
      function set isSliding(param1:Boolean) : void;
      
      function get isSliding() : Boolean;
   }
}
