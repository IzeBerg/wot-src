package net.wg.gui.components.wulf
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.containers.UssWrapper;
   import net.wg.gui.components.containers.ViewWrapper;
   import net.wg.infrastructure.wulf.IChildViewProxy;
   import net.wg.infrastructure.wulf.IViewWrapper;
   
   public class ChildViewProxy extends Sprite implements IChildViewProxy
   {
      
      private static const NAME_PREFIX:String = "ChildViewProxy: ";
       
      
      private var _placeId:uint = 0;
      
      private var _onStage:Boolean = false;
      
      private var _added:Boolean = false;
      
      private var _manageSize:Boolean = false;
      
      private var _wrapper:IViewWrapper = null;
      
      private var _containerWidth:Number = 0;
      
      private var _containerHeight:Number = 0;
      
      private var _disposed:Boolean = false;
      
      public function ChildViewProxy()
      {
         super();
         this.updateName();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      }
      
      private static function tryMoveFocus(param1:InteractiveObject, param2:InteractiveObject, param3:Boolean) : void
      {
         if(!!param3 ? Boolean(hasFocusInside(param1)) : Boolean(param1 == App.utils.focusHandler.getFocus(0)))
         {
            DebugUtils.LOG_DEBUG(param1.name + " >>> move focus to the wrapper >>> " + param2.name);
            App.utils.focusHandler.setFocus(InteractiveObject(param2));
         }
      }
      
      private static function hasFocusInside(param1:InteractiveObject) : Boolean
      {
         if(!param1 || !param1.stage)
         {
            return false;
         }
         var _loc2_:DisplayObject = App.utils.focusHandler.getFocus(0);
         while(_loc2_ != null && _loc2_ != param1.stage)
         {
            if(_loc2_ == param1)
            {
               return true;
            }
            _loc2_ = _loc2_.parent;
         }
         return false;
      }
      
      public function dispose() : void
      {
         App.utils.asserter.assert(!this._disposed,ChildViewProxy + Errors.ALREADY_DISPOSED);
         this._disposed = true;
         this.sendRemoveEvent();
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         App.utils.asserter.assertNull(this._wrapper,"_wrapper" + Errors.MUST_NULL);
         App.utils.asserter.assert(!this._added,"Plase id was not unregistered on dispose");
      }
      
      public function focusWrapper(param1:IViewWrapper = null, param2:uint = 0) : void
      {
         App.utils.asserter.assert(false,Errors.ABSTRACT_INVOKE);
      }
      
      public function getContainerHeight(param1:uint = 0) : uint
      {
         return this._containerHeight;
      }
      
      public function getContainerWidth(param1:uint = 0) : uint
      {
         return this._containerWidth;
      }
      
      public function getManageSize(param1:uint = 0) : Boolean
      {
         return this._manageSize;
      }
      
      public function insertWrapper(param1:String, param2:uint, param3:uint = 0, param4:Boolean = false) : IViewWrapper
      {
         App.utils.asserter.assertNull(this._wrapper,Errors.MUST_NULL);
         var _loc5_:Class = !!param4 ? UssWrapper : ViewWrapper;
         this._wrapper = new _loc5_();
         this._wrapper.tutorialId = String(param2);
         this._wrapper.name = param1;
         this._wrapper.addEventListener(Event.RESIZE,this.onWrapperResizeHandler);
         addChild(this._wrapper as DisplayObject);
         if(this.visible)
         {
            this._wrapper.show(false);
            tryMoveFocus(this,InteractiveObject(this._wrapper),false);
         }
         return this._wrapper;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function removeWrapper(param1:IViewWrapper = null, param2:uint = 0) : void
      {
         App.utils.asserter.assertNotNull(this._wrapper,Errors.CANT_NULL);
         this._wrapper.removeEventListener(Event.RESIZE,this.onWrapperResizeHandler);
         if(!this._disposed && this._wrapper.focused)
         {
            tryMoveFocus(InteractiveObject(this._wrapper),this,true);
         }
         removeChild(this._wrapper as DisplayObject);
         this._wrapper.dispose();
         this._wrapper = null;
      }
      
      public function setManageSize(param1:Boolean) : void
      {
         if(this._manageSize == param1)
         {
            return;
         }
         this._manageSize = param1;
         this.updateWrapperSize();
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(this._containerWidth == param1 && this._containerHeight == param2)
         {
            return;
         }
         this._containerWidth = param1;
         this._containerHeight = param2;
         this.updateWrapperSize();
      }
      
      public function setWindowPosition(param1:IViewWrapper, param2:Number, param3:Number) : void
      {
         App.utils.asserter.assert(false,Errors.ABSTRACT_INVOKE);
      }
      
      private function updateName() : void
      {
         name = NAME_PREFIX + this._placeId;
      }
      
      private function updateWrapperSize() : void
      {
         if(this._wrapper != null)
         {
            this._wrapper.updateParentSize(this._containerWidth,this._containerHeight);
         }
         if(this._manageSize)
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function sendAddEvent() : void
      {
         if(this._added)
         {
            DebugUtils.LOG_ERROR("ChildViewProxy | ERROR: Child is already added!");
            return;
         }
         if(this._onStage && this._placeId > 0)
         {
            dispatchEvent(new ChildViewProxyEvent(ChildViewProxyEvent.PLACE_ADDED,this._placeId));
            this._added = true;
         }
      }
      
      private function sendRemoveEvent() : void
      {
         if(this._added)
         {
            dispatchEvent(new ChildViewProxyEvent(ChildViewProxyEvent.PLACE_REMOVED,this._placeId));
            this._added = false;
         }
      }
      
      override public function get height() : Number
      {
         return !!this._manageSize ? Number(this._containerHeight) : (Boolean(this._wrapper) ? Number(this._wrapper.height) : Number(0));
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize(this._containerWidth,param1);
      }
      
      override public function get width() : Number
      {
         return !!this._manageSize ? Number(this._containerWidth) : (Boolean(this._wrapper) ? Number(this._wrapper.width) : Number(0));
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize(param1,this._containerHeight);
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible != param1)
         {
            super.visible = param1;
            if(this._wrapper)
            {
               if(param1)
               {
                  this._wrapper.show(false);
                  tryMoveFocus(this,InteractiveObject(this._wrapper),false);
               }
               else
               {
                  if(this._wrapper.focused)
                  {
                     tryMoveFocus(InteractiveObject(this._wrapper),this,true);
                  }
                  this._wrapper.hide(false);
               }
            }
         }
      }
      
      public function get placeId() : uint
      {
         return this._placeId;
      }
      
      public function set placeId(param1:uint) : void
      {
         if(this._placeId == param1)
         {
            return;
         }
         this.sendRemoveEvent();
         this._placeId = param1;
         this.updateName();
         this.sendAddEvent();
      }
      
      public function get hitRect() : Rectangle
      {
         return Boolean(this._wrapper) ? this._wrapper.hitRect : new Rectangle();
      }
      
      private function onWrapperResizeHandler(param1:Event) : void
      {
         if(!this._manageSize)
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this._onStage = true;
         this.sendAddEvent();
      }
      
      private function onRemoveFromStage(param1:Event) : void
      {
         this._onStage = false;
         this.sendRemoveEvent();
      }
   }
}
