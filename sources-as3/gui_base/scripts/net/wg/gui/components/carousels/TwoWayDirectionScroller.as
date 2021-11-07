package net.wg.gui.components.carousels
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.carousels.interfaces.IScroller;
   import net.wg.gui.components.carousels.interfaces.IScrollerCursorManager;
   import net.wg.gui.components.carousels.interfaces.IScrollerViewPort;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.events.ScrollBarEvent;
   import net.wg.gui.components.controls.events.ScrollEvent;
   import net.wg.gui.components.controls.scroller.ScrollerBase;
   import net.wg.infrastructure.exceptions.AbstractException;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IScrollBar;
   
   public class TwoWayDirectionScroller extends ScrollerBase implements IScroller
   {
      
      protected static const D_START_DRAG:Number = 4;
      
      protected static const ACCELERATION:int = 3;
      
      protected static const INVALIDATION_TYPE_SCROLLBAR:String = "invalidationTypeScrollbar";
      
      protected static const INVALID_GO_TO_INDEX:String = "invalidGoToIndex";
      
      private static const VIEW_PORT_NAME:String = "viewPort";
      
      private static const GET_VIEW_PORT_CLASS:String = "viewPortClass";
       
      
      protected var cursorManager:IScrollerCursorManager = null;
      
      protected var equableScrolling:Boolean = false;
      
      protected var scrollToBegin:Boolean = false;
      
      protected var scrollToEnd:Boolean = false;
      
      protected var scrollbarRef:ScrollBar = null;
      
      protected var scrollBarHandlingInProgress:Boolean = false;
      
      protected var ignoreScrollBarHandler:Boolean = false;
      
      protected var tooltipDecorator:TooltipDecorator = null;
      
      protected var scrollIfRendererVisible:Boolean = false;
      
      protected var scrollImmediately:Boolean = false;
      
      private var _itemRendererLinkage:String;
      
      private var _itemRendererFactory:Class;
      
      private var _dataProvider:IDataProvider = null;
      
      private var _snapScrollPositionToItemRendererSize:Boolean = false;
      
      private var _useExtendedViewPort:Boolean = false;
      
      private var _horizontalGap:int = 0;
      
      private var _verticalGap:int = 0;
      
      private var _rendererWidth:int = 0;
      
      private var _rendererHeight:int = 0;
      
      private var _rowCount:int = 1;
      
      private var _columnCount:int = 1;
      
      private var _selectedIndex:int = -1;
      
      private var _goToOffset:Number = 0;
      
      private var _goToIndex:int = -1;
      
      private var _goToDuration:Number = 0;
      
      private var _viewPort:IScrollerViewPort = null;
      
      private var _hitArea:Sprite = null;
      
      private var _showRendererOnlyIfDataExists:Boolean;
      
      public function TwoWayDirectionScroller()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tooltipDecorator = new TooltipDecorator();
         this.cursorManager = new ScrollerCursorManager();
         addChildAt(DisplayObject(this.cursorManager),getChildIndex(container));
         this.configureViewPort();
      }
      
      override protected function onDispose() : void
      {
         this.unsubscribeFromScrollbar();
         this.scrollbarRef = null;
         this._itemRendererFactory = null;
         if(this.cursorManager != null)
         {
            this.cursorManager.dispose();
            this.cursorManager = null;
         }
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this._dataProvider = null;
         }
         if(this.tooltipDecorator != null)
         {
            this.tooltipDecorator.dispose();
            this.tooltipDecorator = null;
         }
         if(this._viewPort != null)
         {
            this._viewPort.dispose();
            this._viewPort = null;
         }
         this._hitArea = null;
         super.onDispose();
      }
      
      override protected function updateScrollPosition() : void
      {
         super.updateScrollPosition();
         if(isInvalid(INVALID_GO_TO_INDEX))
         {
            viewPort.validateNow();
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA))
         {
            this.dataViewPort.dataProvider = this._dataProvider;
         }
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.refreshDataViewPortProperties();
         }
         if(isInvalid(INVALIDATION_TYPE_INTERACTION_MODE,InvalidationType.SIZE))
         {
            this.updateCursorManager();
         }
         super.draw();
      }
      
      override protected function startTouchScroll() : void
      {
         this.cursorManager.startTouchScroll();
         mouseChildren = false;
         super.startTouchScroll();
      }
      
      override protected function completeTouchScroll() : void
      {
         super.completeTouchScroll();
         this.cursorManager.stopTouchScroll();
         mouseChildren = true;
      }
      
      override protected function completeScroll() : void
      {
         if(this.tooltipDecorator != null)
         {
            this.tooltipDecorator.enabled = true;
         }
         super.completeScroll();
      }
      
      override protected function startScroll() : void
      {
         this.tooltipDecorator.enabled = false;
         this.tooltipDecorator.hide();
         App.contextMenuMgr.hide();
         super.startScroll();
      }
      
      override protected function isViewPortUnderMouse() : Boolean
      {
         var _loc1_:Boolean = DisplayObject(this.cursorManager).getBounds(stage).containsPoint(new Point(stage.mouseX,stage.mouseY));
         return _loc1_ || super.isViewPortUnderMouse();
      }
      
      public function goToItem(param1:int, param2:Boolean, param3:Boolean = false) : void
      {
         this._goToIndex = param1;
         this.scrollIfRendererVisible = param2;
         this.scrollImmediately = param3;
         invalidate(INVALID_GO_TO_INDEX);
      }
      
      public function setHitArea(param1:Sprite) : void
      {
         this._hitArea = param1;
         invalidate(INVALIDATION_TYPE_INTERACTION_MODE);
      }
      
      public function setScrollbar(param1:IScrollBar) : void
      {
         this.unsubscribeFromScrollbar();
         this.scrollbarRef = ScrollBar(param1);
         if(this.scrollbarRef != null)
         {
            this.scrollbarRef.addEventListener(Event.SCROLL,this.onScrollbarRefScrollHandler);
            this.scrollbarRef.addEventListener(ScrollBarEvent.ON_END_DRAG,this.onScrollBarRefOnEndDragHandler);
         }
         invalidate(INVALIDATION_TYPE_SCROLLBAR);
      }
      
      public function startScrollToBegin() : void
      {
         if(this.availableScrollLeft)
         {
            this.equableScrolling = true;
            this.scrollToBegin = true;
            this.startScroll();
         }
      }
      
      public function startScrollToEnd() : void
      {
         if(this.availableScrollRight)
         {
            this.equableScrolling = true;
            this.scrollToEnd = true;
            this.startScroll();
         }
      }
      
      public function stopScroll() : void
      {
      }
      
      protected function configureViewPort() : void
      {
         this._viewPort = new this.viewPortClass();
         this._viewPort.owner = this;
         this._viewPort.horizontalGap = this.horizontalGap;
         this._viewPort.verticalGap = this.verticalGap;
         this._viewPort.selectedIndex = this.selectedIndex;
         this._viewPort.tooltipDecorator = this.tooltipDecorator;
         this._viewPort.name = VIEW_PORT_NAME;
         this._viewPort.showRendererOnlyIfDataExists = this._showRendererOnlyIfDataExists;
         viewPort = this._viewPort;
      }
      
      protected function refreshDataViewPortProperties() : void
      {
         this.dataViewPort.rendererWidth = this._rendererWidth;
         this.dataViewPort.rendererHeight = this._rendererHeight;
         this.dataViewPort.itemRendererFactory = this._itemRendererFactory;
         this.dataViewPort.horizontalGap = this._horizontalGap;
         this.dataViewPort.verticalGap = this._verticalGap;
      }
      
      protected function unsubscribeFromScrollbar() : void
      {
         if(this.scrollbarRef != null)
         {
            this.scrollbarRef.removeEventListener(Event.SCROLL,this.onScrollbarRefScrollHandler);
            this.scrollbarRef.removeEventListener(ScrollBarEvent.ON_END_DRAG,this.onScrollBarRefOnEndDragHandler);
         }
      }
      
      protected function onEndScrollBarDrag() : void
      {
      }
      
      protected function onEndScrollBarScroll() : void
      {
      }
      
      private function updateCursorManager() : void
      {
         var _loc1_:Rectangle = null;
         if(this._hitArea)
         {
            _loc1_ = this._hitArea.getBounds(DisplayObject(this));
         }
         else
         {
            _loc1_ = new Rectangle(viewPortOffsetLeft,viewPortOffsetTop,width - viewPortOffsetLeft - viewPortOffsetRight,height - viewPortOffsetTop - viewPortOffsetBottom);
         }
         this.cursorManager.setTouchRect(_loc1_);
      }
      
      public function get selectedIndex() : int
      {
         if(viewPort != null)
         {
            return this.dataViewPort.selectedIndex;
         }
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(viewPort != null)
         {
            this.dataViewPort.selectedIndex = param1;
         }
         this._selectedIndex = param1;
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
         invalidate(InvalidationType.SETTINGS);
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
         invalidate(InvalidationType.SETTINGS);
      }
      
      [Inspectable(name="itemRenderer",type="String")]
      public function get itemRendererClassReference() : String
      {
         return this._itemRendererLinkage;
      }
      
      public function set itemRendererClassReference(param1:String) : void
      {
         if(!StringUtils.isEmpty(param1))
         {
            this._itemRendererLinkage = param1;
            this._itemRendererFactory = App.instance.utils.classFactory.getClass(param1);
            invalidate(InvalidationType.SETTINGS);
         }
      }
      
      [Inspectable(name="snapScrollPositionToItemRendererSize",type="Boolean")]
      public function get snapScrollPositionToItemRendererSize() : Boolean
      {
         return this._snapScrollPositionToItemRendererSize;
      }
      
      public function set snapScrollPositionToItemRendererSize(param1:Boolean) : void
      {
         this._snapScrollPositionToItemRendererSize = param1;
      }
      
      public function get dataProvider() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:IDataProvider) : void
      {
         if(param1 != this._dataProvider)
         {
            if(this._dataProvider != null)
            {
               this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            this._dataProvider = param1;
            if(this._dataProvider != null)
            {
               this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            }
            invalidateData();
         }
      }
      
      public function get goToOffset() : Number
      {
         return this._goToOffset;
      }
      
      public function set goToOffset(param1:Number) : void
      {
         this._goToOffset = param1;
      }
      
      public function get availableScrollLeft() : Boolean
      {
         return false;
      }
      
      public function get availableScrollRight() : Boolean
      {
         return false;
      }
      
      public function get availableScrollUp() : Boolean
      {
         return false;
      }
      
      public function get availableScrollDown() : Boolean
      {
         return false;
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
         invalidate(InvalidationType.SETTINGS);
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
         invalidate(InvalidationType.SETTINGS);
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
            invalidate(InvalidationType.SETTINGS);
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
            invalidate(InvalidationType.SETTINGS);
         }
      }
      
      public function get goToDuration() : Number
      {
         return this._goToDuration;
      }
      
      public function set goToDuration(param1:Number) : void
      {
         this._goToDuration = param1;
      }
      
      [Inspectable(name="useExtendedViewPort",type="Boolean")]
      public function get useExtendedViewPort() : Boolean
      {
         return this._useExtendedViewPort;
      }
      
      public function set useExtendedViewPort(param1:Boolean) : void
      {
         this._useExtendedViewPort = param1;
      }
      
      public function get goToIndex() : int
      {
         return this._goToIndex;
      }
      
      public function get viewPortClass() : Class
      {
         var _loc1_:String = GET_VIEW_PORT_CLASS + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc1_);
         throw new AbstractException(_loc1_);
      }
      
      public function addUnmanagedChild(param1:DisplayObject, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            this._viewPort.addChild(param1);
         }
         else
         {
            this._viewPort.addChildAt(param1,param2);
         }
      }
      
      public function removeUnmanagedChild(param1:DisplayObject) : void
      {
         this._viewPort.removeChild(param1);
      }
      
      protected function get dataViewPort() : IScrollerViewPort
      {
         return IScrollerViewPort(this.viewPort);
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         invalidateData();
      }
      
      private function onScrollBarRefOnEndDragHandler(param1:Event) : void
      {
         this.onEndScrollBarDrag();
      }
      
      private function onScrollbarRefScrollHandler(param1:Event) : void
      {
         if(!this.ignoreScrollBarHandler)
         {
            this.scrollBarHandlingInProgress = true;
            this.startScroll();
            this.onEndScrollBarScroll();
            this.completeScroll();
            dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_COMPLETE));
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
   }
}
