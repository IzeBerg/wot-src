package net.wg.gui.components.common.counters
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.interfaces.INewCounter;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CounterBase extends UIComponentEx implements INewCounter
   {
      
      private static const INVALIDATE_VISIBILITY:String = "invalidateVisibility";
      
      private static const INVALIDATE_POSITION:String = "invalidatePosition";
      
      private static const INVALIDATE_COUNT:String = "invalidateCount";
      
      private static const INVALIDATE_STATE:String = "invalidateState";
      
      public static const DEFAULT_EMPTY_VALUE:String = "0";
       
      
      private var _value:String = null;
      
      private var _target:DisplayObject = null;
      
      private var _offset:Point = null;
      
      private var _tfPadding:int = 0;
      
      private var _horizontalAlign:String = null;
      
      private var _addToTop:Boolean = true;
      
      private var _viewState:String = null;
      
      public function CounterBase()
      {
         super();
         this.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         this._offset = null;
         if(this._target != null)
         {
            this._target.removeEventListener(Event.ADDED,this.onTargetAddedHandler);
            this._target.removeEventListener(Event.RESIZE,this.onTargetResizeHandler);
            _loc1_ = this._target.parent;
            if(_loc1_ != null && _loc1_.contains(this))
            {
               _loc1_.removeEventListener(Event.RESIZE,this.onTargetResizeHandler);
               _loc1_.removeChild(this);
            }
            this._target = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_STATE))
         {
            this.applyState();
            if(_baseDisposed)
            {
               return;
            }
         }
         if(isInvalid(INVALIDATE_COUNT))
         {
            this.applyCountValue();
         }
         if(isInvalid(INVALIDATE_POSITION))
         {
            this.applyPosition();
         }
         if(isInvalid(INVALIDATE_VISIBILITY))
         {
            this.visible = true;
         }
      }
      
      public function setCount(param1:String) : void
      {
         if(param1 != this._value)
         {
            this._value = param1;
            invalidate(INVALIDATE_COUNT);
         }
      }
      
      public function setTarget(param1:DisplayObject, param2:String, param3:Point = null, param4:String = null, param5:Boolean = true, param6:int = 0, param7:String = null) : void
      {
         App.utils.asserter.assertNotNull(param1,"Counter target" + Errors.CANT_NULL);
         this._target = param1;
         this._offset = param3;
         this._addToTop = param5;
         this._tfPadding = param6;
         this._horizontalAlign = param4;
         this._viewState = this.normalizeState(param7);
         this._value = param2;
         if(this._target.parent)
         {
            this.onTargetAddedHandler();
         }
         else
         {
            this._target.addEventListener(Event.ADDED,this.onTargetAddedHandler);
         }
      }
      
      public function updateHorizontalAlign(param1:String) : void
      {
         if(param1 != this._horizontalAlign)
         {
            this._horizontalAlign = param1;
            this.invalidatePosition();
         }
      }
      
      public function updatePosition(param1:Point) : void
      {
         if(!this._offset.equals(param1))
         {
            this._offset = param1;
            this.invalidatePosition();
         }
      }
      
      public function updateViewState(param1:String) : void
      {
         param1 = this.normalizeState(param1);
         if(this._viewState != param1)
         {
            this._viewState = param1;
            invalidate(INVALIDATE_STATE);
         }
      }
      
      protected function getDefaultState() : String
      {
         return null;
      }
      
      protected function applyCountValue() : void
      {
         this.invalidatePosition();
      }
      
      protected function applyPosition() : void
      {
         var _loc1_:Rectangle = null;
         _loc1_ = this.target.getBounds(this.target.parent);
         x = _loc1_.x;
         y = _loc1_.y | 0;
         if(this.offset != null)
         {
            x += this.offset.x | 0;
            y += this.offset.y | 0;
         }
      }
      
      protected function applyState() : void
      {
      }
      
      private function normalizeState(param1:String) : String
      {
         if(param1 == null)
         {
            return this.getDefaultState();
         }
         return param1;
      }
      
      private function invalidatePosition() : void
      {
         invalidate(INVALIDATE_POSITION);
      }
      
      protected function get value() : String
      {
         return this._value;
      }
      
      protected function get target() : DisplayObject
      {
         return this._target;
      }
      
      protected function get offset() : Point
      {
         return this._offset;
      }
      
      protected function get tfPadding() : int
      {
         return this._tfPadding;
      }
      
      protected function get horizontalAlign() : String
      {
         return this._horizontalAlign;
      }
      
      protected function get addToTop() : Boolean
      {
         return this._addToTop;
      }
      
      protected function get viewState() : String
      {
         return this._viewState;
      }
      
      override protected function handleStageChange(param1:Event) : void
      {
         if(param1.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            addEventListener(Event.ENTER_FRAME,handleEnterFrameValidation,false,0,true);
            addEventListener(Event.RENDER,validateNow,false,0,true);
            if(stage != null)
            {
               stage.invalidate();
            }
         }
      }
      
      private function onTargetResizeHandler(param1:Event) : void
      {
         this.applyPosition();
      }
      
      private function onTargetAddedHandler(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObjectContainer = this._target.parent;
         _loc2_.addEventListener(Event.RESIZE,this.onTargetResizeHandler,false,0,true);
         this._target.removeEventListener(Event.ADDED,this.onTargetAddedHandler);
         this._target.addEventListener(Event.RESIZE,this.onTargetResizeHandler);
         if(this._addToTop)
         {
            _loc2_.addChild(this);
         }
         else
         {
            _loc3_ = _loc2_.getChildIndex(this._target);
            if(_loc3_ > 0)
            {
               _loc3_--;
            }
            _loc2_.addChildAt(this,_loc3_);
         }
         invalidate(INVALIDATE_STATE,INVALIDATE_COUNT,INVALIDATE_VISIBILITY);
      }
   }
}
