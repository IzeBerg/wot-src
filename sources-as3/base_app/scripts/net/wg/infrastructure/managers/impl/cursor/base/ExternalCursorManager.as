package net.wg.infrastructure.managers.impl.cursor.base
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.events.ExternalCursorEvent;
   
   public class ExternalCursorManager extends BaseCursorManager
   {
       
      
      private var _components:Dictionary;
      
      private var _hoveredComponent:IEventDispatcher;
      
      private var _cursorLock:Boolean = false;
      
      public function ExternalCursorManager()
      {
         this._components = new Dictionary(true);
         super();
      }
      
      override protected function resetCursor() : void
      {
         if(!this.cursorIsFree())
         {
            return;
         }
         if(this._hoveredComponent)
         {
            assert(this._hoveredComponent in this._components,Errors.CANT_NULL);
            forceSetCursor(this._components[this._hoveredComponent]);
         }
         else
         {
            super.resetCursor();
         }
      }
      
      override protected function cursorIsFree() : Boolean
      {
         return super.cursorIsFree() && !this._cursorLock;
      }
      
      override protected function setCursor(param1:String) : void
      {
         this._cursorLock = Boolean(this._hoveredComponent);
         super.setCursor(param1);
         this._cursorLock = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:* = undefined;
         var _loc3_:IEventDispatcher = null;
         var _loc1_:Vector.<IEventDispatcher> = new Vector.<IEventDispatcher>();
         for(_loc2_ in this._components)
         {
            _loc1_.push(_loc2_ as IEventDispatcher);
         }
         for each(_loc3_ in _loc1_)
         {
            this.unregisterExternalComponent(_loc3_);
         }
         _loc1_.splice(0,_loc1_.length);
         this._components = null;
         this._hoveredComponent = null;
         super.onDispose();
      }
      
      public function registerExternalComponent(param1:IEventDispatcher, param2:String) : void
      {
         assert(!(param1 in this._components),Errors.ALREADY_REGISTERED);
         this._components[param1] = param2;
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
         param1.addEventListener(ExternalCursorEvent.EXTERNAL_CURSOR_CHANGED,this.onExternalCursorChangedHandler,false,0,true);
      }
      
      public function unregisterExternalComponent(param1:IEventDispatcher) : void
      {
         assertNotNull(param1,Errors.CANT_NULL);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         param1.removeEventListener(ExternalCursorEvent.EXTERNAL_CURSOR_CHANGED,this.onExternalCursorChangedHandler);
         if(this._hoveredComponent == param1)
         {
            this.setHoveredComponent(null);
         }
         assert(param1 in this._components,Errors.MUST_REGISTER);
         if(param1 in this._components)
         {
            delete this._components[param1];
         }
      }
      
      private function setHoveredComponent(param1:IEventDispatcher) : void
      {
         if(this._hoveredComponent == param1)
         {
            return;
         }
         this._hoveredComponent = param1;
         this.resetCursor();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this.setHoveredComponent(IEventDispatcher(param1.target));
      }
      
      private function onExternalCursorChangedHandler(param1:ExternalCursorEvent) : void
      {
         var _loc2_:IEventDispatcher = IEventDispatcher(param1.target);
         assert(_loc2_ in this._components,Errors.CANT_EMPTY);
         this._components[_loc2_] = param1.cursor;
         if(_loc2_ == this._hoveredComponent)
         {
            this.resetCursor();
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:IEventDispatcher = IEventDispatcher(param1.target);
         if(this._hoveredComponent == _loc2_)
         {
            this.setHoveredComponent(null);
         }
      }
   }
}
