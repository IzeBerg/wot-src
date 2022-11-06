package net.wg.gui.lobby.components
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.ResizableScrollPane;
   
   public class AbstractPopoverWithScrollableComponentPanel extends AbstractPopoverComponentPanel
   {
      
      private static const SCROLL_STEP_FACTOR:Number = 10;
      
      private static const SCROLL_BAR_MARGIN:Number = 12;
      
      private static const SCOLLPANE_BOTTOM_MARGIN:int = 15;
       
      
      public var scrollpane:ResizableScrollPane = null;
      
      public function AbstractPopoverWithScrollableComponentPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.scrollpane.dispose();
         this.scrollpane = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.scrollpane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.scrollpane.scrollBarMargin = SCROLL_BAR_MARGIN;
         this.scrollpane.scrollBar = Linkages.SCROLL_BAR;
         this.scrollpane.setSize(this.getScrollPaneWidth(),body.height - SCOLLPANE_BOTTOM_MARGIN);
      }
      
      protected function getScrollPaneWidth() : int
      {
         return body.width;
      }
   }
}
