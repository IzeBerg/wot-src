package net.wg.gui.lobby.storage.categories.inhangar
{
   import net.wg.data.VO.FilterDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.gui.lobby.storage.categories.cards.VehicleCardVO;
   import net.wg.infrastructure.base.meta.IAllVehiclesTabViewMeta;
   import net.wg.infrastructure.base.meta.impl.AllVehiclesTabViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AllVehiclesTabView extends AllVehiclesTabViewMeta implements IAllVehiclesTabViewMeta
   {
      
      private static const CAROUSEL_TOP_OFFSET:int = 20;
      
      private static const CAROUSEL_BOTTOM_OFFSET:int = 30;
       
      
      public var noItemsView:NoItemsView;
      
      public var filtersBlock:InHangarFilterBlock = null;
      
      public function AllVehiclesTabView()
      {
         super();
      }
      
      override protected function hasNoFilterWarningView() : Boolean
      {
         return true;
      }
      
      override protected function initNoItemsView() : void
      {
         this.noItemsView.setTexts(STORAGE.INHANGAR_NOITEMS_ALLTAB_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
      }
      
      override protected function doPartlyVisibility(param1:Boolean, param2:Boolean) : void
      {
         super.doPartlyVisibility(param1,param2);
         this.filtersBlock.visible = !param1 || param2;
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new FilterDAAPIDataProvider(VehicleCardVO);
      }
      
      override protected function onDispose() : void
      {
         carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
         this.filtersBlock.removeEventListener(FiltersEvent.SEARCH_VALUE_CHANGED,this.onFiltersBlockSearchValueChangedHandler);
         this.filtersBlock.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
         this.filtersBlock.dispose();
         this.filtersBlock = null;
         this.noItemsView.dispose();
         this.noItemsView = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         carousel.scrollList.itemRendererClassReference = Linkages.VEHICLE_CARD_RENDERER;
         carousel.scrollList.paddingTop = CAROUSEL_TOP_OFFSET;
         carousel.scrollList.paddingBottom = CAROUSEL_BOTTOM_OFFSET;
         carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
         this.filtersBlock.addEventListener(FiltersEvent.SEARCH_VALUE_CHANGED,this.onFiltersBlockSearchValueChangedHandler);
         this.filtersBlock.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.filtersBlock.x = carousel.x;
            this.filtersBlock.width = carousel.width;
            this.filtersBlock.validateNow();
         }
      }
      
      override protected function onDummyEvent(param1:String) : void
      {
         resetFilterS();
      }
      
      override protected function onNoItemsViewClose() : void
      {
         navigateToStoreS();
      }
      
      public function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void
      {
         this.filtersBlock.updateCounter(param1,param2,param3);
      }
      
      public function as_updateSearch(param1:String, param2:String, param3:String, param4:int) : void
      {
         this.filtersBlock.updateSearch(param1,param2,param3,param4);
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
      
      private function onCardSellHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         sellItemS(param1.data.id);
      }
      
      private function onFiltersBlockSearchValueChangedHandler(param1:FiltersEvent) : void
      {
         changeSearchNameVehicleS(param1.searchValue);
      }
      
      private function onFiltersBlockResetAllFiltersHandler(param1:FiltersEvent) : void
      {
         resetFilterS();
      }
   }
}
