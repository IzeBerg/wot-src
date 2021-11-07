package net.wg.gui.lobby.storage.categories.personalreserves
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Aliases;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.infrastructure.base.meta.IStorageCategoryPersonalReservesViewMeta;
   import net.wg.infrastructure.base.meta.impl.StorageCategoryPersonalReservesViewMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class StorageCategoryPersonalReservesView extends StorageCategoryPersonalReservesViewMeta implements IStorageCategoryPersonalReservesViewMeta, IStageSizeDependComponent
   {
      
      private static const CAROUSEL_BOTTOM_OFFSET:int = 30;
      
      private static const CAROUSEL_TOP_OFFSET:int = 20;
      
      private static const CAROUSEL_Y_OFFSET:int = -33;
      
      private static const RESERVES_HEIGHT_TALL:int = 101;
      
      private static const RESERVES_HEIGHT_SMALL:int = 80;
      
      private static const FILTER_BLOCK_TOP_OFFSET:int = 27;
       
      
      public var title:TextField;
      
      public var reservesBlock:ActiveReservesBlock;
      
      public var noItemsView:NoItemsView;
      
      public var filtersBlock:PersonalReserveFilterBlock = null;
      
      public function StorageCategoryPersonalReservesView()
      {
         super();
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new ListDAAPIDataProvider(BaseCardVO);
      }
      
      override protected function hasNoFilterWarningView() : Boolean
      {
         return true;
      }
      
      override protected function doPartlyVisibility(param1:Boolean, param2:Boolean) : void
      {
         super.doPartlyVisibility(param1,param2);
         this.filtersBlock.visible = this.reservesBlock.visible = !param1;
      }
      
      override protected function onDispose() : void
      {
         this.filtersBlock.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersBlockFiltersChangedHandler);
         this.filtersBlock.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
         this.filtersBlock.dispose();
         this.filtersBlock = null;
         this.noItemsView.removeEventListener(Event.CLOSE,this.onNavigateToShopButtonClickHandler);
         this.noItemsView.dispose();
         this.noItemsView = null;
         this.reservesBlock.navigateToShopButton.removeEventListener(ButtonEvent.CLICK,this.onNavigateToShopButtonClickHandler);
         this.reservesBlock.dispose();
         this.reservesBlock = null;
         carousel.removeEventListener(CardEvent.SELL,this.onCarouselSellHandler);
         this.title = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.reservesBlock.boostersPanel,Aliases.BOOSTERS_PANEL);
      }
      
      override protected function onDummyEvent(param1:String) : void
      {
         resetFilterS();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.text = STORAGE.PERSONALRESERVES_SECTIONTITLE;
         this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
         carousel.scrollList.itemRendererClassReference = Linkages.PERSONAL_RESERVES_CARD_RENDERER;
         carousel.scrollList.paddingBottom = CAROUSEL_BOTTOM_OFFSET;
         carousel.scrollList.paddingTop = CAROUSEL_TOP_OFFSET;
         carousel.addEventListener(CardEvent.SELL,this.onCarouselSellHandler);
         this.reservesBlock.navigateToShopButton.addEventListener(ButtonEvent.CLICK,this.onNavigateToShopButtonClickHandler);
         this.filtersBlock.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersBlockFiltersChangedHandler);
         this.filtersBlock.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function init(param1:StorageCategoryPersonalReservesVO) : void
      {
         this.reservesBlock.setData(param1);
         if(param1.hasActiveReserve)
         {
            this.noItemsView.setTexts(STORAGE.PERSONALRESERVES_NOITEMS_TITLE);
         }
         else
         {
            this.noItemsView.setTexts(STORAGE.PERSONALRESERVES_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
            this.noItemsView.addEventListener(Event.CLOSE,this.onNavigateToShopButtonClickHandler);
         }
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.filtersBlock.x = carousel.x;
            this.filtersBlock.y = this.reservesBlock.y + this.reservesBlock.height + FILTER_BLOCK_TOP_OFFSET | 0;
            this.filtersBlock.width = carousel.width;
            carousel.y = this.filtersBlock.y + this.filtersBlock.height + CAROUSEL_Y_OFFSET | 0;
            this.reservesBlock.x = this.title.x = carousel.x;
            _loc1_ = !!this.reservesBlock.visible ? int(carousel.y) : int(0);
            this.noItemsView.width = width;
            this.noItemsView.validateNow();
            this.noItemsView.y = _loc1_ + (height - _loc1_ - this.noItemsView.actualHeight >> 1);
         }
      }
      
      override protected function initFilter(param1:ButtonFiltersVO, param2:ButtonFiltersVO) : void
      {
         this.filtersBlock.setData(param1,param2);
      }
      
      public function as_resetFilter(param1:int) : void
      {
         if(param1 >= 0)
         {
            this.filtersBlock.resetFilters(param1);
         }
      }
      
      public function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void
      {
         this.filtersBlock.updateCounter(param1,param2,param3);
         carousel.goToItem(0);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param2 < StageSizeBoundaries.HEIGHT_900;
         this.reservesBlock.isSmall = _loc3_;
         this.reservesBlock.setSize(carousel.width,!!_loc3_ ? Number(RESERVES_HEIGHT_SMALL) : Number(RESERVES_HEIGHT_TALL));
         this.reservesBlock.validateNow();
         invalidateSize();
         validateNow();
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
      
      private function onFiltersBlockFiltersChangedHandler(param1:FiltersEvent) : void
      {
         onFiltersChangeS(param1.filtersValue);
      }
      
      private function onCarouselSellHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         activateReserveS(param1.data.id);
      }
      
      private function onNavigateToShopButtonClickHandler(param1:Event) : void
      {
         navigateToStoreS();
      }
      
      private function onFiltersBlockResetAllFiltersHandler(param1:FiltersEvent) : void
      {
         resetFilterS();
      }
   }
}
