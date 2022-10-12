package net.wg.gui.lobby.storage.categories.inhangar
{
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.storage.categories.NoItemsView;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.gui.lobby.storage.categories.cards.VehicleCardVO;
   import net.wg.infrastructure.base.meta.IRentVehiclesTabViewMeta;
   import net.wg.infrastructure.base.meta.impl.RentVehiclesTabViewMeta;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class RentVehiclesTabView extends RentVehiclesTabViewMeta implements IRentVehiclesTabViewMeta
   {
      
      private static const CAROUSEL_PADDING_TOP:int = 5;
      
      private static const CAROUSEL_PADDING_BOTTOM:int = 30;
       
      
      public var noItemsView:NoItemsView;
      
      public function RentVehiclesTabView()
      {
         super();
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new ListDAAPIDataProvider(VehicleCardVO);
      }
      
      override protected function onDispose() : void
      {
         carousel.removeEventListener(CardEvent.REMOVE,this.onCardRemoveHandler);
         this.noItemsView.dispose();
         this.noItemsView = null;
         super.onDispose();
      }
      
      override protected function initNoItemsView() : void
      {
         this.noItemsView.setTexts(STORAGE.INHANGAR_NOITEMS_RENTTAB_TITLE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         carousel.scrollList.itemRendererClassReference = Linkages.RENT_VEHICLE_CARD_RENDERER;
         carousel.scrollList.paddingTop = CAROUSEL_PADDING_TOP;
         carousel.scrollList.paddingBottom = CAROUSEL_PADDING_BOTTOM;
         carousel.addEventListener(CardEvent.REMOVE,this.onCardRemoveHandler);
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
      
      private function onCardRemoveHandler(param1:CardEvent) : void
      {
         param1.stopImmediatePropagation();
         removeItemS(param1.data.id);
      }
   }
}
