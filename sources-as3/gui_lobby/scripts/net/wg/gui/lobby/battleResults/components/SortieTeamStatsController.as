package net.wg.gui.lobby.battleResults.components
{
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.battleResults.controller.ColumnConstants;
   import net.wg.gui.lobby.battleResults.controller.FortTeamStatsController;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SortieTeamStatsController extends FortTeamStatsController
   {
      
      private static const FORT_RESOURCE:String = "resourceCount";
      
      private static const FORT_RESOURCE_COLUMN_WIDTH:int = 62;
      
      private static const KEY_RESOURCE_COUNT:String = "resourceCount";
      
      private static const TEAM_RESOURCE_TOTAL_POS_DEFAULT:int = 584;
      
      private static const TEAM_INFLUENCE_TOTAL_HEIGHT:int = 28;
       
      
      public function SortieTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         teamResourceTotal.removeEventListener(MouseEvent.MOUSE_OVER,this.onTeamResourceTotalMouseOverHandler);
         teamResourceTotal.removeEventListener(MouseEvent.MOUSE_OUT,this.onTeamTextFieldsTotalMouseOutHandler);
         teamInfluenceTotal.removeEventListener(MouseEvent.MOUSE_OVER,this.onTeamInfluenceTotalMouseOverHandler);
         teamInfluenceTotal.removeEventListener(MouseEvent.MOUSE_OUT,this.onTeamTextFieldsTotalMouseOutHandler);
         super.dispose();
      }
      
      override protected function initColumnsData(param1:CommonStatsVO) : void
      {
         super.initColumnsData(param1);
         columnWidth[ColumnConstants.PLAYER] = !!param1.isShowSquad ? ColumnConstants.SQUAD_PLAYER_COLUMN_WIDTH - ColumnConstants.FIRST_COLUMN_WIDTH : ColumnConstants.SQUAD_PLAYER_COLUMN_WIDTH;
         columnTooltip[FORT_RESOURCE] = BATTLE_RESULTS.TEAM_RESOURCEHEADER;
         columnWidth[FORT_RESOURCE] = FORT_RESOURCE_COLUMN_WIDTH;
         sortingKey[FORT_RESOURCE] = [KEY_RESOURCE_COUNT];
         columnWidth[ColumnConstants.MEDAL] = ColumnConstants.SQUAD_MEDAL_COLUMN_WIDTH;
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         return new <String>[ColumnConstants.PLAYER,ColumnConstants.TANK,ColumnConstants.DAMAGE,ColumnConstants.FRAG,ColumnConstants.XP,FORT_RESOURCE,ColumnConstants.MEDAL];
      }
      
      override protected function setupResources(param1:BattleResultsVO) : void
      {
         var _loc2_:Boolean = false;
         teamResourceTotal.htmlText = param1.common.totalFortResourceStr;
         _loc2_ = StringUtils.isNotEmpty(param1.common.totalInfluenceStr);
         teamInfluenceTotal.visible = _loc2_;
         if(_loc2_)
         {
            teamInfluenceTotal.htmlText = param1.common.totalInfluenceStr;
            teamInfluenceTotal.addEventListener(MouseEvent.MOUSE_OVER,this.onTeamInfluenceTotalMouseOverHandler);
            teamInfluenceTotal.addEventListener(MouseEvent.MOUSE_OUT,this.onTeamTextFieldsTotalMouseOutHandler);
            teamResourceTotal.y = TEAM_RESOURCE_TOTAL_POS_DEFAULT;
         }
         else
         {
            teamResourceTotal.y = TEAM_RESOURCE_TOTAL_POS_DEFAULT + TEAM_INFLUENCE_TOTAL_HEIGHT;
         }
         teamResourceTotal.addEventListener(MouseEvent.MOUSE_OVER,this.onTeamResourceTotalMouseOverHandler);
         teamResourceTotal.addEventListener(MouseEvent.MOUSE_OUT,this.onTeamTextFieldsTotalMouseOutHandler);
         teamResourceTotal.visible = true;
      }
      
      private function onTeamTextFieldsTotalMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onTeamInfluenceTotalMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.BATTLERESULTS_FORTRESOURCE_TEAMINFLUENCETOTAL);
      }
      
      private function onTeamResourceTotalMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(TOOLTIPS.BATTLERESULTS_FORTRESOURCE_TEAMRESOURCETOTAL);
      }
   }
}
