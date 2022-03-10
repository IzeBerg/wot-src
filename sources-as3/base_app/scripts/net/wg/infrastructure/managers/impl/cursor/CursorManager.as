package net.wg.infrastructure.managers.impl.cursor
{
   import flash.display.InteractiveObject;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.exceptions.InfrastructureException;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   import net.wg.infrastructure.managers.impl.cursor.base.BaseInfo;
   import net.wg.infrastructure.managers.impl.cursor.base.DroppingCursorManager;
   import net.wg.utils.IAssertable;
   
   public class CursorManager extends DroppingCursorManager implements ICursorManager
   {
      
      private static const CAST_MSG_ERROR:String = "dragArea for registerDragging must implements IDraggable or IDroppable interfaces.";
      
      private static const CONTAINER_IS_NULL:String = "container" + Errors.CANT_NULL;
      
      private static const DUPLICATE_LOCK:String = "Duplicate locking is incorrect!";
      
      private static const ALREADY_LOCKED:String = "You can lock cursor, if it unlocked only!";
      
      private static const WRONG_DRAG_STATE:String = "drag state must be STATE_NONE after dispatching MOUSE_UP";
       
      
      private var _dragObjects:Dictionary;
      
      private var _isOnDragging:Boolean = false;
      
      private var _customLock:Boolean = false;
      
      private var _lastHoveredDragInfo:DragInfo;
      
      private var _asserter:IAssertable;
      
      private var _mouseDwnDragInfo:DragInfo = null;
      
      private var _upHandled:Boolean = false;
      
      public function CursorManager()
      {
         this._dragObjects = new Dictionary(true);
         this._asserter = App.utils.asserter;
         super();
      }
      
      override public function registerDragging(param1:IDragDropHitArea, param2:String = null) : void
      {
         if(!(param1 is IDraggable) && !(param1 is IDroppable))
         {
            DebugUtils.LOG_ERROR(CAST_MSG_ERROR);
         }
         else
         {
            super.registerDragging(param1,param2);
            if(param1 is IDraggable)
            {
               this.registerDrag(IDraggable(param1),param2);
            }
            if(param1 is IView)
            {
               IView(param1).addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onAfterDraggableObjDispose);
            }
         }
      }
      
      override public function unRegisterDragging(param1:IDragDropHitArea) : void
      {
         if(!isDisposed())
         {
            if(!(param1 is IDraggable) && !(param1 is IDroppable))
            {
               DebugUtils.LOG_ERROR(CAST_MSG_ERROR);
            }
            else
            {
               super.unRegisterDragging(param1);
               assertNotNull(param1,CONTAINER_IS_NULL);
               if(param1 is IDraggable)
               {
                  this.unRegisterDrag(IDraggable(param1));
               }
               if(param1 is IView)
               {
                  EventDispatcher(param1).removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onAfterDraggableObjDispose);
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DragInfo = null;
         for each(_loc1_ in this._dragObjects)
         {
            DebugUtils.LOG_DEBUG(_loc1_.container + Errors.WASNT_UNREGISTERED);
            this.unRegisterDrag(_loc1_.container);
         }
         this._dragObjects = null;
         this._lastHoveredDragInfo = null;
         this._mouseDwnDragInfo = null;
         this._asserter = null;
         super.onDispose();
      }
      
      override protected function cursorIsFree() : Boolean
      {
         return super.cursorIsFree() && !this._isOnDragging && !this._customLock;
      }
      
      public function as_setCursor(param1:String) : void
      {
         setCursor(param1);
      }
      
      public function lock() : void
      {
         this._asserter.assert(this._customLock == false,DUPLICATE_LOCK,InfrastructureException);
         this._customLock = true;
      }
      
      public function unlock() : void
      {
         this._asserter.assert(this._customLock,ALREADY_LOCKED,InfrastructureException);
         this._customLock = false;
         resetCursor();
      }
      
      private function registerDrag(param1:IDraggable, param2:String = null) : void
      {
         var _loc3_:DragInfo = new DragInfo(param1,param2);
         assert(this._dragObjects[_loc3_.hit] == undefined,Errors.ALREADY_REGISTERED);
         this._dragObjects[_loc3_.hit] = _loc3_;
         if(_loc3_.container.getDragType() != DragType.NONE)
         {
            _loc3_.hit.addEventListener(MouseEvent.ROLL_OVER,this.onEnterToDragMode);
            _loc3_.hit.addEventListener(MouseEvent.ROLL_OUT,this.rollOutDragHandler);
            _loc3_.hit.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDnDragHandler);
         }
      }
      
      private function unRegisterDrag(param1:IDraggable) : void
      {
         var _loc3_:DragInfo = null;
         var _loc2_:InteractiveObject = BaseInfo.getHitFromContainer(param1);
         if(this._dragObjects[_loc2_] != null)
         {
            _loc3_ = this.getDragInfoByHit(_loc2_);
            if(_loc3_ == this._lastHoveredDragInfo)
            {
               this._lastHoveredDragInfo = null;
               resetCursor();
            }
            if(_loc3_.state == BaseInfo.STATE_STARTED || _loc3_.state == BaseInfo.STATE_INITIALIZED)
            {
               _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,false));
               assert(_loc3_.state == BaseInfo.STATE_NONE,WRONG_DRAG_STATE);
            }
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onEnterToDragMode);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutDragHandler);
            _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDnDragHandler);
            delete this._dragObjects[_loc2_];
            _loc3_.dispose();
         }
      }
      
      private function getDragInfoByHit(param1:InteractiveObject) : DragInfo
      {
         return this._dragObjects[param1];
      }
      
      private function setDragging(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1 != this._isOnDragging)
         {
            this._isOnDragging = param1;
            if(param2)
            {
               tryToResetCursor();
            }
         }
      }
      
      private function onEnterToDragMode(param1:MouseEvent) : void
      {
         if(this.cursorIsFree())
         {
            this._lastHoveredDragInfo = this.getDragInfoByHit(InteractiveObject(param1.currentTarget));
            forceSetCursor(Cursors.DRAG_OPEN);
         }
      }
      
      private function draggingHandler(param1:MouseEvent) : void
      {
         this._asserter.assert(!isDisposed(),Errors.MTHD_CORRUPT_INVOKE,InfrastructureException);
         if(!param1.buttonDown)
         {
            this.mouseUpLclHdr(param1);
            return;
         }
         var _loc2_:DragInfo = this.getDragInfoByHit(InteractiveObject(param1.currentTarget));
         if(_loc2_.state != BaseInfo.STATE_STARTED)
         {
            _loc2_.state = BaseInfo.STATE_STARTED;
         }
         var _loc3_:IDraggable = _loc2_.container;
         _loc3_.onDragging(param1.localX,param1.localY);
      }
      
      private function rollOutDragHandler(param1:MouseEvent) : void
      {
         this._asserter.assert(!isDisposed(),Errors.MTHD_CORRUPT_INVOKE,InfrastructureException);
         this._lastHoveredDragInfo = null;
         resetCursor();
      }
      
      private function mouseDnDragHandler(param1:MouseEvent) : void
      {
         if(isLeftButton(param1))
         {
            this._asserter.assert(!isDisposed(),Errors.MTHD_CORRUPT_INVOKE,InfrastructureException);
            this._mouseDwnDragInfo = this.getDragInfoByHit(InteractiveObject(param1.currentTarget));
            this.setDragging(true);
            forceSetCursor(this._mouseDwnDragInfo.cursor);
            this._mouseDwnDragInfo.state = BaseInfo.STATE_INITIALIZED;
            this._mouseDwnDragInfo.hit.addEventListener(MouseEvent.MOUSE_MOVE,this.draggingHandler);
            this._mouseDwnDragInfo.hit.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpLclHdr,false);
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseReleaseOutsideLclHdr,false);
            this._mouseDwnDragInfo.container.onStartDrag();
            this._upHandled = false;
         }
      }
      
      private function mouseUpLclHdr(param1:MouseEvent) : void
      {
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseReleaseOutsideLclHdr);
         this._asserter.assert(!isDisposed(),Errors.MTHD_CORRUPT_INVOKE,InfrastructureException);
         var _loc2_:DragInfo = this.getDragInfoByHit(InteractiveObject(param1.currentTarget));
         if(!this._mouseDwnDragInfo && !_loc2_)
         {
            this._asserter.assertNotNull(this._mouseDwnDragInfo,this._mouseDwnDragInfo + Errors.CANT_NULL);
         }
         else if(!this._mouseDwnDragInfo)
         {
            this._mouseDwnDragInfo = _loc2_;
         }
         this._mouseDwnDragInfo.hit.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpLclHdr);
         this._mouseDwnDragInfo.hit.removeEventListener(MouseEvent.MOUSE_MOVE,this.draggingHandler);
         if(isOnDropping)
         {
            forceSetCursor(Cursors.DRAG_CLOSE);
            this.setDragging(false);
         }
         else if(this._isOnDragging)
         {
            forceSetCursor(Cursors.DRAG_OPEN);
            this.setDragging(false);
         }
         this._mouseDwnDragInfo.container.onEndDrag();
         this._mouseDwnDragInfo.state = BaseInfo.STATE_NONE;
         this._mouseDwnDragInfo = null;
         this._upHandled = true;
      }
      
      private function mouseReleaseOutsideLclHdr(param1:MouseEvent) : void
      {
         if(!this._upHandled)
         {
            this._asserter.assertNotNull(this._mouseDwnDragInfo,this._mouseDwnDragInfo + Errors.CANT_NULL);
            this._mouseDwnDragInfo.state = BaseInfo.STATE_NONE;
            this.mouseUpLclHdr(param1);
         }
         this.setDragging(false,true);
      }
      
      private function onAfterDraggableObjDispose(param1:LifeCycleEvent) : void
      {
         this._asserter.assert(!isDisposed(),Errors.MTHD_CORRUPT_INVOKE,InfrastructureException);
         var _loc2_:IDraggable = IDraggable(param1.target);
         DebugUtils.LOG_DEBUG(_loc2_ + Errors.WASNT_UNREGISTERED);
         IView(_loc2_).removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onAfterDraggableObjDispose);
         var _loc3_:InteractiveObject = BaseInfo.getHitFromContainer(_loc2_);
         if(this._dragObjects[_loc3_] != undefined)
         {
            this.unRegisterDragging(_loc2_);
         }
      }
   }
}

import net.wg.data.constants.Cursors;
import net.wg.infrastructure.interfaces.entity.IDraggable;
import net.wg.infrastructure.managers.impl.cursor.base.BaseInfo;

class DragInfo extends BaseInfo
{
    
   
   function DragInfo(param1:IDraggable, param2:String)
   {
      super(param1,param2,Cursors.DRAG_CLOSE);
   }
   
   public function get container() : IDraggable
   {
      return IDraggable(getContainer());
   }
}
