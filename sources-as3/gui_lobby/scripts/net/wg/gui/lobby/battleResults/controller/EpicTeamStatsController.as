package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   
   public class EpicTeamStatsController extends ScrollBarTeamStatsController
   {
      
      private static const EPIC_PLAYER_COLUMN_WIDTH:int = 108;
      
      private static const EPIC_RANK_COLUMN_WIDTH:int = 54;
      
      private static const EPIC_XP_COLUMN_WIDTH:int = 78;
      
      private static const EPIC_FRAGS_COLUMN_WIDTH:int = 56;
      
      private static const EPIC_DAMAGE_COLUMN_WIDTH:int = 62;
      
      private static const EPIC_RESPAWN_COLUMN_WIDTH:int = 50;
      
      private static const EPIC_MEDAL_COLUMN_WIDTH:int = 44;
       
      
      public function EpicTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override protected function initColumnsData(param1:CommonStatsVO) : void
      {
         super.initColumnsData(param1);
         columnWidth[ColumnConstants.PLAYER] = EPIC_PLAYER_COLUMN_WIDTH;
         columnTooltip[ColumnConstants.EPIC_RANK] = BATTLE_RESULTS.TEAM_EPICRANKHEADER;
         columnWidth[ColumnConstants.EPIC_RANK] = EPIC_RANK_COLUMN_WIDTH;
         sortingKey[ColumnConstants.EPIC_RANK] = [ColumnConstants.KEY_EPIC_RANK];
         columnWidth[ColumnConstants.XP] = EPIC_XP_COLUMN_WIDTH;
         columnWidth[ColumnConstants.FRAG] = EPIC_FRAGS_COLUMN_WIDTH;
         columnWidth[ColumnConstants.DAMAGE] = EPIC_DAMAGE_COLUMN_WIDTH;
         columnTooltip[ColumnConstants.RESPAWN] = BATTLE_RESULTS.TEAM_EPICRESPAWNHEADER;
         columnWidth[ColumnConstants.RESPAWN] = EPIC_RESPAWN_COLUMN_WIDTH;
         sortingKey[ColumnConstants.RESPAWN] = [ColumnConstants.KEY_RESPAWNS];
         columnTooltip[ColumnConstants.MEDAL] = BATTLE_RESULTS.TEAM_MEDALHEADER;
         columnWidth[ColumnConstants.MEDAL] = EPIC_MEDAL_COLUMN_WIDTH;
         sortingKey[ColumnConstants.MEDAL] = [ColumnConstants.KEY_MEDALS];
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         if(param1.isShowSquad)
         {
            _loc2_.push(ColumnConstants.SQUAD);
         }
         _loc2_.push(ColumnConstants.PLAYER);
         _loc2_.push(ColumnConstants.EPIC_RANK);
         _loc2_.push(ColumnConstants.XP);
         _loc2_.push(ColumnConstants.FRAG);
         _loc2_.push(ColumnConstants.DAMAGE);
         _loc2_.push(ColumnConstants.RESPAWN);
         _loc2_.push(ColumnConstants.MEDAL);
         return _loc2_;
      }
      
      override protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList) : void
      {
         param1.itemRendererName = Linkages.EPIC_TEAM_LEFT_RENDERER_UI;
         param2.itemRendererName = Linkages.EPIC_TEAM_RIGHT_RENDERER_UI;
      }
   }
}
