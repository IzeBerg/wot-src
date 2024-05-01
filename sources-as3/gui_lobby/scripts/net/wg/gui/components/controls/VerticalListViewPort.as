package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.components.carousels.interfaces.IScrollerLayoutController;
   import net.wg.gui.components.carousels.interfaces.IScrollerViewPortBase;
   import net.wg.gui.components.controls.events.VerticalListViewportEvent;
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VerticalListViewPort extends UIComponentEx implements IScrollerViewPortBase
   {
      
      private static const INVALID_BOUNDS:String = "invalidBounds";
      
      private static const INVALID_LAYOUT:String = "invalidLayout";
      
      private static const INVALID_CHECK_LAYOUT:String = "invalidCheckLayout";
      
      private static const INVALID_WIDTH:String = "invalidWidth";
      
      private static const CACHE_SIZE_CORRECTION_VALUE:int = 2;
      
      private static const MIN_DEF_RENDERER_HEIGHT:int = 1;
       
      
      private var _renderers:Vector.<IReusableListItemRenderer>;
      
      private var _renderersCache:Vector.<IReusableListItemRenderer>;
      
      private var _renderersToResize:Vector.<IReusableListItemRenderer>;
      
      private var _renderersY:Vector.<int>;
      
      private var _renderersHeight:Vector.<int>;
      
      private var _dataProvider:IDataProvider;
      
      private var _itemRendererClassName:String;
      
      private var _itemRendererClass:Class;
      
      private var _assertCacheValue:int = 0;
      
      private var _defRendererHeight:int = 0;
      
      private var _minRendererHeight:int = 2147483647;
      
      private var _firstRndrInd:int = -1;
      
      private var _lastRndrInd:int = -1;
      
      private var _dataLen:int = 0;
      
      private var _visibleHeight:Number = 0;
      
      private var _verticalScrollPosition:Number = 0;
      
      private var _visibleBottomThreshold:Number = 0;
      
      private var _gap:int = 0;
      
      private var _firstRendererOffset:int = 0;
      
      public function VerticalListViewPort()
      {
         super();
         this._renderers = new Vector.<IReusableListItemRenderer>(0);
         this._renderersCache = new Vector.<IReusableListItemRenderer>(0);
         this._renderersToResize = new Vector.<IReusableListItemRenderer>(0);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.RENDERERS))
         {
            this.disposeRenderersVector(this._renderers);
            this.disposeRenderersVector(this._renderersCache);
            this._renderersToResize.splice(0,this._renderersToResize.length);
            this._defRendererHeight = 0;
            invalidate(INVALID_BOUNDS);
         }
         if(isInvalid(INVALID_BOUNDS))
         {
            this.tryDisposeRenderersBounds();
            this._minRendererHeight = int.MAX_VALUE;
            this.resetRenderers();
            if(this._dataLen > 0)
            {
               this._renderersY = new Vector.<int>(this._dataLen,true);
               this._renderersHeight = new Vector.<int>(this._dataLen,true);
               this.refreshRenderersBounds();
            }
            this.checkLayout();
            invalidate(InvalidationType.SIZE);
         }
         if(isInvalid(INVALID_CHECK_LAYOUT))
         {
            this.checkLayout();
         }
         if(this._dataLen > 0 && isInvalid(INVALID_LAYOUT))
         {
            this.layoutRenderers();
         }
         if(isInvalid(INVALID_WIDTH))
         {
            this.updateRenderersWidth();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.tryUnlinkDataProvider();
         this.tryDisposeRenderersBounds();
         this.disposeRenderersVector(this._renderers);
         this.disposeRenderersVector(this._renderersCache);
         this._renderers = null;
         this._renderersCache = null;
         this._itemRendererClass = null;
         this._renderersToResize.splice(0,this._renderersToResize.length);
         this._renderersToResize = null;
         super.onDispose();
      }
      
      public function set firtstRendererOffset(param1:Number) : void
      {
         if(this._firstRendererOffset != param1)
         {
            this._firstRendererOffset = param1;
            invalidateSize();
         }
      }
      
      public function getBottomVisibleRendererIndex() : int
      {
         return this._lastRndrInd;
      }
      
      public function getRendererPosition(param1:int) : int
      {
         return param1 <= this._lastRndrInd ? int(this.getRendererY(param1)) : int(-1);
      }
      
      public function getRendererY(param1:int) : int
      {
         if(param1 >= 0 && this._renderersY != null && param1 < this._renderersY.length)
         {
            return this._renderersY[param1];
         }
         return 0;
      }
      
      public function invalidateRenderers() : void
      {
         this.resetRenderers();
         invalidate(INVALID_CHECK_LAYOUT);
      }
      
      public function setLayoutController(param1:IScrollerLayoutController) : void
      {
      }
      
      public function updateData(param1:int) : void
      {
         if(param1 >= this._firstRndrInd && param1 <= this._lastRndrInd)
         {
            this.invalidateRenderers();
         }
      }
      
      public function usesLayoutController() : Boolean
      {
         return false;
      }
      
      private function validateRenderersHeight() : void
      {
         var _loc2_:int = 0;
         var _loc4_:IReusableListItemRenderer = null;
         var _loc1_:uint = this._renderersToResize.length;
         if(_loc1_ == 0)
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_)
         {
            _loc4_ = this._renderersToResize[_loc5_];
            _loc2_ = this.updateRendererHeight(_loc4_.index,_loc4_,false);
            if(_loc2_ != 0)
            {
               _loc3_ = true;
            }
            _loc5_++;
         }
         this._renderersToResize.splice(0,this._renderersToResize.length);
         if(_loc3_)
         {
            invalidate(INVALID_LAYOUT,InvalidationType.SIZE);
         }
      }
      
      private function updateRenderersWidth() : void
      {
         var _loc1_:IDisplayObject = null;
         for each(_loc1_ in this._renderers)
         {
            _loc1_.width = _width;
         }
      }
      
      private function checkLayout() : void
      {
         var _loc1_:Boolean = false;
         if(isDisposed())
         {
            return;
         }
         this.validateRenderersHeight();
         if(this._dataLen > 0)
         {
            _loc1_ = false;
            if(!this.isIndexesInvalid())
            {
               while(this._firstRndrInd < this._lastRndrInd && !this.hitRndrInDrawableArea(this._firstRndrInd))
               {
                  this.pushItemToCache(this._renderers.shift());
                  ++this._firstRndrInd;
                  _loc1_ = true;
               }
               while(this._lastRndrInd >= this._firstRndrInd && !this.hitRndrInDrawableArea(this._lastRndrInd))
               {
                  this.pushItemToCache(this._renderers.pop());
                  --this._lastRndrInd;
                  _loc1_ = true;
               }
               if(this._renderers.length == 0)
               {
                  this.resetIndexes();
               }
            }
            if(this.isIndexesInvalid())
            {
               this._firstRndrInd = 0;
               while(this._firstRndrInd < this._dataLen && this.getRendererBottomY(this._firstRndrInd) < this._verticalScrollPosition)
               {
                  ++this._firstRndrInd;
               }
               this._lastRndrInd = this._firstRndrInd - 1;
               _loc1_ = true;
            }
            while(this._firstRndrInd > 0 && this.getRendererBottomY(this._firstRndrInd - 1) > this._verticalScrollPosition)
            {
               this._renderers.unshift(this.validateRenderer(--this._firstRndrInd,true));
               _loc1_ = true;
            }
            while(this._lastRndrInd < this._dataLen - 1 && this.getRendererY(this._lastRndrInd + 1) < this._visibleBottomThreshold)
            {
               this._renderers.push(this.validateRenderer(++this._lastRndrInd,false));
               _loc1_ = true;
            }
            if(_loc1_)
            {
               invalidate(INVALID_LAYOUT);
            }
         }
      }
      
      private function resetRenderers() : void
      {
         var _loc1_:IReusableListItemRenderer = null;
         this._renderersToResize.splice(0,this._renderersToResize.length);
         for each(_loc1_ in this._renderers)
         {
            this.pushItemToCache(_loc1_);
         }
         this._renderers.splice(0,this._renderers.length);
         this.resetIndexes();
      }
      
      private function isIndexesInvalid() : Boolean
      {
         return this._firstRndrInd < 0 && this._lastRndrInd < 0;
      }
      
      private function resetIndexes() : void
      {
         this._firstRndrInd = -1;
         this._lastRndrInd = -1;
      }
      
      private function validateRenderer(param1:int, param2:Boolean) : IReusableListItemRenderer
      {
         var _loc3_:IReusableListItemRenderer = this.getRenderer();
         _loc3_.index = param1;
         var _loc4_:Object = this._dataProvider.requestItemAt(param1);
         if(_loc4_)
         {
            _loc3_.setData(_loc4_);
         }
         _loc3_.validateNow();
         this.updateRendererHeight(param1,_loc3_,param2);
         return _loc3_;
      }
      
      private function updateRendererHeight(param1:int, param2:IReusableListItemRenderer, param3:Boolean) : int
      {
         var _loc4_:int = this.setRendererHeight(param1,param2.height);
         if(_loc4_ > 0)
         {
            dispatchEvent(new VerticalListViewportEvent(!!param3 ? VerticalListViewportEvent.RESIZE_TOP : VerticalListViewportEvent.RESIZE_BOTTOM,_loc4_));
         }
         return _loc4_;
      }
      
      private function hitRndrInDrawableArea(param1:int) : Boolean
      {
         return this.getRendererY(param1) <= this._visibleBottomThreshold && this.getRendererBottomY(param1) >= this._verticalScrollPosition;
      }
      
      private function getRendererBottomY(param1:int) : int
      {
         return this.getRendererY(param1) + this.getRendererHeight(param1);
      }
      
      private function tryDisposeRenderersBounds() : void
      {
         if(this._renderersY != null)
         {
            this._renderersY.fixed = false;
            this._renderersY.splice(0,this._renderersY.length);
            this._renderersY = null;
         }
         if(this._renderersHeight != null)
         {
            this._renderersHeight.fixed = false;
            this._renderersHeight.splice(0,this._renderersHeight.length);
            this._renderersHeight = null;
         }
      }
      
      private function tryUnlinkDataProvider() : void
      {
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider = null;
         }
      }
      
      private function disposeRenderersVector(param1:Vector.<IReusableListItemRenderer>) : void
      {
         var _loc2_:IReusableListItemRenderer = null;
         for each(_loc2_ in param1)
         {
            if(_loc2_.hasEventListener(Event.RESIZE))
            {
               _loc2_.removeEventListener(Event.RESIZE,this.onRendererResizeHandler);
            }
            _loc2_.dispose();
         }
         param1.splice(0,param1.length);
      }
      
      private function pushItemToCache(param1:IReusableListItemRenderer, param2:Boolean = true) : void
      {
         if(param2 && this._renderersCache.length + 1 > this._assertCacheValue)
         {
            App.utils.asserter.assert(false,"Too many items in cache " + this._renderersCache.length + "/" + this._assertCacheValue);
         }
         param1.visible = false;
         param1.removeEventListener(Event.RESIZE,this.onRendererResizeHandler);
         param1.cleanUp();
         var _loc3_:Number = this._renderersToResize.indexOf(param1);
         if(_loc3_ != -1)
         {
            this._renderersToResize.splice(_loc3_,1);
         }
         this._renderersCache.push(param1);
      }
      
      private function refreshRenderersBounds() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = this.getDefRendererHeight();
         if(this._dataLen > 0)
         {
            this._renderersHeight[0] = _loc1_;
            this._renderersY[0] = this._firstRendererOffset;
            _loc2_ = 1;
            while(_loc2_ < this._dataLen)
            {
               this._renderersHeight[_loc2_] = _loc1_;
               this._renderersY[_loc2_] = this._renderersY[_loc2_ - 1] + _loc1_ + this._gap;
               _loc2_++;
            }
         }
         this.tryChangeMinRendererHeight(_loc1_);
      }
      
      private function offsetRenderers(param1:int, param2:int = 1) : void
      {
         var _loc3_:int = param2;
         while(_loc3_ < this._dataLen)
         {
            this._renderersY[_loc3_] += param1;
            _loc3_++;
         }
         invalidateSize();
      }
      
      private function layoutRenderers() : void
      {
         var _loc1_:IReusableListItemRenderer = null;
         var _loc2_:int = this._lastRndrInd - this._firstRndrInd + 1;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._renderers[_loc3_];
            _loc1_.visible = true;
            _loc1_.y = this.getRendererY(_loc3_ + this._firstRndrInd);
            _loc3_++;
         }
      }
      
      private function setRendererHeight(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = this.getRendererHeight(param1);
         if(_loc3_ != param2)
         {
            this._renderersHeight[param1] = param2;
            _loc4_ = param2 - _loc3_;
            this.offsetRenderers(_loc4_,param1 + 1);
            this.tryChangeMinRendererHeight(param2);
            return _loc4_;
         }
         return 0;
      }
      
      private function tryChangeMinRendererHeight(param1:int) : void
      {
         if(param1 != 0 && (this._minRendererHeight > param1 || this._minRendererHeight == MIN_DEF_RENDERER_HEIGHT))
         {
            this._minRendererHeight = param1;
            this.updateAssertCacheValue();
         }
      }
      
      private function updateAssertCacheValue() : void
      {
         var _loc1_:int = Math.floor(this._visibleHeight / this._minRendererHeight) + CACHE_SIZE_CORRECTION_VALUE;
         this._assertCacheValue = _loc1_ > this._assertCacheValue ? int(_loc1_) : int(this._assertCacheValue);
      }
      
      private function getRendererHeight(param1:int) : int
      {
         if(param1 >= 0 && this._renderersHeight && param1 < this._renderersHeight.length)
         {
            return this._renderersHeight[param1];
         }
         return 0;
      }
      
      private function getDefRendererHeight() : int
      {
         var _loc1_:IReusableListItemRenderer = null;
         if(this._defRendererHeight <= 0)
         {
            _loc1_ = this.getRenderer();
            this._defRendererHeight = int(_loc1_.height) || int(MIN_DEF_RENDERER_HEIGHT);
            this.pushItemToCache(_loc1_,false);
         }
         return this._defRendererHeight;
      }
      
      private function getRenderer() : IReusableListItemRenderer
      {
         var _loc1_:IReusableListItemRenderer = null;
         if(this._renderersCache.length > 0)
         {
            _loc1_ = this._renderersCache.shift();
         }
         else
         {
            _loc1_ = this.createNewRenderer();
            _loc1_.visible = false;
            addChild(DisplayObject(_loc1_));
         }
         _loc1_.addEventListener(Event.RESIZE,this.onRendererResizeHandler);
         _loc1_.width = _width;
         return _loc1_;
      }
      
      private function createNewRenderer() : IReusableListItemRenderer
      {
         if(StringUtils.isNotEmpty(this._itemRendererClassName))
         {
            return App.utils.classFactory.getComponent(this._itemRendererClassName,IReusableListItemRenderer);
         }
         return new this._itemRendererClass();
      }
      
      private function invalidateRendererSize(param1:IReusableListItemRenderer) : void
      {
         if(param1.height != this.getRendererHeight(param1.index))
         {
            if(this._renderersToResize.indexOf(param1) == -1)
            {
               this._renderersToResize.push(param1);
            }
            invalidate(INVALID_CHECK_LAYOUT);
         }
      }
      
      private function updateVisibleBottomThreshhold() : void
      {
         this._visibleBottomThreshold = this._verticalScrollPosition + this._visibleHeight;
      }
      
      override public function get height() : Number
      {
         return this._dataLen > 0 ? Number(this.getRendererBottomY(this._dataLen - 1)) : Number(0);
      }
      
      public function get validWidth() : Number
      {
         return _width;
      }
      
      public function get validHeight() : Number
      {
         return this._dataLen > 0 ? Number(this.getRendererBottomY(this._dataLen - 1)) : Number(0);
      }
      
      public function get visibleWidth() : Number
      {
         return _width;
      }
      
      public function set visibleWidth(param1:Number) : void
      {
         if(_width == param1)
         {
            return;
         }
         width = param1;
         invalidate(INVALID_WIDTH);
      }
      
      public function get visibleHeight() : Number
      {
         return this._visibleHeight;
      }
      
      public function set visibleHeight(param1:Number) : void
      {
         if(this._visibleHeight == param1)
         {
            return;
         }
         this._visibleHeight = param1;
         this.updateVisibleBottomThreshhold();
         this.updateAssertCacheValue();
         invalidate(INVALID_CHECK_LAYOUT);
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         if(this._verticalScrollPosition == param1)
         {
            return;
         }
         this._verticalScrollPosition = param1;
         this.updateVisibleBottomThreshhold();
         invalidate(INVALID_CHECK_LAYOUT);
      }
      
      public function get itemRendererClassName() : String
      {
         return this._itemRendererClassName;
      }
      
      public function set itemRendererClassName(param1:String) : void
      {
         if(this._itemRendererClassName == param1)
         {
            return;
         }
         this._itemRendererClassName = param1;
         invalidate(InvalidationType.RENDERERS);
      }
      
      public function get itemRendererClass() : Class
      {
         return this._itemRendererClass;
      }
      
      public function set itemRendererClass(param1:Class) : void
      {
         if(this._itemRendererClass == param1)
         {
            return;
         }
         this._itemRendererClass = param1;
         invalidate(InvalidationType.RENDERERS);
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider == param1)
         {
            return;
         }
         this.tryUnlinkDataProvider();
         this._dataProvider = param1;
         this._dataLen = Boolean(this._dataProvider) ? int(this._dataProvider.length) : int(0);
         if(this._dataProvider != null)
         {
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         }
         invalidate(INVALID_BOUNDS);
      }
      
      public function get gap() : int
      {
         return this._gap;
      }
      
      public function set gap(param1:int) : void
      {
         if(this._gap == param1)
         {
            return;
         }
         var _loc2_:int = this._gap;
         this._gap = param1;
         this.offsetRenderers(_loc2_ - this._gap);
         invalidate(INVALID_CHECK_LAYOUT);
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return 0;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
      }
      
      public function get showRendererOnlyIfDataExists() : Boolean
      {
         return false;
      }
      
      public function set showRendererOnlyIfDataExists(param1:Boolean) : void
      {
      }
      
      private function onRendererResizeHandler(param1:Event) : void
      {
         var _loc2_:IReusableListItemRenderer = null;
         if(param1.target is IReusableListItemRenderer)
         {
            _loc2_ = IReusableListItemRenderer(param1.target);
            this.invalidateRendererSize(_loc2_);
         }
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         this._dataLen = Boolean(this._dataProvider) ? int(this._dataProvider.length) : int(0);
         invalidate(INVALID_BOUNDS);
      }
   }
}
