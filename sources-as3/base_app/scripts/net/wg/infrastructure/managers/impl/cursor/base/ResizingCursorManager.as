package net.wg.infrastructure.managers.impl.cursor.base
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IView;
   
   public class ResizingCursorManager extends BaseCursorManager
   {
      
      private static const WINDOW_IS_NULL:String = "window" + Errors.CANT_NULL;
       
      
      private var _isOnResizing:Boolean = false;
      
      public function ResizingCursorManager()
      {
         super();
      }
      
      override protected function cursorIsFree() : Boolean
      {
         return !this._isOnResizing;
      }
      
      public function unUseResizeCursor(param1:InteractiveObject) : void
      {
         assertNotNull(param1,WINDOW_IS_NULL);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onResizableObjectRollOver);
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onResizableObjectMouseDn);
         if(param1 is IView)
         {
            param1.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeResizableObjDispose);
         }
      }
      
      public function useResizeCursor(param1:InteractiveObject) : void
      {
         assertNotNull(param1,WINDOW_IS_NULL);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onResizableObjectRollOver,false,0,true);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onResizableObjectMouseDn,false,0,true);
         if(param1 is IView)
         {
            param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onBeforeResizableObjDispose,false,0,true);
         }
      }
      
      private function setResizing(param1:Boolean) : void
      {
         if(param1 != this._isOnResizing)
         {
            this._isOnResizing = param1;
            tryToResetCursor();
         }
      }
      
      protected final function isLeftButton(param1:MouseEvent) : Boolean
      {
         return App.utils.commons.isLeftButton(param1);
      }
      
      private function onResizableObjectRollOver(param1:MouseEvent) : void
      {
         setCursor(Cursors.RESIZE);
      }
      
      private function onResizableObjectMouseDn(param1:MouseEvent) : void
      {
         if(this.isLeftButton(param1))
         {
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onResizableObjectMouseUp);
            this.setResizing(true);
         }
      }
      
      private function onResizableObjectMouseUp(param1:MouseEvent) : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onResizableObjectMouseUp);
         this.setResizing(false);
      }
      
      private function onBeforeResizableObjDispose(param1:LifeCycleEvent) : void
      {
         var _loc2_:InteractiveObject = InteractiveObject(param1.target);
         this.unUseResizeCursor(_loc2_);
      }
   }
}
