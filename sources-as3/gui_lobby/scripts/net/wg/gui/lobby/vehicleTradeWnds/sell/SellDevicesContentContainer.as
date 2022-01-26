package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import net.wg.data.VO.SellDialogItem;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.interfaces.ISaleItemBlockRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SellDevicesContentContainer extends UIComponentEx
   {
      
      private static const SCROLL_WIDTH:uint = 477;
      
      private static const SCROLL_ACTIVE_WIDTH:uint = 457;
      
      private static const SCROLL_ACTIVE_MIN_RENDERER:uint = 3;
       
      
      public var scrollingRenderer:SellDialogListItemRenderer = null;
      
      public function SellDevicesContentContainer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.scrollingRenderer.removeEventListener(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN,this.onSellDialogListItemRendererWasDrawn);
         this.scrollingRenderer.dispose();
         this.scrollingRenderer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.scrollingRenderer.addEventListener(VehicleSellDialogEvent.SELL_DIALOG_LIST_ITEM_RENDERER_WAS_DRAWN,this.onSellDialogListItemRendererWasDrawn);
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      private function getScrollingRendererWidth() : Number
      {
         return this.getRenderers().length > SCROLL_ACTIVE_MIN_RENDERER ? Number(SCROLL_ACTIVE_WIDTH) : Number(SCROLL_WIDTH);
      }
      
      private function onSellDialogListItemRendererWasDrawn(param1:VehicleSellDialogEvent) : void
      {
         this.scrollingRenderer.setSize(this.getScrollingRendererWidth(),this.scrollingRenderer.height);
         setSize(SCROLL_WIDTH,this.scrollingRenderer.height);
      }
      
      public function updateData(param1:SellDialogItem) : void
      {
         this.scrollingRenderer.setData(param1);
         invalidateData();
      }
      
      public function getRenderers() : Vector.<ISaleItemBlockRenderer>
      {
         return this.scrollingRenderer.getRenderers();
      }
   }
}
