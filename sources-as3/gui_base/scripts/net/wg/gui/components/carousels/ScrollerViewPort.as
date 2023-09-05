package net.wg.gui.components.carousels
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.gui.components.carousels.interfaces.IScrollerLayoutController;
   import net.wg.gui.components.carousels.interfaces.IScrollerViewPort;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IAssertable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ScrollerViewPort extends UIComponentEx implements IScrollerViewPort, ITutorialCustomComponent
   {
      
      protected static const INVALIDATE_RENDERER:String = "rendererInvalid";
      
      protected static const INVALIDATE_LAYOUT_RENDERER:String = "rendererLayoutInvalid";
      
      private static const COLON:String = ":";
       
      
      protected var typicalRendererWidth:int = 0;
      
      protected var typicalRendererHeight:int = 0;
      
      protected var dataCount:int = 0;
      
      protected var leftVisibleIndex:int = 0;
      
      private var _asserter:IAssertable;
      
      private var _rendererWidth:int = 0;
      
      private var _rendererHeight:int = 0;
      
      private var _visibleWidth:int = 0;
      
      private var _visibleHeight:int = 0;
      
      private var _selectedIndex:int = -1;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _owner:IUIComponentEx = null;
      
      private var _tooltipDecorator:ITooltipMgr;
      
      private var _itemRendererFactory:Class = null;
      
      private var _activeRenderers:Vector.<IScrollerItemRenderer>;
      
      private var _inactiveRenderers:Vector.<IScrollerItemRenderer>;
      
      private var _needPreventInnerEvents:Boolean = true;
      
      private var _horizontalGap:int = 0;
      
      private var _verticalGap:int = 0;
      
      private var _horizontalScrollPosition:Number = 0;
      
      private var _verticalScrollPosition:Number = 0;
      
      private var _startGap:int = 0;
      
      private var _endGap:int = 0;
      
      private var _rowCount:int = 1;
      
      private var _columnCount:int = 1;
      
      private var _layoutController:IScrollerLayoutController = null;
      
      private var _showRendererOnlyIfDataExists:Boolean;
      
      public function ScrollerViewPort()
      {
         this._asserter = App.utils.asserter;
         this._activeRenderers = new Vector.<IScrollerItemRenderer>(0);
         this._inactiveRenderers = new Vector.<IScrollerItemRenderer>(0);
         super();
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
      }
      
      override protected function draw() : void
      {
         var _loc4_:IScrollerItemRenderer = null;
         if(isDisposed())
         {
            return;
         }
         super.draw();
         var _loc1_:Boolean = isInvalid(INVALIDATE_RENDERER);
         var _loc2_:Boolean = _loc1_ || isInvalid(InvalidationType.DATA);
         var _loc3_:Boolean = _loc2_ || isInvalid(InvalidationType.SIZE);
         if(_loc2_)
         {
            this.deactivateRenderers(0,this._activeRenderers.length);
         }
         if(_loc1_)
         {
            this.disposeInactiveRenderers();
         }
         if(_loc3_)
         {
            this.updateDataCount();
         }
         if(_loc3_ || isInvalid(INVALIDATE_LAYOUT_RENDERER))
         {
            this.updateActiveRenderer();
            for each(_loc4_ in this._activeRenderers)
            {
               if(this.usesLayoutController())
               {
                  this.layoutRendererByController(_loc4_);
               }
               else
               {
                  this.layoutRenderer(_loc4_);
               }
            }
            App.tutorialMgr.dispatchEventForCustomComponent(this);
         }
         if(_loc3_)
         {
            this.resize();
         }
      }
      
      override protected function onDispose() : void
      {
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         this.deactivateRenderers(0,this._activeRenderers.length);
         this._activeRenderers = null;
         this.disposeInactiveRenderers();
         this._inactiveRenderers = null;
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
            this._dataProvider = null;
         }
         this._itemRendererFactory = null;
         this._owner = null;
         this._tooltipDecorator = null;
         this._asserter = null;
         this._layoutController = null;
         super.onDispose();
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getTutorialDescriptionName() : String
      {
         var _loc1_:String = App.utils.classFactory.getClassName(this._itemRendererFactory);
         return name + COLON + _loc1_;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return this._needPreventInnerEvents;
      }
      
      public function setLayoutController(param1:IScrollerLayoutController) : void
      {
         App.utils.asserter.assert(param1 != null,"HorizontalScrollerViewPort.SetUseDynamicLayout: You must pass a valid layout " + "controller to enable dynamic layouts!");
         this._layoutController = param1;
      }
      
      public function setNeedPreventInnerEvents(param1:Boolean) : void
      {
         this._needPreventInnerEvents = param1;
      }
      
      public function usesLayoutController() : Boolean
      {
         return this._layoutController != null;
      }
      
      protected function createRenderers(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc3_:Array = Boolean(this._dataProvider) ? this._dataProvider.requestItemRange(param1,param1 + param2) : null;
         var _loc6_:int = 0;
         while(_loc6_ < param2)
         {
            _loc4_ = param1 + _loc6_;
            _loc5_ = _loc3_ && _loc3_.length > _loc6_ ? _loc3_[_loc6_] : null;
            this.activeRenderers[_loc6_] = this.getRenderer(_loc5_,_loc4_,true);
            _loc6_++;
         }
      }
      
      protected function newRenderer() : IScrollerItemRenderer
      {
         var _loc1_:IScrollerItemRenderer = new this._itemRendererFactory() as IScrollerItemRenderer;
         this._asserter.assertNotNull(_loc1_,"Invalid IScrollerItemRenderer factory = " + this._itemRendererFactory);
         return _loc1_;
      }
      
      protected function disposeInactiveRenderers() : void
      {
         var _loc1_:IScrollerItemRenderer = null;
         for each(_loc1_ in this._inactiveRenderers)
         {
            this.clearRendererListeners(_loc1_);
            _loc1_.dispose();
            removeChild(DisplayObject(_loc1_));
         }
         this._inactiveRenderers.splice(0,this._inactiveRenderers.length);
      }
      
      protected function clearRendererListeners(param1:IScrollerItemRenderer) : void
      {
         param1.removeEventListener(ListRendererEvent.SELECT,this.onRendererSelectHandler);
      }
      
      protected function addRendererListeners(param1:IScrollerItemRenderer) : void
      {
         param1.addEventListener(ListRendererEvent.SELECT,this.onRendererSelectHandler);
      }
      
      protected function deactivateRenderers(param1:int, param2:int) : void
      {
         var _loc4_:IScrollerItemRenderer = null;
         var _loc3_:Vector.<IScrollerItemRenderer> = this._activeRenderers.splice(param1,param2);
         for each(_loc4_ in _loc3_)
         {
            if(!this.showRendererOnlyIfDataExists)
            {
               _loc4_.data = null;
            }
            _loc4_.visible = false;
            this._inactiveRenderers.push(_loc4_);
         }
      }
      
      protected function getRenderer(param1:Object, param2:int, param3:Boolean) : IScrollerItemRenderer
      {
         var _loc4_:IScrollerItemRenderer = null;
         if(!param3 || this._inactiveRenderers.length == 0)
         {
            _loc4_ = this.newRenderer();
            _loc4_.tooltipDecorator = this._tooltipDecorator;
            _loc4_.owner = this;
            this.addRendererListeners(_loc4_);
            this._asserter.assert(_loc4_ is DisplayObject,"IScrollerItemRenderer must be DisplayObject");
            addChild(DisplayObject(_loc4_));
         }
         else
         {
            _loc4_ = this._inactiveRenderers.shift();
         }
         if(this._showRendererOnlyIfDataExists && param1 == null)
         {
            _loc4_.index = param2;
            _loc4_.isViewPortEnabled = this.enabled;
            _loc4_.visible = false;
         }
         else
         {
            _loc4_.data = param1;
            _loc4_.index = param2;
            _loc4_.rowsCount = this.rowCount;
            _loc4_.selected = this.isRendererSelected(param2);
            _loc4_.isViewPortEnabled = this.enabled;
            _loc4_.visible = true;
         }
         if(this.usesLayoutController())
         {
            this.layoutRendererByController(_loc4_);
         }
         else
         {
            this.layoutRenderer(_loc4_);
         }
         return _loc4_;
      }
      
      protected function isRendererSelected(param1:int) : Boolean
      {
         return param1 == this._selectedIndex;
      }
      
      protected function layoutRenderer(param1:IScrollerItemRenderer) : void
      {
         if(this._rendererWidth != 0 && param1.width != this._rendererWidth)
         {
            param1.width = this._rendererWidth;
         }
         if(this._rendererHeight != 0 && param1.height != this._rendererHeight)
         {
            param1.height = this._rendererHeight;
         }
      }
      
      protected function getRendererByIndex(param1:int) : IScrollerItemRenderer
      {
         var _loc2_:uint = 0;
         if(this._activeRenderers.length > 0)
         {
            _loc2_ = this._activeRenderers[0].index;
            if(param1 >= _loc2_ && param1 < _loc2_ + this._activeRenderers.length)
            {
               return this._activeRenderers[param1 - _loc2_];
            }
         }
         return null;
      }
      
      protected function switchSelectedIndex(param1:int, param2:IScrollerItemRenderer = null) : void
      {
         var _loc3_:IScrollerItemRenderer = null;
         if(this._selectedIndex != -1)
         {
            _loc3_ = this.getRendererByIndex(this._selectedIndex);
            if(_loc3_ != null)
            {
               _loc3_.selected = false;
            }
         }
         this._selectedIndex = param1;
         if(param2 != null)
         {
            param2.selected = true;
         }
      }
      
      protected function getLeftIndex() : int
      {
         return 0;
      }
      
      protected function getRightIndex(param1:int = 0) : int
      {
         return this.dataCount;
      }
      
      protected function getDataByIndex(param1:int) : Object
      {
         if(this._dataProvider != null && this._dataProvider.length > param1)
         {
            return this._dataProvider.requestItemAt(param1);
         }
         return null;
      }
      
      protected function resize() : void
      {
      }
      
      protected function updateDataCount() : void
      {
      }
      
      protected function updateActiveRenderer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.dataCount > 0)
         {
            _loc1_ = this.getLeftIndex();
            _loc2_ = this.getRightIndex(_loc1_);
            if(this.usesLayoutController())
            {
               _loc1_ = this._layoutController.getLeftIndex(_loc1_);
               _loc2_ = this._layoutController.getRightIndex(_loc1_);
            }
            if(this.activeRenderers.length > 0)
            {
               _loc4_ = this.activeRenderers[0].index;
               _loc5_ = this.activeRenderers[this.activeRenderers.length - 1].index;
               _loc6_ = _loc4_ - _loc1_;
               _loc7_ = _loc5_ - _loc2_;
               if(Math.max(-_loc6_,_loc7_) > this.activeRenderers.length)
               {
                  this.deactivateRenderers(0,this.activeRenderers.length);
                  this.createRenderers(_loc1_,_loc2_ - _loc1_);
               }
               else
               {
                  if(_loc6_ < 0)
                  {
                     this.deactivateRenderers(0,-_loc6_);
                  }
                  else if(_loc6_ > 0)
                  {
                     _loc3_ = _loc4_ - 1;
                     while(_loc3_ >= _loc1_)
                     {
                        this.activeRenderers.unshift(this.getRenderer(this.getDataByIndex(_loc3_),_loc3_,true));
                        _loc3_--;
                     }
                  }
                  if(_loc7_ < 0)
                  {
                     _loc3_ = _loc5_ + 1;
                     while(_loc3_ <= _loc2_)
                     {
                        this.activeRenderers.push(this.getRenderer(this.getDataByIndex(_loc3_),_loc3_,true));
                        _loc3_++;
                     }
                  }
                  else if(_loc7_ > 0)
                  {
                     _loc8_ = this.activeRenderers.length - _loc7_;
                     this.deactivateRenderers(_loc8_,_loc7_);
                  }
               }
            }
            else
            {
               this.createRenderers(_loc1_,_loc2_ - _loc1_);
            }
         }
      }
      
      protected function onRendererSelect(param1:IScrollerItemRenderer) : void
      {
         if(this._selectedIndex != param1.index)
         {
            this.switchSelectedIndex(param1.index,param1);
         }
      }
      
      protected function updateDataProviderItem(param1:int, param2:Object) : void
      {
         var _loc3_:IScrollerItemRenderer = this.getRendererByIndex(param1);
         if(_loc3_)
         {
            _loc3_.data = param2;
         }
      }
      
      private function layoutRendererByController(param1:IScrollerItemRenderer) : void
      {
         var _loc3_:Rectangle = null;
         var _loc2_:Vector.<Rectangle> = this._layoutController.getLayout();
         if(param1.index < _loc2_.length)
         {
            _loc3_ = _loc2_[param1.index];
            param1.x = _loc3_.x;
            param1.y = _loc3_.y;
            param1.width = _loc3_.width;
            param1.height = _loc3_.height;
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         var _loc2_:IScrollerItemRenderer = null;
         for each(_loc2_ in this._activeRenderers)
         {
            _loc2_.isViewPortEnabled = param1;
         }
         for each(_loc2_ in this._inactiveRenderers)
         {
            _loc2_.isViewPortEnabled = param1;
         }
         super.enabled = param1;
      }
      
      public function get verticalGap() : int
      {
         return this._verticalGap;
      }
      
      public function set verticalGap(param1:int) : void
      {
         if(this._verticalGap == param1)
         {
            return;
         }
         this._verticalGap = param1;
         this.typicalRendererHeight = this._rendererHeight + param1;
         invalidateSize();
      }
      
      public function get horizontalGap() : int
      {
         return this._horizontalGap;
      }
      
      public function set horizontalGap(param1:int) : void
      {
         if(this._horizontalGap == param1)
         {
            return;
         }
         this._horizontalGap = param1;
         this.typicalRendererWidth = this._rendererWidth + param1;
         invalidateSize();
      }
      
      public function get rendererWidth() : int
      {
         return this._rendererWidth;
      }
      
      public function set rendererWidth(param1:int) : void
      {
         if(this._rendererWidth == param1)
         {
            return;
         }
         this._rendererWidth = param1;
         this.typicalRendererWidth = this._rendererWidth + this.horizontalGap;
         invalidateSize();
      }
      
      public function get rendererHeight() : int
      {
         return this._rendererHeight;
      }
      
      public function set rendererHeight(param1:int) : void
      {
         if(this._rendererHeight == param1)
         {
            return;
         }
         this._rendererHeight = param1;
         this.typicalRendererHeight = this._rendererHeight + this.verticalGap;
         invalidateSize();
      }
      
      public function get validWidth() : Number
      {
         return width;
      }
      
      public function get validHeight() : Number
      {
         return height;
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._horizontalScrollPosition;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         if(param1 != this._horizontalScrollPosition)
         {
            this._horizontalScrollPosition = param1;
         }
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         if(param1 != this._verticalScrollPosition)
         {
            this._verticalScrollPosition = param1;
         }
      }
      
      public function get owner() : IUIComponentEx
      {
         return this._owner;
      }
      
      public function set owner(param1:IUIComponentEx) : void
      {
         if(param1 != this._owner)
         {
            this._owner = param1;
            invalidateData();
         }
      }
      
      public function set itemRendererFactory(param1:Class) : void
      {
         if(param1 != this._itemRendererFactory)
         {
            this._itemRendererFactory = param1;
            invalidate(INVALIDATE_RENDERER);
         }
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         }
         this._dataProvider = param1;
         if(this._dataProvider != null)
         {
            this._dataProvider.addEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
         }
         invalidateData();
      }
      
      public function get visibleWidth() : Number
      {
         return this._visibleWidth;
      }
      
      public function set visibleWidth(param1:Number) : void
      {
         if(param1 != this._visibleWidth)
         {
            this._visibleWidth = param1;
            invalidateSize();
         }
      }
      
      public function get visibleHeight() : Number
      {
         return this._visibleHeight;
      }
      
      public function set visibleHeight(param1:Number) : void
      {
         if(param1 != this._visibleHeight)
         {
            this._visibleHeight = param1;
            invalidateSize();
         }
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._tooltipDecorator = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._selectedIndex != param1)
         {
            this.switchSelectedIndex(param1,this.getRendererByIndex(param1));
         }
      }
      
      public function get startGap() : int
      {
         return this._startGap;
      }
      
      public function set startGap(param1:int) : void
      {
         if(param1 != this._startGap)
         {
            this._startGap = param1;
            invalidateSize();
         }
      }
      
      public function get endGap() : int
      {
         return this._endGap;
      }
      
      public function set endGap(param1:int) : void
      {
         if(param1 != this._endGap)
         {
            this._endGap = param1;
            invalidateSize();
         }
      }
      
      public function get rowCount() : int
      {
         return this._rowCount;
      }
      
      public function set rowCount(param1:int) : void
      {
         if(this._rowCount != param1)
         {
            this._rowCount = param1;
            invalidateData();
         }
      }
      
      public function get columnCount() : int
      {
         return this._columnCount;
      }
      
      public function set columnCount(param1:int) : void
      {
         if(this._columnCount != param1)
         {
            this._columnCount = param1;
            invalidateData();
         }
      }
      
      public function get showRendererOnlyIfDataExists() : Boolean
      {
         return this._showRendererOnlyIfDataExists;
      }
      
      public function set showRendererOnlyIfDataExists(param1:Boolean) : void
      {
         this._showRendererOnlyIfDataExists = param1;
      }
      
      protected function get activeRenderers() : Vector.<IScrollerItemRenderer>
      {
         return this._activeRenderers;
      }
      
      protected function get inactiveRenderers() : Vector.<IScrollerItemRenderer>
      {
         return this._inactiveRenderers;
      }
      
      protected function get layoutController() : IScrollerLayoutController
      {
         return this._layoutController;
      }
      
      private function onRendererSelectHandler(param1:ListRendererEvent) : void
      {
         this.onRendererSelect(IScrollerItemRenderer(param1.currentTarget));
      }
      
      private function onDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         this.updateDataProviderItem(param1.index,param1.data);
      }
   }
}
