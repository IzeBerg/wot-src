package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.data.DataProvider;
   
   public class SetVehiclesView extends UIComponentEx
   {
      
      private static const MAX_VEHICLES_IN_ROW:int = 3;
      
      private static const HORIZONTAL_GAP:int = 8;
      
      private static const RENDERER_HEIGHT:int = 97;
       
      
      public var carousel:VPScrollCarousel;
      
      public function SetVehiclesView()
      {
         super();
      }
      
      override public function get width() : Number
      {
         return this.carousel.width;
      }
      
      override public function get height() : Number
      {
         return this.carousel.height;
      }
      
      override protected function onDispose() : void
      {
         this.carousel.dispose();
         this.carousel = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.carousel.scrollList.mouseWheelDirection = DirectionMode.HORIZONTAL;
         this.carousel.scrollList.useTimer = true;
         this.carousel.scrollList.hasVerticalElasticEdges = true;
         this.carousel.scrollList.snapScrollPositionToItemRendererSize = false;
         this.carousel.scrollList.snapToPages = true;
         this.carousel.scrollList.cropContent = true;
         this.carousel.scrollList.showRendererOnlyIfDataExists = true;
         this.carousel.rendererWidth = SetVehiclesRenderer.WIDTH;
         this.carousel.rendererHeight = RENDERER_HEIGHT;
         this.carousel.horizontalGap = HORIZONTAL_GAP;
         this.carousel.pageWidth = SetVehiclesRenderer.WIDTH + HORIZONTAL_GAP;
         this.carousel.pageHeight = this.carousel.rendererHeight;
      }
      
      public function setData(param1:DataProvider) : void
      {
         this.carousel.scrollList.width = Math.min(param1.length,MAX_VEHICLES_IN_ROW) * (SetVehiclesRenderer.WIDTH + HORIZONTAL_GAP) - HORIZONTAL_GAP;
         this.carousel.showArrows(param1.length > MAX_VEHICLES_IN_ROW);
         this.carousel.dataProvider = param1;
         this.carousel.selectedIndex = 0;
      }
   }
}
