package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.carousels.HorizontalScrollerViewPort;
   import net.wg.gui.components.carousels.ScrollCarousel;
   import net.wg.gui.components.controls.events.ScrollEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareScrollEvent;
   
   public class VehCompareTankCarousel extends ScrollCarousel
   {
      
      private static const SHADOW_ALPHA_WIDTH:int = 12;
      
      private static const RENDERER_WIDTH:int = 162;
      
      private static const ARROW_EXTRA_WIDTH:Number = 12;
       
      
      public var shadowLeft:Sprite;
      
      public var shadowRight:Sprite;
      
      public function VehCompareTankCarousel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         rendererWidth = RENDERER_WIDTH;
         scrollList.pageWidth = VehCompareVehParamRenderer.LINE_WIDTH;
         scrollList.hasHorizontalElasticEdges = false;
         scrollList.snapScrollPositionToItemRendererSize = false;
         scrollList.snapToPages = true;
         scrollList.cropContent = true;
         scrollList.viewPort.mouseEnabled = false;
         HorizontalScrollerViewPort(scrollList.viewPort).setNeedPreventInnerEvents(false);
         scrollList.addEventListener(Event.SCROLL,this.onScrollListScrollHandler);
         this.shadowLeft.mouseEnabled = this.shadowLeft.mouseChildren = false;
         this.shadowRight.mouseEnabled = this.shadowRight.mouseChildren = false;
         leftArrow.extraWidth = ARROW_EXTRA_WIDTH;
         rightArrow.extraWidth = ARROW_EXTRA_WIDTH;
      }
      
      override protected function updateLayout(param1:int, param2:int = 0) : void
      {
         scrollList.width = param1;
         scrollList.x = param2;
         leftArrow.x = scrollList.x + (leftArrow.width >> 1);
         rightArrow.x = scrollList.x + param1 - (rightArrow.width >> 1);
         this.shadowRight.x = scrollList.x + scrollList.width;
      }
      
      override protected function onDispose() : void
      {
         scrollList.removeEventListener(Event.SCROLL,this.onScrollListScrollHandler);
         this.shadowLeft = null;
         this.shadowRight = null;
         super.onDispose();
      }
      
      override protected function updateAvailableScroll(param1:Boolean, param2:Boolean) : void
      {
         super.updateAvailableScroll(param1,param2);
         leftArrow.visible = param1;
      }
      
      public function updateTableScrollPosition(param1:int) : void
      {
         scrollList.removeEventListener(Event.SCROLL,this.onScrollListScrollHandler);
         scrollList.moveToHorizontalScrollPosition(param1);
         scrollList.validateNow();
         scrollList.dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL_COMPLETE));
         this.updateBorders();
         scrollList.addEventListener(Event.SCROLL,this.onScrollListScrollHandler);
      }
      
      private function updateBorders() : void
      {
         this.shadowLeft.alpha = Math.min(scrollList.horizontalScrollPosition / SHADOW_ALPHA_WIDTH,1);
         this.shadowRight.alpha = Math.min((scrollList.maxHorizontalScrollPosition - scrollList.horizontalScrollPosition) / SHADOW_ALPHA_WIDTH,1);
         this.shadowLeft.visible = this.shadowLeft.alpha > 0;
      }
      
      private function onScrollListScrollHandler(param1:Event) : void
      {
         this.updateBorders();
         dispatchEvent(new VehCompareScrollEvent(VehCompareScrollEvent.SCROLL_CHANGED,scrollList.horizontalScrollPosition,scrollList.verticalScrollPosition,true));
      }
   }
}
