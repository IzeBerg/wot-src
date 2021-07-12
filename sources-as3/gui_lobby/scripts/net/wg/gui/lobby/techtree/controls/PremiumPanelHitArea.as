package net.wg.gui.lobby.techtree.controls
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import net.wg.data.constants.DragType;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   
   public class PremiumPanelHitArea extends Sprite implements IDraggable
   {
       
      
      public function PremiumPanelHitArea()
      {
         super();
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
      }
      
      public function onEndDrag() : void
      {
      }
      
      public function onStartDrag() : void
      {
      }
   }
}
