package net.wg.infrastructure.helpers
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.DragType;
   import net.wg.infrastructure.events.DragEvent;
   import net.wg.infrastructure.helpers.interfaces.IDragDelegate;
   
   public class DragDelegate extends InteractiveObject implements IDragDelegate
   {
       
      
      private var _hitArea:InteractiveObject = null;
      
      public function DragDelegate(param1:InteractiveObject)
      {
         super();
         this._hitArea = param1;
      }
      
      [Event(name="onStartDrag",type="net.wg.infrastructure.events.DragEvent")]
      public function onStartDrag() : void
      {
         this.dispatchDragEvent(DragEvent.START_DRAG,this._hitArea,0,0);
      }
      
      [Event(name="onDragging",type="net.wg.infrastructure.events.DragEvent")]
      public function onDragging(param1:Number, param2:Number) : void
      {
         this.dispatchDragEvent(DragEvent.ON_DRAGGING,this._hitArea,param1,param2);
      }
      
      [Event(name="onEndDrag",type="net.wg.infrastructure.events.DragEvent")]
      public function onEndDrag() : void
      {
         this.dispatchDragEvent(DragEvent.END_DRAG,this._hitArea,0,0);
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this._hitArea;
      }
      
      public function dispose() : void
      {
         this._hitArea = null;
      }
      
      [Event(name="onEndDrag",type="net.wg.infrastructure.events.DragEvent")]
      [Event(name="onStartDrag",type="net.wg.infrastructure.events.DragEvent")]
      [Event(name="onDragging",type="net.wg.infrastructure.events.DragEvent")]
      private function dispatchDragEvent(param1:String, param2:InteractiveObject, param3:Number, param4:Number) : void
      {
         this._hitArea.dispatchEvent(new DragEvent(param1,param2,param3,param4));
      }
   }
}
