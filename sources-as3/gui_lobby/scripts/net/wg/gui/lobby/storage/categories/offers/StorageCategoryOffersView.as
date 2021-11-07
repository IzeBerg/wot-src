package net.wg.gui.lobby.storage.categories.offers
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.infrastructure.base.meta.IStorageCategoryOffersViewMeta;
   import net.wg.infrastructure.base.meta.impl.StorageCategoryOffersViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class StorageCategoryOffersView extends StorageCategoryOffersViewMeta implements IStorageCategoryOffersViewMeta
   {
      
      private static const CAROUSEL_TOP_OFFSET:int = 10;
      
      private static const CAROUSEL_BOTTOM_OFFSET:int = 30;
       
      
      public var noItemsView:NoItemsView;
      
      public var title:TextField;
      
      public function StorageCategoryOffersView()
      {
         super();
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new ListDAAPIDataProvider(BaseCardVO);
      }
      
      override protected function onDispose() : void
      {
         this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
         this.noItemsView.dispose();
         this.noItemsView = null;
         this.title = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.text = STORAGE.OFFERS_SECTIONTITLE;
         this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
         this.noItemsView.setTexts(STORAGE.OFFERS_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
         this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         carousel.scrollList.itemRendererClassReference = Linkages.OFFER_CARD_RENDERER;
         carousel.scrollList.paddingTop = CAROUSEL_TOP_OFFSET;
         carousel.scrollList.paddingBottom = CAROUSEL_BOTTOM_OFFSET;
         carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.title.x = carousel.x;
            _loc1_ = this.title.y + this.title.height;
            this.noItemsView.width = width;
            this.noItemsView.validateNow();
            this.noItemsView.y = _loc1_ + (height - _loc1_ - this.noItemsView.actualHeight >> 1);
         }
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
      
      private function onCardSellHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         openOfferWindowS(param1.data.id);
      }
      
      private function onNoItemViewCloseHandler(param1:Event) : void
      {
         navigateToStoreS();
      }
   }
}
