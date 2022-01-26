package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.cs.CsTeamStats;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   
   public class RatedCybersportTeamStatsController extends DefaultTeamStatsController
   {
       
      
      public function RatedCybersportTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         return new <String>[ColumnConstants.PLAYER,ColumnConstants.TANK,ColumnConstants.DAMAGE,ColumnConstants.FRAG,ColumnConstants.XP,ColumnConstants.MEDAL];
      }
      
      override protected function setupTitles(param1:BattleResultsVO, param2:TextField, param3:TextField) : void
      {
         param2.visible = param3.visible = false;
      }
      
      override protected function setupCybersport(param1:BattleResultsVO, param2:CsTeamStats, param3:CsTeamStats, param4:SortableHeaderButtonBar, param5:SortableHeaderButtonBar, param6:TeamStatsList, param7:TeamStatsList) : void
      {
         var _loc8_:Number = Math.max(param1.team1.length,param1.team2.length);
         param2.setData(param1.cyberSport.teams.allies);
         param3.setData(param1.cyberSport.teams.enemies);
         param4.y = param2.y + param2.height;
         param5.y = param3.y + param3.height;
         var _loc9_:Number = param6.rowHeight * _loc8_;
         param6.height = param7.height = _loc9_;
         param6.y = param4.y + param4.height - 1;
         param7.y = param5.y + param5.height - 1;
      }
   }
}
