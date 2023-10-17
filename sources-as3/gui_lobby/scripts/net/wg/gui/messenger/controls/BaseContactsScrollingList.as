package net.wg.gui.messenger.controls
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.listselection.ListSelectionDirection;
   import net.wg.gui.messenger.data.IContactItemRenderer;
   import net.wg.gui.messenger.evnts.ContactsTreeEvent;
   
   public class BaseContactsScrollingList extends ScrollingListEx
   {
       
      
      protected var preventDefaultFocus:Boolean = true;
      
      public function BaseContactsScrollingList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ContactsTreeEvent.CONTACT_DRAG_START,this.onCtctDragStart,false,0,true);
         addEventListener(ContactsTreeEvent.CONTACT_DRAG_END,this.onCtctDragEnd,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ContactsTreeEvent.CONTACT_DRAG_START,this.onCtctDragStart);
         removeEventListener(ContactsTreeEvent.CONTACT_DRAG_END,this.onCtctDragEnd);
         super.onDispose();
      }
      
      private function onCtctDragStart(param1:ContactsTreeEvent) : void
      {
         this.applyRenderersDraggingId(Number(param1.data));
      }
      
      private function onCtctDragEnd(param1:ContactsTreeEvent) : void
      {
         this.applyRenderersDraggingId(NaN);
      }
      
      private function applyRenderersDraggingId(param1:Number) : void
      {
         var _loc2_:uint = _renderers.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            IContactItemRenderer(getRendererAt(_loc3_)).setDraggingItemId(param1);
            _loc3_++;
         }
      }
      
      override protected function changeFocus() : void
      {
         super.changeFocus();
         if(_selectedIndex == -1 && this.preventDefaultFocus)
         {
            navigateSelection(0,ListSelectionDirection.DOWN);
            updateSelectedIndex();
         }
      }
   }
}
