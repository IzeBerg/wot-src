package net.wg.gui.messenger.data
{
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import scaleform.clik.core.UIComponent;
   
   public interface IContactItemRenderer extends IDropItem
   {
       
      
      function setDragStart() : void;
      
      function setDraggingItemId(param1:Number) : void;
      
      function getCurrentContentItem() : UIComponent;
   }
}
