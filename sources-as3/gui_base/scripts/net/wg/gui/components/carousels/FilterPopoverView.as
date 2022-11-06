package net.wg.gui.components.carousels
{
   import net.wg.gui.components.controls.BlackButton;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.popovers.PopOverConst;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class FilterPopoverView extends VehiclesFilterPopoverView
   {
      
      private static const DEFAULT_BTN_OFFSET:uint = 20;
      
      private static const SCROLL_STEP_FACTOR:int = 30;
      
      private static const SCROLL_PANE_MAX_HEIGHT:uint = 391;
       
      
      public var scrollBar:ScrollBar = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var switchCarouselBtn:BlackButton = null;
      
      public function FilterPopoverView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.switchCarouselBtn.toggleEnable = true;
         this.switchCarouselBtn.addEventListener(ButtonEvent.CLICK,this.onSwitchCarouselBtnClickHandler);
         this.scrollPane.scrollBar = this.scrollBar;
         this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
         this.scrollPane.target = content;
         this.scrollPane.scrollPosition = 0;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(initData && isInvalid(InvalidationType.DATA))
         {
            this.switchCarouselBtn.iconSource = initData.toggleSwitchCarouselIcon;
            this.switchCarouselBtn.tooltip = initData.toggleSwitchCarouselTooltip;
            this.switchCarouselBtn.selected = initData.toggleSwitchCarouselSelected;
            this.switchCarouselBtn.visible = initData.searchSectionVisible;
         }
      }
      
      override protected function onDispose() : void
      {
         this.switchCarouselBtn.removeEventListener(ButtonEvent.CLICK,this.onSwitchCarouselBtnClickHandler);
         this.switchCarouselBtn.dispose();
         this.switchCarouselBtn = null;
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
         setViewSize(width,this.getNewHeight(this.scrollPane.y + this.scrollPane.height));
      }
      
      override protected function getNewHeight(param1:int) : int
      {
         var _loc2_:int = super.getNewHeight(param1);
         if(initData.searchSectionVisible)
         {
            this.switchCarouselBtn.y = separatorBottom.y + separatorBottom.height + DEFAULT_BTN_OFFSET | 0;
            _loc2_ = this.switchCarouselBtn.y + this.switchCarouselBtn.height + PADDING;
         }
         return _loc2_;
      }
      
      private function onSwitchCarouselBtnClickHandler(param1:ButtonEvent) : void
      {
         this.switchCarouselBtn.selected = !this.switchCarouselBtn.selected;
         switchCarouselTypeS(this.switchCarouselBtn.selected);
      }
   }
}
