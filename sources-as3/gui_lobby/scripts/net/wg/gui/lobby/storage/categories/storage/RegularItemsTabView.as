package net.wg.gui.lobby.storage.categories.storage
{
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.BaseCardVO;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.infrastructure.base.meta.IRegularItemsTabViewMeta;
   import net.wg.infrastructure.base.meta.impl.RegularItemsTabViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class RegularItemsTabView extends RegularItemsTabViewMeta implements IRegularItemsTabViewMeta
   {
      
      private static const CAROUSEL_PADDING_TOP:int = 5;
      
      private static const CAROUSEL_PADDING_BOTTOM:int = 30;
       
      
      public var noItemsView:NoItemsView;
      
      public function RegularItemsTabView()
      {
         super();
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new ListDAAPIDataProvider(BaseCardVO);
      }
      
      override protected function onDispose() : void
      {
         this.noItemsView.dispose();
         this.noItemsView = null;
         carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
         carousel.removeEventListener(CardEvent.UPGRADE,this.onCardUpgradeHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         carousel.scrollList.itemRendererClassReference = Linkages.DEFAULT_CARD_RENDERER;
         carousel.scrollList.paddingTop = CAROUSEL_PADDING_TOP;
         carousel.scrollList.paddingBottom = CAROUSEL_PADDING_BOTTOM;
         carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
         carousel.addEventListener(CardEvent.UPGRADE,this.onCardUpgradeHandler);
      }
      
      override protected function initNoItemsView() : void
      {
         this.noItemsView.setTexts(STORAGE.STORAGE_NOITEMS_TITLE,STORAGE.STORAGE_NOITEMS_NAVIGATIONBUTTON);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.noItemsView.width = width;
            this.noItemsView.validateNow();
            this.noItemsView.y = height - this.noItemsView.actualHeight >> 1;
         }
      }
      
      override protected function onNoItemsViewClose() : void
      {
         navigateToStoreS();
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
      
      private function onCardUpgradeHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         upgradeItemS(param1.data.id);
      }
      
      private function onCardSellHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         sellItemS(param1.data.id);
      }
   }
}
