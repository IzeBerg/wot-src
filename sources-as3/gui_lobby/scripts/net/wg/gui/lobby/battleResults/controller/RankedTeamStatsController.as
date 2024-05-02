package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   
   public class RankedTeamStatsController extends DefaultTeamStatsController
   {
       
      
      public function RankedTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override protected function initColumnsData(param1:CommonStatsVO) : void
      {
         super.initColumnsData(param1);
         columnWidth[ColumnConstants.PLAYER] = ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH;
         columnWidth[ColumnConstants.RANK] = ColumnConstants.FIRST_COLUMN_WIDTH;
         sortingKey[ColumnConstants.RANK] = [ColumnConstants.KEY_RANK];
         columnTooltip[ColumnConstants.RANK] = BATTLE_RESULTS.TEAM_RANKHEADER;
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         _loc2_.push(ColumnConstants.RANK);
         _loc2_.push(ColumnConstants.PLAYER);
         _loc2_.push(ColumnConstants.TANK);
         _loc2_.push(ColumnConstants.DAMAGE);
         _loc2_.push(ColumnConstants.FRAG);
         _loc2_.push(ColumnConstants.XP);
         _loc2_.push(ColumnConstants.MEDAL);
         return _loc2_;
      }
      
      override protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList) : void
      {
         param1.itemRendererName = Linkages.RANKED_TEAM_LEFT_MEMBER_RENDERER;
         param2.itemRendererName = Linkages.RANKED_TEAM_RIGHT_MEMBER_RENDERER;
      }
   }
}
