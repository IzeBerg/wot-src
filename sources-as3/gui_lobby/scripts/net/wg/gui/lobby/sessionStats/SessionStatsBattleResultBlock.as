package net.wg.gui.lobby.sessionStats
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.components.common.containers.TiledLayout;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsViewVO;
   
   public class SessionStatsBattleResultBlock extends SessionStatsParamsListBlock
   {
      
      private static const EXTRA_SPACE:int = 10;
       
      
      public var background:MovieClip = null;
      
      private var _dataVO:SessionBattleStatsViewVO = null;
      
      public function SessionStatsBattleResultBlock()
      {
         super();
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:TiledLayout = new TiledLayout(SessionBattleStatsView.TILE_WIDTH,SessionBattleStatsView.TILE_HEIGHT,SessionBattleStatsView.TILE_COLS,TEXT_ALIGN.LEFT);
         _loc1_.gap = SessionBattleStatsView.TILE_GAP;
         list.layout = _loc1_;
         list.itemRendererLinkage = Linkages.SESSION_LAST_BATTLE_STATS_RENDERER_UI;
      }
      
      override protected function onListResized(param1:Event) : void
      {
         this.background.height = list.height + (list.y << 1) + EXTRA_SPACE;
      }
      
      override public function setBlockWidth(param1:int) : void
      {
      }
      
      override public function setBlockData(param1:Object) : void
      {
         this._dataVO = new SessionBattleStatsViewVO(param1);
         this.applyData();
      }
      
      override protected function applyData() : void
      {
         list.dataProvider = this._dataVO.lastBattle;
      }
      
      override protected function onDispose() : void
      {
         if(this._dataVO)
         {
            this._dataVO.dispose();
            this._dataVO = null;
         }
         this.background = null;
         super.onDispose();
      }
      
      protected function get dataVO() : SessionBattleStatsViewVO
      {
         return this._dataVO;
      }
   }
}
