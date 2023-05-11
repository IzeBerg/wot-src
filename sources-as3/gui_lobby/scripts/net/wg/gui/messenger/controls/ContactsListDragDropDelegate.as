package net.wg.gui.messenger.controls
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.infrastructure.events.DragEvent;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   
   public class ContactsListDragDropDelegate extends ContactsDropListDelegate implements IDraggable
   {
       
      
      public function ContactsListDragDropDelegate(param1:InteractiveObject, param2:String)
      {
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onRolloverHandler,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
         super(param1,param2);
      }
      
      [Event(name="onStartDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:Boolean = super.onStartDrop(param1,param2,param3,param4);
         if(_loc5_)
         {
            getHitArea().dispatchEvent(new DragEvent(DragEvent.START_DRAG,param2,0,0));
         }
         return _loc5_;
      }
      
      override protected function onDispose() : void
      {
         getHitArea().removeEventListener(MouseEvent.ROLL_OVER,this.onRolloverHandler);
         getHitArea().removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         super.onDispose();
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
      }
      
      public function onEndDrag() : void
      {
         getHitArea().dispatchEvent(new DragEvent(DragEvent.END_DRAG,null,0,0));
      }
      
      public function onStartDrag() : void
      {
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:ContactsTreeItemRenderer = param1.target as ContactsTreeItemRenderer;
         if(_loc2_ && _loc2_.getCursorType != Cursors.DRAG_OPEN)
         {
            param1.stopImmediatePropagation();
         }
      }
      
      private function onRolloverHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
      }
   }
}
