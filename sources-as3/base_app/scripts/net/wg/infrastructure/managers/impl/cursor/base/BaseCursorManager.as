package net.wg.infrastructure.managers.impl.cursor.base
{
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.ui.MouseCursor;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import scaleform.gfx.MouseCursorEvent;
   
   public class BaseCursorManager extends BaseDAAPIModule
   {
      
      private static const SPRITE_TO_ATTACH_IS_NULL:String = "Sprite to attach " + Errors.CANT_NULL;
      
      private static const SPRITE_TO_DETACH_IS_NULL:String = "Sprite to detach " + Errors.CANT_NULL;
      
      private static const CPP_SET_CURSOR_METHOD_NAME:String = "WG.setCursor";
       
      
      private var _attachedSprite:Sprite = null;
      
      private var _lastCursor:String = "arrow";
      
      private var _cursorContainer:ISimpleManagedContainer = null;
      
      private var _attachedDeltaX:int = 0;
      
      private var _attachedDeltaY:int = 0;
      
      private var _stage:Stage;
      
      public function BaseCursorManager()
      {
         this._stage = App.stage;
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         App.utils.scheduler.scheduleOnNextFrame(this.nextFrameAfterPopulateHandler);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.nextFrameAfterPopulateHandler);
         if(this._stage.hasEventListener(MouseCursorEvent.CURSOR_CHANGE))
         {
            this._stage.removeEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
         }
         if(this._attachedSprite)
         {
            this.detachFromCursor();
         }
         this._cursorContainer = null;
         this._stage = null;
         super.onDispose();
      }
      
      public function attachToCursor(param1:Sprite, param2:Number, param3:Number) : void
      {
         if(this._attachedSprite != null)
         {
            this.detachFromCursor();
         }
         assertNotNull(param1,SPRITE_TO_ATTACH_IS_NULL);
         this._attachedSprite = param1;
         this._cursorContainer.addChild(this._attachedSprite);
         this._attachedDeltaX = param2;
         this._attachedDeltaY = param3;
         this.moveAttachedToCursor();
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
      }
      
      public function detachFromCursor() : void
      {
         this._stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         assertNotNull(this._attachedSprite,SPRITE_TO_DETACH_IS_NULL);
         this._cursorContainer.removeChild(this._attachedSprite);
         this._attachedSprite = null;
      }
      
      public function getAttachedSprite() : Sprite
      {
         return this._attachedSprite;
      }
      
      public final function forceSetCursor(param1:String) : void
      {
         App.environment.call(CPP_SET_CURSOR_METHOD_NAME,param1);
      }
      
      protected function resetCursor() : void
      {
         this.setCursor(this._lastCursor);
      }
      
      protected function setCursor(param1:String) : void
      {
         this._lastCursor = param1;
         if(this.cursorIsFree())
         {
            this.forceSetCursor(param1);
         }
      }
      
      protected function nextFrameAfterPopulateHandler() : void
      {
         this.forceSetCursor(MouseCursor.ARROW);
         this._cursorContainer = App.containerMgr.cursorContainer;
         this._stage.addEventListener(MouseCursorEvent.CURSOR_CHANGE,this.onChangeCursorHandler);
      }
      
      protected final function tryToResetCursor() : void
      {
         if(this.cursorIsFree())
         {
            this.resetCursor();
         }
      }
      
      protected function cursorIsFree() : Boolean
      {
         return true;
      }
      
      private function moveAttachedToCursor() : void
      {
         this._attachedSprite.x = this._stage.mouseX + this._attachedDeltaX;
         this._attachedSprite.y = this._stage.mouseY + this._attachedDeltaY;
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         this.moveAttachedToCursor();
      }
      
      private function onChangeCursorHandler(param1:MouseCursorEvent) : void
      {
         this.setCursor(param1.cursor);
         param1.preventDefault();
      }
   }
}
