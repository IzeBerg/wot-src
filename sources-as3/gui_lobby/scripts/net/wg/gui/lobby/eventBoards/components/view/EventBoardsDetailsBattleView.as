package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.lobby.eventBoards.components.BattleViewTableHeader;
   import net.wg.gui.lobby.eventBoards.components.battleComponents.BattleExperienceBlock;
   import net.wg.gui.lobby.eventBoards.components.battleComponents.BattleStatisticsBlock;
   import net.wg.gui.lobby.eventBoards.data.BattleExperienceBlockVO;
   import net.wg.gui.lobby.eventBoards.data.BattleStatisticsBlockVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableRendererContainerVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsBattleOverlayVO;
   import net.wg.infrastructure.base.meta.IEventBoardsBattleOverlayMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsBattleOverlayMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class EventBoardsDetailsBattleView extends EventBoardsBattleOverlayMeta implements IEventBoardsBattleOverlayMeta
   {
      
      private static const EXPERIENCE_OFFSET_Y1:int = 123;
      
      private static const EXPERIENCE_OFFSET_Y2:int = 79;
      
      private static const FADE_BILLET_Y1:int = 245;
      
      private static const FADE_BILLET_Y2:int = 205;
      
      private static const FADE_BILLET_HEIGHT1:int = 228;
      
      private static const FADE_BILLET_HEIGHT2:int = 267;
       
      
      public var titleTf:TextField = null;
      
      public var descriptionTf:TextField = null;
      
      public var description2Tf:TextField = null;
      
      public var statusTf:TextField = null;
      
      public var tableHeaderBattle:BattleViewTableHeader = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var experienceBlock:BattleExperienceBlock = null;
      
      public var statisticsBlock:BattleStatisticsBlock = null;
      
      public var fadeBillet:Sprite = null;
      
      public var dividerTop:Sprite = null;
      
      private var _data:EventBoardsBattleOverlayVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function EventBoardsDetailsBattleView()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.statusTf.addEventListener(MouseEvent.ROLL_OVER,this.onStatusRollOverHandler);
         this.statusTf.addEventListener(MouseEvent.ROLL_OUT,this.onStatusRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleTf.htmlText = this._data.title;
            this.descriptionTf.htmlText = this._data.description;
            this.description2Tf.htmlText = this._data.description2;
            this.statusTf.htmlText = this._data.status;
            this.tableHeaderBattle.visible = this.scrollPane.visible = this._data.isTable;
            this.dividerTop.visible = this.statisticsBlock.visible = !this._data.isTable;
            this.tableHeaderBattle.isSquad = this._data.isSquad;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.titleTf = null;
         this.descriptionTf = null;
         this.description2Tf = null;
         this.statusTf.removeEventListener(MouseEvent.ROLL_OVER,this.onStatusRollOverHandler);
         this.statusTf.removeEventListener(MouseEvent.ROLL_OUT,this.onStatusRollOutHandler);
         this.statusTf = null;
         this.fadeBillet = null;
         this.dividerTop = null;
         this.tableHeaderBattle.dispose();
         this.tableHeaderBattle = null;
         this.scrollPane.target = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.experienceBlock.dispose();
         this.experienceBlock = null;
         this.statisticsBlock.dispose();
         this.statisticsBlock = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function updateLayout() : void
      {
         this.experienceBlock.y = !!this.tableHeaderBattle.visible ? Number(EXPERIENCE_OFFSET_Y2) : Number(EXPERIENCE_OFFSET_Y1);
         this.fadeBillet.y = !!this.tableHeaderBattle.visible ? Number(FADE_BILLET_Y2) : Number(FADE_BILLET_Y1);
         this.fadeBillet.height = !!this.tableHeaderBattle.visible ? Number(FADE_BILLET_HEIGHT2) : Number(FADE_BILLET_HEIGHT1);
      }
      
      override protected function setData(param1:EventBoardsBattleOverlayVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setExperienceData(param1:BattleExperienceBlockVO) : void
      {
         this.experienceBlock.setData(param1);
      }
      
      override protected function setStatisticsData(param1:BattleStatisticsBlockVO) : void
      {
         this.statisticsBlock.setData(param1);
      }
      
      override protected function setTableHeaderData(param1:EventBoardTableHeaderVO) : void
      {
         this.tableHeaderBattle.update(param1);
      }
      
      override protected function setTableData(param1:EventBoardTableRendererContainerVO) : void
      {
         var _loc2_:EventBoardTableContent = EventBoardTableContent(this.scrollPane.target);
         _loc2_.setData(param1);
         this.scrollPane.invalidateSize();
      }
      
      private function onStatusRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._data.statusTooltip);
      }
      
      private function onStatusRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
