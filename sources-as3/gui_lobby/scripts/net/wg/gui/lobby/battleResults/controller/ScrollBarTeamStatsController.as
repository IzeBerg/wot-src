package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import scaleform.clik.data.DataProvider;
   
   public class ScrollBarTeamStatsController extends DefaultTeamStatsController
   {
      
      private static const MAX_RENDERERS_DISPLAYED:int = 17;
       
      
      public function ScrollBarTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override protected function initColumnsData(param1:CommonStatsVO) : void
      {
         super.initColumnsData(param1);
         columnWidth[ColumnConstants.PLAYER] = !!param1.isShowSquad ? ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH - ColumnConstants.SCROLLBAR_WIDTH : ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH + ColumnConstants.FIRST_COLUMN_WIDTH - ColumnConstants.SCROLLBAR_WIDTH;
      }
      
      override protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList) : void
      {
         param1.itemRendererName = Linkages.SCROLLBAR_TEAM_LEFT_MEMBER_RENDERER;
         param2.itemRendererName = Linkages.SCROLLBAR_TEAM_RIGHT_MEMBER_RENDERER;
      }
      
      override protected function setupList(param1:DataProvider, param2:CommonStatsVO, param3:TeamStatsList) : void
      {
         var _loc4_:Number = param3.rowHeight * MAX_RENDERERS_DISPLAYED;
         param3.height = _loc4_;
         super.setupList(param1,param2,param3);
      }
   }
}
