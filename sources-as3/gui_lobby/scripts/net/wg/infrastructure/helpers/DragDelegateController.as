package net.wg.infrastructure.helpers
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Cursors;
   import net.wg.infrastructure.events.DragEvent;
   import net.wg.infrastructure.helpers.interfaces.IDragDelegate;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   
   public class DragDelegateController implements IDisposable
   {
       
      
      private var _delegates:Vector.<IDragDelegate> = null;
      
      private var _disposed:Boolean = false;
      
      public function DragDelegateController(param1:Vector.<InteractiveObject>, param2:Class)
      {
         var _loc3_:InteractiveObject = null;
         var _loc4_:IDragDelegate = null;
         super();
         this._delegates = new Vector.<IDragDelegate>();
         for each(_loc3_ in param1)
         {
            _loc4_ = new param2(_loc3_);
            _loc3_.addEventListener(DragEvent.START_DRAG,this.onStartDragHandler);
            _loc3_.addEventListener(DragEvent.END_DRAG,this.onEndDragHandler);
            _loc3_.addEventListener(DragEvent.ON_DRAGGING,this.onDraggingHandler);
            App.cursor.registerDragging(_loc4_,Cursors.NUT);
            this._delegates.push(_loc4_);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:IDragDelegate = null;
         var _loc2_:InteractiveObject = null;
         this._disposed = true;
         for each(_loc1_ in this._delegates)
         {
            _loc2_ = _loc1_.getHitArea();
            _loc2_.removeEventListener(DragEvent.START_DRAG,this.onStartDragHandler);
            _loc2_.removeEventListener(DragEvent.END_DRAG,this.onEndDragHandler);
            _loc2_.removeEventListener(DragEvent.ON_DRAGGING,this.onDraggingHandler);
            this.onBeforeHitAreaUnregistering(_loc2_);
            App.cursor.unRegisterDragging(_loc1_);
         }
         this._delegates.splice(0,this._delegates.length);
         this._delegates = null;
      }
      
      protected function onBeforeHitAreaUnregistering(param1:InteractiveObject) : void
      {
      }
      
      protected function onEndDrag(param1:InteractiveObject, param2:InteractiveObject) : void
      {
      }
      
      private function onEndDragHandler(param1:DragEvent) : void
      {
         var _loc3_:IDragDropHitArea = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in this._delegates)
         {
            if(_loc3_.getHitArea() != param1.dragItem)
            {
               if(_loc3_.getHitArea().hitTestPoint(App.stage.mouseX,App.stage.mouseY))
               {
                  this.onEndDrag(param1.dragItem,_loc3_.getHitArea());
                  _loc2_ = true;
               }
            }
         }
         if(!_loc2_)
         {
            this.onEndDrag(param1.dragItem,null);
         }
      }
      
      private function onDraggingHandler(param1:DragEvent) : void
      {
      }
      
      private function onStartDragHandler(param1:DragEvent) : void
      {
         this.onStartDrag(param1.dragItem);
      }
      
      protected function onStartDrag(param1:InteractiveObject) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
