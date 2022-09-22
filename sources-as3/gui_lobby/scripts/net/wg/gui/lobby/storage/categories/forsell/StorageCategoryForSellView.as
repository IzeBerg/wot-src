package net.wg.gui.lobby.storage.categories.forsell
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.infrastructure.base.meta.IStorageCategoryForSellViewMeta;
   import net.wg.infrastructure.base.meta.impl.StorageCategoryForSellViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class StorageCategoryForSellView extends StorageCategoryForSellViewMeta implements IStorageCategoryForSellViewMeta
   {
      
      private static const CAROUSEL_TOP_OFFSET:int = 25;
      
      private static const CAROUSEL_BOTTOM_OFFSET:int = 30;
      
      private static const BUY_BLOCK_HEIGHT:int = 62;
       
      
      public var title:TextField;
      
      public var buyBlock:BuyBlock;
      
      public var noItemsView:NoItemsView;
      
      public function StorageCategoryForSellView()
      {
         super();
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new ListDAAPIDataProvider(BaseCardVO);
      }
      
      override protected function init(param1:StorageCategoryForSellVO) : void
      {
         this.buyBlock.setData(param1);
      }
      
      override protected function doPartlyVisibility(param1:Boolean, param2:Boolean) : void
      {
         super.doPartlyVisibility(param1,param2);
         this.buyBlock.visible = !param1;
      }
      
      override protected function onDispose() : void
      {
         this.noItemsView.removeEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         carousel.removeEventListener(CardEvent.DESELECT,this.onCardDeselectHandler);
         carousel.removeEventListener(CardEvent.SELECT,this.onCardSelectHandler);
         carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
         this.buyBlock.removeEventListener(BuyBlockEvent.DESELECT_ALL,this.onBuyBlockDeselectAllHandler);
         this.buyBlock.removeEventListener(BuyBlockEvent.SELECT_ALL,this.onBuyBlockSelectAllHandler);
         this.buyBlock.removeEventListener(BuyBlockEvent.SELL,this.onBuyBlockSellHandler);
         this.buyBlock.dispose();
         this.buyBlock = null;
         this.title = null;
         this.noItemsView.dispose();
         this.noItemsView = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.text = STORAGE.FORSELL_SECTIONTITLE;
         this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
         this.buyBlock.addEventListener(BuyBlockEvent.DESELECT_ALL,this.onBuyBlockDeselectAllHandler);
         this.buyBlock.addEventListener(BuyBlockEvent.SELECT_ALL,this.onBuyBlockSelectAllHandler);
         this.buyBlock.addEventListener(BuyBlockEvent.SELL,this.onBuyBlockSellHandler);
         this.noItemsView.setTexts(STORAGE.FORSELL_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
         this.noItemsView.addEventListener(Event.CLOSE,this.onNoItemViewCloseHandler);
         carousel.scrollList.itemRendererClassReference = Linkages.SELECTABLE_CARD_RENDERER;
         carousel.scrollList.paddingTop = CAROUSEL_TOP_OFFSET;
         carousel.scrollList.paddingBottom = CAROUSEL_BOTTOM_OFFSET;
         carousel.addEventListener(CardEvent.DESELECT,this.onCardDeselectHandler);
         carousel.addEventListener(CardEvent.SELECT,this.onCardSelectHandler);
         carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.buyBlock.x = this.title.x = carousel.x;
            this.buyBlock.setSize(carousel.width,BUY_BLOCK_HEIGHT);
            _loc1_ = this.title.y + this.title.height;
            this.noItemsView.width = width;
            this.noItemsView.validateNow();
            this.noItemsView.y = _loc1_ + (height - _loc1_ - this.noItemsView.actualHeight >> 1);
         }
      }
      
      private function onBuyBlockDeselectAllHandler(param1:BuyBlockEvent) : void
      {
         selectAllS(false);
      }
      
      private function onBuyBlockSelectAllHandler(param1:BuyBlockEvent) : void
      {
         selectAllS(true);
      }
      
      private function onBuyBlockSellHandler(param1:BuyBlockEvent) : void
      {
         sellAllS();
      }
      
      private function onCardDeselectHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         selectItemS(param1.data.id,false);
      }
      
      private function onCardSelectHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         selectItemS(param1.data.id,true);
      }
      
      private function onCardSellHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         sellItemS(param1.data.id);
      }
      
      private function onNoItemViewCloseHandler(param1:Event) : void
      {
         navigateToStoreS();
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
   }
}
