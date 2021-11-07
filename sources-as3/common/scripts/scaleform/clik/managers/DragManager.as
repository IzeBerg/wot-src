package scaleform.clik.managers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.DragEvent;
   import scaleform.clik.interfaces.IDragSlot;
   
   public class DragManager
   {
      
      protected static var _stage:Stage;
      
      protected static var _dragCanvas:Sprite;
      
      protected static var _initialized:Boolean = false;
      
      protected static var _inDrag:Boolean = false;
      
      protected static var _dragData:Object;
      
      protected static var _dragTarget:Sprite;
      
      protected static var _origDragSlot:IDragSlot;
       
      
      public function DragManager()
      {
         super();
      }
      
      public static function init(param1:Stage) : void
      {
         if(_initialized)
         {
            return;
         }
         _initialized = true;
         DragManager._stage = param1;
         _dragCanvas = new Sprite();
         _dragCanvas.mouseEnabled = _dragCanvas.mouseChildren = false;
         _stage.addChild(_dragCanvas);
         _stage.addEventListener(DragEvent.DRAG_START,DragManager.handleStartDragEvent,false,0,true);
      }
      
      public static function inDrag() : Boolean
      {
         return _inDrag;
      }
      
      public static function handleStartDragEvent(param1:DragEvent) : void
      {
         if(param1.dragTarget == null || param1.dragSprite == null)
         {
            return;
         }
         _dragTarget = param1.dragSprite;
         _dragData = param1.dragData;
         _origDragSlot = param1.dragTarget;
         var _loc2_:Point = _dragTarget.localToGlobal(new Point());
         var _loc3_:Point = _dragCanvas.localToGlobal(new Point());
         _dragCanvas.addChild(_dragTarget);
         _dragTarget.x = _loc2_.x - _loc3_.x;
         _dragTarget.y = _loc2_.y - _loc3_.y;
         _inDrag = true;
         _stage.addEventListener(MouseEvent.MOUSE_UP,handleEndDragEvent,false,0,true);
         var _loc4_:MovieClip = _dragTarget as MovieClip;
         _loc4_.startDrag();
         _loc4_.mouseEnabled = _loc4_.mouseChildren = false;
         _loc4_.trackAsMenu = true;
      }
      
      public static function handleEndDragEvent(param1:MouseEvent) : void
      {
         var _loc5_:DragEvent = null;
         _stage.removeEventListener(MouseEvent.MOUSE_UP,handleEndDragEvent,false);
         _inDrag = false;
         var _loc2_:Boolean = false;
         var _loc3_:IDragSlot = findSpriteAncestorOf(_dragTarget.dropTarget) as IDragSlot;
         if(_loc3_ != null && _loc3_ is IDragSlot && _loc3_ != _origDragSlot)
         {
            _loc5_ = new DragEvent(DragEvent.DROP,_dragData,_origDragSlot,_loc3_,_dragTarget);
            _loc2_ = _loc3_.handleDropEvent(_loc5_);
         }
         _dragTarget.stopDrag();
         _dragTarget.mouseEnabled = _dragTarget.mouseChildren = true;
         (_dragTarget as MovieClip).trackAsMenu = false;
         _dragCanvas.removeChild(_dragTarget);
         var _loc4_:DragEvent = new DragEvent(DragEvent.DRAG_END,_dragData,_origDragSlot,_loc3_,_dragTarget);
         _origDragSlot.handleDragEndEvent(_loc4_,_loc2_);
         UIComponent(_origDragSlot).dispatchEventAndSound(_loc4_);
         _dragTarget = null;
         _origDragSlot = null;
      }
      
      protected static function handleStageAddedEvent(param1:Event) : void
      {
      }
      
      protected static function findSpriteAncestorOf(param1:DisplayObject) : IDragSlot
      {
         while(param1 && !(param1 is IDragSlot))
         {
            param1 = param1.parent;
         }
         return param1 as IDragSlot;
      }
   }
}
