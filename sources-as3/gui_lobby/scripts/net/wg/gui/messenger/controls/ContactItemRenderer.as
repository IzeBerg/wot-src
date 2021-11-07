package net.wg.gui.messenger.controls
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Cursors;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.messenger.data.IContactItemRenderer;
   import scaleform.clik.core.UIComponent;
   
   public class ContactItemRenderer extends SoundListItemRenderer implements IContactItemRenderer
   {
      
      protected static const DRAGGING_ITEM_INV:String = "dIInv";
       
      
      public var background:MovieClip;
      
      protected var draggedItemId:Number = NaN;
      
      public function ContactItemRenderer()
      {
         super();
      }
      
      public function setDragStart() : void
      {
         this.background.alpha = 0.5;
      }
      
      public function setDraggingItemId(param1:Number) : void
      {
         if(this.draggedItemId != param1)
         {
            this.draggedItemId = param1;
            invalidate(DRAGGING_ITEM_INV);
         }
      }
      
      public function getCurrentContentItem() : UIComponent
      {
         return null;
      }
      
      public function get getCursorType() : String
      {
         return Cursors.DRAG_OPEN;
      }
   }
}
