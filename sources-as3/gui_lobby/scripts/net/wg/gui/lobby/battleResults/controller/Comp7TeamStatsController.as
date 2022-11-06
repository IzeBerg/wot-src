package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   
   public class Comp7TeamStatsController extends DefaultTeamStatsController
   {
       
      
      public function Comp7TeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList) : void
      {
         param1.itemRendererName = Linkages.COMP7_TEAM_LEFT_MEMBER_RENDERER;
         param2.itemRendererName = Linkages.COMP7_TEAM_RIGHT_MEMBER_RENDERER;
      }
      
      override protected function initColumnsData(param1:CommonStatsVO) : void
      {
         super.initColumnsData(param1);
         columnWidth[ColumnConstants.PRESTIGE_POINTS] = ColumnConstants.PRESTIGE_POINTS_COLUMN_WIDTH;
         sortingKey[ColumnConstants.PRESTIGE_POINTS] = [ColumnConstants.PRESTIGE_POINTS];
         columnTooltip[ColumnConstants.PRESTIGE_POINTS] = COMP7.BATTLERESULT_TEAM_PRESTIGEPOINTS;
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         if(param1.isShowSquad)
         {
            _loc2_.push(ColumnConstants.SQUAD);
         }
         _loc2_.push(ColumnConstants.PLAYER);
         _loc2_.push(ColumnConstants.TANK);
         _loc2_.push(ColumnConstants.DAMAGE);
         _loc2_.push(ColumnConstants.FRAG);
         _loc2_.push(ColumnConstants.XP);
         _loc2_.push(ColumnConstants.PRESTIGE_POINTS);
         return _loc2_;
      }
   }
}
