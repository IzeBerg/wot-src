package net.wg.gui.lobby.storage.categories
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.events.DummyEvent;
   import net.wg.gui.components.advanced.interfaces.IDummy;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.infrastructure.base.meta.IBaseStorageCategoryViewMeta;
   import net.wg.infrastructure.base.meta.impl.BaseStorageCategoryViewMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class BaseCategoryView extends BaseStorageCategoryViewMeta implements IViewStackExContent, IBaseStorageCategoryViewMeta, ICategory
   {
      
      protected static const SCROLLBAR_OFFSET:int = 11;
      
      private static const PARTLY_VISIBILITY_INV:String = "partlyVisibilityInvalidate";
      
      private static const WARNING_DATA_INV:String = "warningDataInv";
       
      
      public var carousel:StorageCarousel;
      
      public var scrollBar:ScrollBar;
      
      public var noFilterWarningView:IDummy = null;
      
      private var cardsDP:IDataProvider;
      
      private var _hasNoFilterWarningView:Boolean = false;
      
      private var _isShowDummy:Boolean = false;
      
      private var _isShowFilterWarning:Boolean = false;
      
      private var _filterWarningVo:DummyVO = null;
      
      public function BaseCategoryView()
      {
         super();
         this._hasNoFilterWarningView = this.hasNoFilterWarningView();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.cardsDP = this.getNewCardDP();
         this.noItemsComponent.visible = false;
         if(this._hasNoFilterWarningView)
         {
            this.noFilterWarningView.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this._filterWarningVo = null;
         this.cardsDP = null;
         this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollHandler);
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.carousel.scrollList.removeEventListener(Event.RESIZE,this.onScrollListResized);
         this.carousel.removeEventListener(CardEvent.PLAY_INFO_SOUND,this.onCarouselPlayInfoSoundHandler);
         this.carousel.removeEventListener(CardEvent.SHOW_CONTEXT_MENU,this.onShowCardContextMenuHandler);
         this.carousel.removeEventListener(Event.RESIZE,this.onCarouselResizeHandler);
         this.carousel.dispose();
         this.carousel = null;
         if(this._hasNoFilterWarningView)
         {
            this.noFilterWarningView.removeEventListener(DummyEvent.CLICK,this.onNoFilterResultsClickHandler);
            this.noFilterWarningView.dispose();
            this.noFilterWarningView = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.carousel.scrollList.setScrollbar(this.scrollBar);
         this.carousel.dataProvider = this.cardsDP;
         this.carousel.addEventListener(Event.RESIZE,this.onCarouselResizeHandler);
         this.carousel.addEventListener(CardEvent.SHOW_CONTEXT_MENU,this.onShowCardContextMenuHandler);
         this.carousel.addEventListener(CardEvent.PLAY_INFO_SOUND,this.onCarouselPlayInfoSoundHandler);
         if(this._hasNoFilterWarningView)
         {
            this.noFilterWarningView.addEventListener(DummyEvent.CLICK,this.onNoFilterResultsClickHandler);
         }
         this.scrollBar.addEventListener(Event.SCROLL,this.onScrollHandler);
         this.carousel.scrollList.addEventListener(Event.RESIZE,this.onScrollListResized);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.carousel.height = height - this.carousel.y;
            this.carousel.x = width - this.carousel.width >> 1;
            this.scrollBar.y = this.carousel.y + this.carousel.scrollList.paddingTop | 0;
            this.scrollBar.x = width - this.scrollBar.width - SCROLLBAR_OFFSET >> 0;
            this.scrollBar.height = this.carousel.height - SCROLLBAR_OFFSET - this.carousel.scrollList.paddingTop >> 0;
            if(this._hasNoFilterWarningView)
            {
               this.noFilterWarningView.x = this.carousel.x;
               this.noFilterWarningView.y = this.carousel.y;
               this.noFilterWarningView.width = this.carousel.width;
               this.noFilterWarningView.height = this.carousel.height;
            }
         }
         if(this._hasNoFilterWarningView && this._filterWarningVo && isInvalid(WARNING_DATA_INV))
         {
            this.noFilterWarningView.setData(this._filterWarningVo);
         }
         if(isInvalid(PARTLY_VISIBILITY_INV))
         {
            this.doPartlyVisibility(this._isShowDummy,this._isShowFilterWarning);
         }
      }
      
      override protected function showFilterWarning(param1:DummyVO) : void
      {
         if(this._isShowFilterWarning != param1.hasData)
         {
            this._isShowFilterWarning = param1.hasData;
            invalidate(PARTLY_VISIBILITY_INV);
         }
         this._filterWarningVo = param1;
         invalidate(WARNING_DATA_INV);
      }
      
      public function as_getCardsDP() : Object
      {
         return this.cardsDP;
      }
      
      public function as_scrollToItem(param1:int) : void
      {
      }
      
      public function as_showDummyScreen(param1:Boolean) : void
      {
         if(this._isShowDummy == param1)
         {
            return;
         }
         this._isShowDummy = param1;
         invalidate(PARTLY_VISIBILITY_INV);
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setActive(param1:Boolean) : void
      {
         setActiveStateS(param1);
      }
      
      public function setHitArea(param1:Sprite) : void
      {
         this.carousel.scrollList.setHitArea(param1);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function getNewCardDP() : IDataProvider
      {
         return null;
      }
      
      protected function hasNoFilterWarningView() : Boolean
      {
         return false;
      }
      
      protected function onDummyEvent(param1:String) : void
      {
      }
      
      protected function doPartlyVisibility(param1:Boolean, param2:Boolean) : void
      {
         this.carousel.visible = !(param1 || param2);
         this.noItemsComponent.visible = param1;
         if(param1)
         {
            this.scrollBar.visible = false;
         }
         if(this._hasNoFilterWarningView)
         {
            this.noFilterWarningView.visible = param2;
         }
      }
      
      public function get contentWidth() : int
      {
         return this.carousel.width;
      }
      
      public function get noItemsComponent() : UIComponent
      {
         throw new AbstractException("BaseCategoryView.noItemsComponent" + Errors.ABSTRACT_INVOKE);
      }
      
      private function onNoFilterResultsClickHandler(param1:DummyEvent) : void
      {
         this.onDummyEvent(param1.clickType);
      }
      
      private function onCarouselResizeHandler(param1:Event) : void
      {
         invalidateSize();
         validateNow();
      }
      
      private function onCarouselPlayInfoSoundHandler(param1:CardEvent) : void
      {
         playInfoSoundS();
      }
      
      private function onScrollHandler(param1:Event) : void
      {
         if(!this.carousel.scrollList.availableScrollDown)
         {
            scrolledToBottomS();
         }
      }
      
      private function onScrollListResized(param1:Event) : void
      {
         if(!this.scrollBar.visible)
         {
            scrolledToBottomS();
         }
      }
      
      private function onShowCardContextMenuHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         App.contextMenuMgr.show(param1.data.contextMenuId,DisplayObject(param1.target),param1.data);
         App.toolTipMgr.hide();
      }
   }
}
