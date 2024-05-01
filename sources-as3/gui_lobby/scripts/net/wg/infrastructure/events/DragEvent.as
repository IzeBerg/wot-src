package net.wg.infrastructure.events
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   
   public class DragEvent extends Event
   {
      
      public static const ON_DRAGGING:String = "onDragging";
      
      public static const START_DRAG:String = "onStartDrag";
      
      public static const END_DRAG:String = "onEndDrag";
       
      
      private var _dragItem:InteractiveObject = null;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      public function DragEvent(param1:String, param2:InteractiveObject, param3:Number, param4:Number)
      {
         super(param1,bubbles,cancelable);
         this._dragItem = param2;
         this._x = param3;
         this._y = param4;
      }
      
      public function get dragItem() : InteractiveObject
      {
         return this._dragItem;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
   }
}
