package net.wg.gui.battle.epicBattle.views
{
   import net.wg.gui.components.carousels.VehiclesFilterPopoverView;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.popovers.PopOverConst;
   
   public class EpicCarouselFilterPopoverView extends VehiclesFilterPopoverView
   {
      
      private static const SCROLL_STEP_FACTOR:int = 30;
      
      private static const SCROLL_PANE_MAX_HEIGHT:uint = 391;
       
      
      public var scrollBar:ScrollBar = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public function EpicCarouselFilterPopoverView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.scrollPane.scrollBar = this.scrollBar;
         this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.scrollPane.target = content;
         this.scrollPane.scrollPosition = 0;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.scrollPane.target = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.scrollBar = null;
         super.onDispose();
      }
      
      override protected function getPreferredLayout() : int
      {
         return PopOverConst.ARROW_BOTTOM;
      }
      
      override protected function updateSize() : void
      {
         this.scrollPane.setSize(width,Math.min(content.height,SCROLL_PANE_MAX_HEIGHT));
         this.scrollBar.height = this.scrollPane.height;
         setViewSize(width,getNewHeight(this.scrollPane.y + this.scrollPane.height));
      }
   }
}
