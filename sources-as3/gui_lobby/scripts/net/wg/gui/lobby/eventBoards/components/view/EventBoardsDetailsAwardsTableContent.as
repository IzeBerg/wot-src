package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.ResizableTileList;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.eventBoards.components.AwardsTableHeader;
   import net.wg.gui.lobby.eventBoards.data.AwardsTableVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EventBoardsDetailsAwardsTableContent extends UIComponentEx
   {
      
      private static const SCROLL_BAR_TOP_PADDING:int = 8;
      
      private static const SCROLL_BAR_HEIGHT:int = 356;
      
      private static const NAME_CONTENT_CONTAINER:String = "contentContainer";
      
      private static const LIST_WIDTH:int = 750;
      
      private static const LIST_HEIGHT:int = 410;
      
      private static const RENDERER_CLASS_NAME:String = "OverlayAwardsRendererUI";
      
      private static const OFFSET_BOTTOM:int = 20;
       
      
      public var tableHeader:AwardsTableHeader = null;
      
      public var list:ResizableTileList = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var bounds:Sprite = null;
      
      protected var data:AwardsTableVO = null;
      
      protected var contentContainer:Sprite = null;
      
      public function EventBoardsDetailsAwardsTableContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.contentContainer = new Sprite();
         this.contentContainer.name = NAME_CONTENT_CONTAINER;
         addChild(this.contentContainer);
         this.scrollPane.target = this.contentContainer;
         this.contentContainer.hitArea = this.bounds;
         this.list.itemRendererName = RENDERER_CLASS_NAME;
         this.contentContainer.addChild(this.tableHeader);
         this.contentContainer.addChild(this.list);
         this.tableHeader.groupTF.htmlText = EVENT_BOARDS.SUMMARY_DESCRIPTION_AWARDS_TITLE_GROUP;
         this.tableHeader.positionTF.htmlText = EVENT_BOARDS.SUMMARY_DESCRIPTION_AWARDS_TITLE_POSITION;
         this.tableHeader.awardsTF.htmlText = EVENT_BOARDS.SUMMARY_DESCRIPTION_AWARDS_TITLE_AWARD;
         this.scrollPane.y = 0;
         this.scrollPane.contentPaddings.bottom = OFFSET_BOTTOM;
         this.scrollBar.height = SCROLL_BAR_HEIGHT;
         this.scrollBar.y = this.scrollPane.y + SCROLL_BAR_TOP_PADDING;
         this.bounds.width = LIST_WIDTH;
         this.bounds.height = LIST_HEIGHT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.data && isInvalid(InvalidationType.DATA))
         {
            this.list.dataProvider = this.data.tableData;
         }
      }
      
      public function setData(param1:AwardsTableVO) : void
      {
         this.data = param1;
         invalidateData();
      }
      
      override protected function onBeforeDispose() : void
      {
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         this.bounds = null;
         this.scrollPane.target = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.contentContainer = null;
         this.tableHeader.dispose();
         this.tableHeader = null;
         this.list.dispose();
         this.list = null;
         super.onDispose();
      }
   }
}
