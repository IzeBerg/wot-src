package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.gui.components.controls.scroller.data.IScrollerItemRendererData;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   
   public class ExtendedHorizontalScrollerViewPort extends ScrollerViewPort
   {
      
      private static const EMPTY_SLOT_DP_INDEX:int = -1;
       
      
      private var _indexRenderersCountToRenderer:Vector.<int> = null;
      
      private var _itemRendererIndexToDataProviderIndex:Dictionary = null;
      
      private var _itemRendererIndexToRendererX:Dictionary = null;
      
      private var _itemRendererSmall:Boolean = false;
      
      private var _lastFullRendererIndex:uint = 0;
      
      private var _lastFullRendererX:uint = 0;
      
      private var _indexSpecialData:Vector.<int> = null;
      
      private var _indexExtendedData:Vector.<int> = null;
      
      private var _indexDataProviderToRenderer:Vector.<int> = null;
      
      public function ExtendedHorizontalScrollerViewPort()
      {
         super();
         this._indexRenderersCountToRenderer = new Vector.<int>();
         this._indexSpecialData = new Vector.<int>();
         this._indexExtendedData = new Vector.<int>();
         this._indexDataProviderToRenderer = new Vector.<int>();
         this._itemRendererIndexToDataProviderIndex = new Dictionary();
         this._itemRendererIndexToRendererX = new Dictionary();
      }
      
      override protected function onDispose() : void
      {
         this._indexRenderersCountToRenderer = null;
         App.utils.data.cleanupDynamicObject(this._itemRendererIndexToDataProviderIndex);
         this._itemRendererIndexToDataProviderIndex = null;
         App.utils.data.cleanupDynamicObject(this._itemRendererIndexToRendererX);
         this._itemRendererIndexToRendererX = null;
         this._indexSpecialData = null;
         this._indexExtendedData = null;
         this._indexDataProviderToRenderer = null;
         super.onDispose();
      }
      
      override protected function createRenderers(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            activeRenderers[_loc3_] = this.createRenderer(param1 + _loc3_);
            _loc3_++;
         }
      }
      
      override protected function isRendererSelected(param1:int) : Boolean
      {
         return this._itemRendererIndexToDataProviderIndex[param1] == selectedIndex;
      }
      
      override protected function updateActiveRenderer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(dataCount > 0)
         {
            _loc1_ = this.getLeftIndex();
            _loc2_ = this.getRightIndex(_loc1_);
            if(usesLayoutController())
            {
               _loc1_ = layoutController.getLeftIndex(_loc1_);
               _loc2_ = layoutController.getRightIndex(_loc1_);
            }
            _loc4_ = activeRenderers.length;
            if(_loc4_ > 0)
            {
               _loc5_ = this._indexRenderersCountToRenderer.indexOf(activeRenderers[0].index);
               _loc6_ = this._indexRenderersCountToRenderer.indexOf(activeRenderers[_loc4_ - 1].index);
               if(_loc6_ == -1 && rowCount == 1)
               {
                  _loc6_ = activeRenderers[_loc4_ - 1].index;
               }
               _loc7_ = _loc5_ - _loc1_;
               _loc8_ = _loc6_ - _loc2_;
               if(Math.max(-_loc7_,_loc8_) > _loc4_)
               {
                  deactivateRenderers(0,_loc4_);
                  this.createRenderers(_loc1_,_loc2_ - _loc1_ + 1);
               }
               else
               {
                  if(_loc7_ < 0)
                  {
                     deactivateRenderers(0,-_loc7_);
                  }
                  else if(_loc7_ > 0)
                  {
                     _loc3_ = _loc5_ - 1;
                     while(_loc3_ >= _loc1_)
                     {
                        activeRenderers.unshift(this.createRenderer(_loc3_));
                        _loc3_--;
                     }
                  }
                  if(_loc8_ < 0)
                  {
                     _loc3_ = _loc6_ + 1;
                     while(_loc3_ <= _loc2_)
                     {
                        activeRenderers.push(this.createRenderer(_loc3_));
                        _loc3_++;
                     }
                  }
                  else if(_loc8_ > 0)
                  {
                     _loc9_ = activeRenderers.length - _loc8_;
                     deactivateRenderers(_loc9_,_loc8_);
                  }
               }
            }
            else
            {
               this.createRenderers(_loc1_,_loc2_ - _loc1_ + 1);
            }
         }
      }
      
      override protected function clearRendererListeners(param1:IScrollerItemRenderer) : void
      {
         param1.removeEventListener(ListRendererEvent.CHANGE_SIZE,this.onRendererChangeSizeHandler);
         param1.removeEventListener(TankItemEvent.SELECT_ITEM,this.onRendererSelectItemHandler);
         super.clearRendererListeners(param1);
      }
      
      override protected function addRendererListeners(param1:IScrollerItemRenderer) : void
      {
         super.addRendererListeners(param1);
         param1.addEventListener(ListRendererEvent.CHANGE_SIZE,this.onRendererChangeSizeHandler);
         param1.addEventListener(TankItemEvent.SELECT_ITEM,this.onRendererSelectItemHandler);
      }
      
      override protected function resize() : void
      {
         var _loc3_:int = 0;
         var _loc5_:IScrollerItemRenderer = null;
         super.resize();
         var _loc1_:Number = this._itemRendererIndexToRendererX[this._indexDataProviderToRenderer[this._indexDataProviderToRenderer.length - 1]] + typicalRendererWidth - horizontalGap;
         if(usesLayoutController())
         {
            _loc1_ = layoutController.getMaxExtents().x;
         }
         var _loc2_:IScrollerItemRendererData = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._indexExtendedData.length)
         {
            _loc3_ = this._itemRendererIndexToDataProviderIndex[this._indexExtendedData[_loc4_]];
            _loc2_ = _loc3_ > EMPTY_SLOT_DP_INDEX ? getDataByIndex(_loc3_) as IScrollerItemRendererData : null;
            if(_loc2_ && _loc2_.isItemExtended)
            {
               _loc5_ = this.getRendererByIndex(_loc3_);
               if(_loc5_)
               {
                  _loc5_.data = _loc2_;
               }
            }
            _loc4_++;
         }
         if(_width !== _loc1_ || _height !== visibleHeight)
         {
            _width = _loc1_;
            _height = visibleHeight;
            if(hasEventListener(Event.RESIZE))
            {
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function layoutRenderer(param1:IScrollerItemRenderer) : void
      {
         super.layoutRenderer(param1);
         var _loc2_:int = param1.index;
         param1.x = this._itemRendererIndexToRendererX[_loc2_];
         param1.y = _loc2_ % rowCount * typicalRendererHeight;
      }
      
      override protected function getLeftIndex() : int
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._indexRenderersCountToRenderer.length && this._itemRendererIndexToRendererX[this._indexRenderersCountToRenderer[_loc1_]] < horizontalScrollPosition)
         {
            _loc1_++;
         }
         _loc1_ -= rowCount;
         if(_loc1_ < dataCount && rowCount > 1 && this._indexRenderersCountToRenderer[_loc1_] % 2)
         {
            _loc1_--;
         }
         if(_loc1_ > 0 && this._indexSpecialData.indexOf(this._indexRenderersCountToRenderer[_loc1_ - 1]) > -1)
         {
            _loc1_--;
         }
         return Math.max(0,_loc1_);
      }
      
      override protected function getRightIndex(param1:int = 0) : int
      {
         if(usesLayoutController())
         {
            return layoutController.getRightIndex(param1);
         }
         var _loc2_:int = param1 + 1;
         var _loc3_:int = this._indexRenderersCountToRenderer[param1];
         var _loc4_:uint = this._itemRendererIndexToRendererX[_loc3_] + visibleWidth + horizontalGap + typicalRendererWidth;
         while(_loc2_ < this._indexRenderersCountToRenderer.length && this._itemRendererIndexToRendererX[this._indexRenderersCountToRenderer[_loc2_]] < _loc4_)
         {
            _loc2_++;
         }
         _loc2_ += rowCount;
         if(_loc2_ < dataCount && rowCount > 1 && this._indexRenderersCountToRenderer[_loc2_] % 2 == 0)
         {
            _loc2_++;
         }
         return Math.min(dataCount - 1,_loc2_);
      }
      
      override protected function updateDataCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IScrollerItemRendererData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         super.updateDataCount();
         if(dataProvider != null)
         {
            _loc1_ = dataProvider.length;
            this._indexDataProviderToRenderer = new Vector.<int>(_loc1_);
            this._indexRenderersCountToRenderer = new Vector.<int>();
            this._indexSpecialData = new Vector.<int>();
            this._indexExtendedData = new Vector.<int>();
            this._itemRendererIndexToDataProviderIndex = new Dictionary();
            _loc2_ = null;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = false;
            _loc6_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc1_)
            {
               _loc2_ = dataProvider.requestItemAt(_loc7_) as IScrollerItemRendererData;
               _loc4_ = _loc7_ + _loc3_;
               _loc5_ = false;
               if(_loc2_ && _loc2_.hasExtendedInfo)
               {
                  _loc5_ = true;
                  if(rowCount > 1)
                  {
                     _loc3_++;
                     if(_loc4_ % 2)
                     {
                        this.addRendererLayoutData(EMPTY_SLOT_DP_INDEX,_loc4_,_loc6_);
                        _loc8_++;
                        _loc6_ += typicalRendererWidth;
                        _loc4_++;
                        _loc3_++;
                     }
                  }
                  this._indexSpecialData.push(_loc4_);
                  if(_loc2_.isItemExtended)
                  {
                     this._indexExtendedData.push(_loc4_);
                  }
               }
               this.addRendererLayoutData(_loc7_,_loc4_,_loc6_);
               _loc8_++;
               _loc9_ = _loc4_;
               _loc6_ += !!_loc5_ ? this.getActualWidth(_loc2_) : this.getRendererWidthByRendererIndex(_loc4_,true);
               _loc7_++;
            }
            this._lastFullRendererIndex = _loc4_;
            this._lastFullRendererX = _loc6_;
            _loc10_ = visibleWidth + horizontalGap;
            if(_loc6_ < _loc10_)
            {
               _loc3_ = 0;
               while(_loc6_ < _loc10_)
               {
                  _loc3_++;
                  _loc4_ = this._lastFullRendererIndex + _loc3_;
                  this.addRendererLayoutData(EMPTY_SLOT_DP_INDEX,_loc4_,_loc6_);
                  _loc8_++;
                  _loc9_ = _loc4_;
                  _loc6_ += this.getRendererWidthByRendererIndex(_loc4_,true);
               }
            }
            dataCount = _loc8_;
            if(rowCount > 1 && _loc9_ % 2 == 0)
            {
               _loc4_ = _loc9_ + 1;
               this.addRendererLayoutData(EMPTY_SLOT_DP_INDEX,_loc4_,this._itemRendererIndexToRendererX[_loc9_]);
               ++dataCount;
            }
         }
      }
      
      override protected function getRendererByIndex(param1:int) : IScrollerItemRenderer
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = activeRenderers.length;
         if(_loc2_ > 0 && param1 > EMPTY_SLOT_DP_INDEX)
         {
            _loc3_ = param1 < this._indexDataProviderToRenderer.length ? int(this._indexDataProviderToRenderer[param1]) : int(EMPTY_SLOT_DP_INDEX);
            if(_loc3_ == -1)
            {
               return null;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               if(activeRenderers[_loc4_].index == _loc3_)
               {
                  return activeRenderers[_loc4_];
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      override protected function onRendererSelect(param1:IScrollerItemRenderer) : void
      {
         var _loc2_:int = this._itemRendererIndexToDataProviderIndex[param1.index];
         if(selectedIndex != _loc2_)
         {
            switchSelectedIndex(_loc2_,param1);
         }
      }
      
      override protected function updateDataProviderItem(param1:int, param2:Object) : void
      {
         var _loc3_:IScrollerItemRenderer = this.getRendererByIndex(this._itemRendererIndexToDataProviderIndex[param1]);
         if(_loc3_)
         {
            _loc3_.data = param2;
         }
      }
      
      private function createRenderer(param1:int) : IScrollerItemRenderer
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = dataProvider != null ? int(dataProvider.length) : int(0);
         _loc3_ = this._indexRenderersCountToRenderer[param1];
         _loc4_ = this._itemRendererIndexToDataProviderIndex[_loc3_];
         var _loc5_:Object = Boolean(_loc2_) && _loc4_ > EMPTY_SLOT_DP_INDEX ? dataProvider.requestItemAt(_loc4_) : null;
         return getRenderer(_loc5_,_loc3_,true);
      }
      
      private function addRendererLayoutData(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = dataProvider != null ? int(dataProvider.length) : int(0);
         if(param1 > EMPTY_SLOT_DP_INDEX && param1 < _loc4_)
         {
            this._indexDataProviderToRenderer[param1] = param2;
         }
         else
         {
            param1 = EMPTY_SLOT_DP_INDEX;
         }
         this._itemRendererIndexToDataProviderIndex[param2] = param1;
         this._itemRendererIndexToRendererX[param2] = param3;
         this._indexRenderersCountToRenderer.push(param2);
      }
      
      private function updateItemsPrecalculatedPositions(param1:int = 0) : void
      {
         var _loc2_:IScrollerItemRendererData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(dataProvider != null)
         {
            _loc2_ = null;
            _loc3_ = 0;
            _loc5_ = false;
            _loc6_ = param1 > 0 ? int(this._itemRendererIndexToRendererX[param1]) : int(0);
            _loc7_ = this._indexRenderersCountToRenderer.indexOf(param1);
            _loc8_ = _loc7_;
            while(_loc8_ < dataCount)
            {
               _loc3_ = this._indexRenderersCountToRenderer[_loc8_];
               _loc4_ = this._itemRendererIndexToDataProviderIndex[_loc3_];
               _loc2_ = _loc4_ > EMPTY_SLOT_DP_INDEX ? getDataByIndex(_loc4_) as IScrollerItemRendererData : null;
               _loc5_ = false;
               if(_loc2_ && _loc2_.hasExtendedInfo)
               {
                  _loc5_ = true;
                  if(_loc8_ != _loc7_ && rowCount > 1 && _loc3_ > 0 && _loc4_ == EMPTY_SLOT_DP_INDEX)
                  {
                     _loc6_ += typicalRendererWidth;
                  }
                  if(_loc8_ == _loc7_)
                  {
                     _loc10_ = this._indexExtendedData.indexOf(param1);
                     if(_loc10_ > -1 && !_loc2_.isItemExtended)
                     {
                        this._indexExtendedData.splice(_loc10_,1);
                     }
                     else
                     {
                        this._indexExtendedData.push(param1);
                     }
                  }
               }
               this._itemRendererIndexToRendererX[_loc3_] = _loc6_;
               _loc9_ = !!_loc5_ ? int(this.getActualWidth(_loc2_)) : int(this.getRendererWidthByRendererIndex(_loc3_,true));
               _loc6_ += _loc9_;
               if(_loc8_ == dataProvider.length - 1)
               {
                  this._lastFullRendererIndex = _loc3_;
                  this._lastFullRendererX = _loc6_;
               }
               _loc8_++;
            }
         }
      }
      
      private function getRendererWidthByRendererIndex(param1:int, param2:Boolean = false) : int
      {
         return param2 && rowCount == 1 ? int(typicalRendererWidth) : int((param1 % rowCount ^ 0) * typicalRendererWidth);
      }
      
      private function getActualWidth(param1:IScrollerItemRendererData) : int
      {
         var _loc2_:int = Values.DEFAULT_INT;
         if(param1)
         {
            _loc2_ = param1.dataBasedWidth(this._itemRendererSmall,rowCount);
         }
         return _loc2_ > -1 ? int(_loc2_ + horizontalGap) : int(typicalRendererWidth);
      }
      
      override public function set itemRendererFactory(param1:Class) : void
      {
         var _loc2_:IScrollerItemRenderer = null;
         if(param1 != null)
         {
            _loc2_ = new param1();
            this._itemRendererSmall = _loc2_.adaptiveSize == ScrollerItemRendererSize.SMALL_SIZE;
            _loc2_.dispose();
            _loc2_ = null;
         }
         super.itemRendererFactory = param1;
      }
      
      override public function set horizontalScrollPosition(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 != horizontalScrollPosition)
         {
            super.horizontalScrollPosition = param1;
            _loc2_ = param1 / typicalRendererWidth;
            if(leftVisibleIndex != _loc2_)
            {
               leftVisibleIndex = _loc2_;
               invalidate(INVALIDATE_LAYOUT_RENDERER);
            }
         }
      }
      
      override public function get validWidth() : Number
      {
         var _loc1_:int = 0;
         if(dataProvider != null && dataProvider.length > 0)
         {
            _loc1_ = this._indexDataProviderToRenderer[this._indexDataProviderToRenderer.length - 1];
            return startGap + this._itemRendererIndexToRendererX[_loc1_] + typicalRendererWidth - horizontalGap + endGap;
         }
         return width;
      }
      
      private function onRendererSelectItemHandler(param1:TankItemEvent) : void
      {
         var _loc2_:int = this._itemRendererIndexToDataProviderIndex[param1.itemId];
         param1.stopImmediatePropagation();
         dispatchEvent(new TankItemEvent(param1.type,_loc2_));
      }
      
      private function onRendererChangeSizeHandler(param1:ListRendererEvent) : void
      {
         var _loc2_:IScrollerItemRenderer = IScrollerItemRenderer(param1.currentTarget);
         this.updateItemsPrecalculatedPositions(_loc2_.index);
         if(hasEventListener(Event.RESIZE))
         {
            dispatchEvent(new Event(Event.RESIZE));
         }
         invalidate(INVALIDATE_LAYOUT_RENDERER);
      }
   }
}
