package net.wg.infrastructure.interfaces
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import net.wg.infrastructure.base.meta.ICursorManagerMeta;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   
   public interface ICursorManager extends ICursorManagerMeta
   {
       
      
      function useResizeCursor(param1:InteractiveObject) : void;
      
      function unUseResizeCursor(param1:InteractiveObject) : void;
      
      function registerDragging(param1:IDragDropHitArea, param2:String = null) : void;
      
      function unRegisterDragging(param1:IDragDropHitArea) : void;
      
      function attachToCursor(param1:Sprite, param2:Number, param3:Number) : void;
      
      function getAttachedSprite() : Sprite;
      
      function detachFromCursor() : void;
      
      function lock() : void;
      
      function unlock() : void;
      
      function forceSetCursor(param1:String) : void;
   }
}
