package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.lobby.battleResults.IEmblemLoadedDelegate;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.event.ClanEmblemRequestEvent;
   
   public class FortTeamStatsController extends DefaultTeamStatsController implements IEmblemLoadedDelegate
   {
      
      protected static const CLAN_TEAM_ALLIES:String = "clanTeamAllies";
      
      protected static const CLAN_TEAM_ENEMIES:String = "clanTeamEnemies";
       
      
      private var _alliesClanAbbrev:String;
      
      private var _enemiesClanAbbrev:String;
      
      public function FortTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override public function update(param1:BattleResultsVO) : void
      {
         super.update(param1);
         this._alliesClanAbbrev = param1.common.clans.allies.clanAbbrev;
         this._enemiesClanAbbrev = param1.common.clans.enemies.clanAbbrev;
         var _loc2_:Number = param1.common.clans.allies.clanDBID;
         var _loc3_:Number = param1.common.clans.enemies.clanDBID;
         dispatcher.dispatchEvent(new ClanEmblemRequestEvent(CLAN_TEAM_ALLIES,_loc2_,this));
         dispatcher.dispatchEvent(new ClanEmblemRequestEvent(CLAN_TEAM_ENEMIES,_loc3_,this));
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         return new <String>[ColumnConstants.PLAYER,ColumnConstants.TANK,ColumnConstants.DAMAGE,ColumnConstants.FRAG,ColumnConstants.XP,ColumnConstants.MEDAL];
      }
      
      public function onEmblemLoaded(param1:String, param2:String, param3:String) : void
      {
         if(ownTitle != null)
         {
            if(param1 == CLAN_TEAM_ALLIES)
            {
               ownTitle.htmlText = App.utils.locale.makeString(BATTLE_RESULTS.TEAM_STATS_OWNTEAM) + " " + param2 + " " + this._alliesClanAbbrev;
            }
            else if(param1 == CLAN_TEAM_ENEMIES)
            {
               enemyTitle.htmlText = App.utils.locale.makeString(BATTLE_RESULTS.TEAM_STATS_ENEMYTEAM) + " " + param2 + " " + this._enemiesClanAbbrev;
            }
         }
      }
   }
}
