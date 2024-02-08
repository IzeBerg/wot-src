package net.wg.utils
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.utils.Padding;
   
   public class ButtonOverlayUtils implements IDisposable
   {
      
      private static var _instance:ButtonOverlayUtils = null;
       
      
      private var _items:Vector.<OverlayItem> = null;
      
      private var _isDisposed:Boolean = false;
      
      public function ButtonOverlayUtils()
      {
         super();
         if(_instance != null)
         {
            throw new Error("Singleton ButtonOverlayUtils can only be accessed through ButtonOverlayUtils.instance");
         }
         this._items = new Vector.<OverlayItem>();
      }
      
      public static function get instance() : ButtonOverlayUtils
      {
         if(_instance == null)
         {
            _instance = new ButtonOverlayUtils();
         }
         return _instance;
      }
      
      public function addOverlayToBtn(param1:IUIComponentEx, param2:String, param3:Point, param4:Padding) : void
      {
         if(param3 == null)
         {
            param3 = new Point(1,1);
         }
         this.addOverlay(param1,param2,param3,param4);
      }
      
      public final function dispose() : void
      {
         while(this._items.length)
         {
            this.clearItem(0);
         }
         this._items = null;
         _instance = null;
         this._isDisposed = true;
      }
      
      public function invalidateOverlayPosition(param1:IUIComponentEx) : void
      {
         this.updateSize(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function removeOverlayFromBtn(param1:IUIComponentEx) : void
      {
         this.removeOverlay(param1);
      }
      
      private function getOverlay(param1:IUIComponentEx) : OverlayItem
      {
         var _loc2_:int = this._items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._items[_loc3_].hasTarget(param1))
            {
               return this._items[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function getOverlayIdx(param1:IUIComponentEx) : int
      {
         var _loc2_:int = this._items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._items[_loc3_].hasTarget(param1))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function removeOverlay(param1:IUIComponentEx) : void
      {
         var _loc2_:int = this.getOverlayIdx(param1);
         if(_loc2_ >= 0)
         {
            this.clearItem(_loc2_);
         }
      }
      
      private function clearItem(param1:int) : void
      {
         var _loc2_:OverlayItem = this._items[param1];
         _loc2_.target.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onItemOnBeforeDisposed);
         _loc2_.clear();
         this._items.splice(param1,1);
      }
      
      private function addOverlay(param1:IUIComponentEx, param2:String, param3:Point, param4:Padding) : void
      {
         this.removeOverlay(param1);
         if(!param1.stage || !param1.parent)
         {
            return;
         }
         var _loc5_:MovieClip = App.utils.classFactory.getObject(param2) as MovieClip;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:OverlayItem = new OverlayItem(param1,_loc5_,param3,param4);
         this._items.push(_loc6_);
         param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onItemOnBeforeDisposed);
      }
      
      private function updateSize(param1:IUIComponentEx) : void
      {
         var _loc2_:OverlayItem = this.getOverlay(param1);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.invalidateSize();
      }
      
      private function onItemOnBeforeDisposed(param1:LifeCycleEvent) : void
      {
         var _loc2_:IUIComponentEx = IUIComponentEx(param1.currentTarget);
         if(_loc2_ == null)
         {
            return;
         }
         this.removeOverlay(_loc2_);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import net.wg.infrastructure.interfaces.IUIComponentEx;
import scaleform.clik.utils.Padding;

class OverlayItem
{
   
   private static const OVERLAY_NAME:String = "overlay";
   
   private static const OVERLAY_MASK_NAME:String = "overlayMask";
    
   
   private var _target:IUIComponentEx;
   
   private var _scale:Point;
   
   private var _overlay:MovieClip;
   
   private var _mask:Sprite;
   
   private var _padding:Padding;
   
   function OverlayItem(param1:IUIComponentEx, param2:MovieClip, param3:Point, param4:Padding)
   {
      super();
      this._target = param1;
      this._overlay = param2;
      this._scale = param3;
      this._padding = param4;
      this._mask = new Sprite();
      this._mask.name = OVERLAY_MASK_NAME;
      param2.name = OVERLAY_NAME;
      param2.mouseChildren = false;
      param2.mouseEnabled = false;
      var _loc5_:DisplayObjectContainer = param1.parent;
      var _loc6_:int = _loc5_.getChildIndex(param1 as DisplayObject) + 1;
      _loc5_.addChildAt(param2,_loc6_++);
      _loc5_.addChildAt(this._mask,_loc6_++);
      param2.mask = this._mask;
      param1.addEventListener(Event.RESIZE,this.onTargetResize);
      this.invalidateSize();
   }
   
   public function clear() : void
   {
      this._target.removeEventListener(Event.RESIZE,this.onTargetResize);
      this._overlay.mask = null;
      var _loc1_:DisplayObjectContainer = this._target.parent;
      _loc1_.removeChild(this._overlay);
      _loc1_.removeChild(this._mask);
   }
   
   public function hasTarget(param1:IUIComponentEx) : Boolean
   {
      return this._target == param1;
   }
   
   public function invalidateSize() : void
   {
      var _loc1_:DisplayObjectContainer = this._target.parent;
      if(!_loc1_)
      {
         return;
      }
      var _loc2_:Rectangle = this.getMaskSize();
      this._mask.x = _loc2_.x;
      this._mask.y = _loc2_.y;
      var _loc3_:Graphics = this._mask.graphics;
      _loc3_.clear();
      _loc3_.beginFill(4095,1);
      _loc3_.drawRect(0,0,_loc2_.width,_loc2_.height);
      _loc3_.endFill();
      this._overlay.x = this._mask.x + (this._mask.width >> 1);
      this._overlay.y = this._mask.y + (this._mask.height >> 1);
      this._overlay.scaleX = this._scale.x;
      this._overlay.scaleY = this._scale.y;
   }
   
   private function getMaskSize() : Rectangle
   {
      var _loc1_:Rectangle = new Rectangle();
      _loc1_.x = this._target.x + this._padding.left;
      _loc1_.y = this._target.y + this._padding.top;
      _loc1_.width = this._target.width - this._padding.right;
      _loc1_.height = this._target.height - this._padding.bottom;
      return _loc1_;
   }
   
   public function get target() : IUIComponentEx
   {
      return this._target;
   }
   
   private function onTargetResize(param1:Event) : void
   {
      var _loc2_:IUIComponentEx = IUIComponentEx(param1.currentTarget);
      if(this._target != _loc2_)
      {
         return;
      }
      this.invalidateSize();
   }
}
