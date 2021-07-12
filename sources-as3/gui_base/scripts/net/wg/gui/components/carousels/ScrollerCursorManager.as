package net.wg.gui.components.carousels
{
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.gui.components.carousels.interfaces.IScrollerCursorManager;
   
   public class ScrollerCursorManager extends Sprite implements IScrollerCursorManager
   {
       
      
      public function ScrollerCursorManager()
      {
         super();
         App.cursor.registerDragging(this,Cursors.MOVE);
         name = "cursorManager";
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         App.cursor.unRegisterDragging(this);
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
      
      public function setTouchRect(param1:Rectangle) : void
      {
         var _loc2_:Graphics = graphics;
         _loc2_.clear();
         _loc2_.beginFill(10079232,0);
         _loc2_.drawRect(param1.x,param1.y,param1.width,param1.height);
         _loc2_.endFill();
      }
      
      public function startTouchScroll() : void
      {
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,false));
      }
      
      public function stopTouchScroll() : void
      {
         dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,false));
      }
      
      protected function onDispose() : void
      {
      }
      
      public function get enable() : Boolean
      {
         return mouseEnabled;
      }
      
      public function set enable(param1:Boolean) : void
      {
         mouseEnabled = param1;
      }
   }
}
