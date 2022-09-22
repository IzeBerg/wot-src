package net.wg.gui.lobby.sessionStats
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.VerticalGroupLayout;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import net.wg.gui.lobby.components.events.DashLineTextItemRendererEvent;
   import net.wg.gui.lobby.sessionStats.components.SessionStatsInfoParamsRenderer;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsEfficiencyParamVO;
   
   public class SessionStatsEfficiencyParamBlock extends SessionStatsParamsListBlock
   {
      
      private static const PARAMS_GAP:int = 30;
      
      private static const DESCRIPTION_GAP:int = 25;
      
      private static const TOTAL_BLOCK_GAP:int = 40;
       
      
      public var icon:Image = null;
      
      public var titleTf:TextField = null;
      
      public var descriptionTf:TextField = null;
      
      public var total:SessionStatsInfoParamsRenderer = null;
      
      private var _dataVO:SessionStatsEfficiencyParamVO = null;
      
      public function SessionStatsEfficiencyParamBlock()
      {
         super();
         this.titleTf.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:VerticalGroupLayout = new VerticalGroupLayout();
         _loc1_.gap = SessionBattleStatsView.COLLAPSE_GAP;
         list.layout = _loc1_;
         list.itemRendererLinkage = Linkages.SESSION_STATS_PARAM_RENDERER;
         list.addEventListener(DashLineTextItemRendererEvent.TEXT_SIZE_CHANGED,this.onTextSizeChangedHandler);
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this._dataVO = new SessionStatsEfficiencyParamVO(param1);
         this.titleTf.htmlText = this._dataVO.title;
         this.descriptionTf.htmlText = this._dataVO.description;
         this.icon.source = this._dataVO.icon;
         list.dataProvider = this._dataVO.params;
         if(this._dataVO.total)
         {
            this.total.update(this._dataVO.total);
         }
         else
         {
            this.total.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         list.removeEventListener(DashLineTextItemRendererEvent.TEXT_SIZE_CHANGED,this.onTextSizeChangedHandler);
         this.titleTf = null;
         this.descriptionTf = null;
         this.icon.dispose();
         this.icon = null;
         this.total.dispose();
         this.total = null;
         if(this._dataVO)
         {
            this._dataVO.dispose();
            this._dataVO = null;
         }
         super.onDispose();
      }
      
      override protected function onListResized(param1:Event) : void
      {
         this.descriptionTf.y = this.titleTf.y + this.titleTf.textHeight + DESCRIPTION_GAP;
         list.y = this.descriptionTf.y + this.descriptionTf.textHeight + PARAMS_GAP;
         if(this.total.visible && this.total.hasValue)
         {
            this.total.y = Boolean(list.dataProvider.length) ? Number(list.y + list.height + TOTAL_BLOCK_GAP) : Number(list.y);
         }
         invalidateBlock();
         dispatchEvent(new ToolTipBlockEvent(ToolTipBlockEvent.SIZE_CHANGE,this));
      }
      
      private function onTextSizeChangedHandler(param1:DashLineTextItemRendererEvent) : void
      {
         list.invalidateLayout();
      }
   }
}
