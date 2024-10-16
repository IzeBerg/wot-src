package net.wg.infrastructure.uilogging.player_satisfaction_rating
{
   import net.wg.infrastructure.uilogging.base.MetricsLogger;
   
   public class PostBattleTeamLogger extends MetricsLogger
   {
       
      
      public function PostBattleTeamLogger()
      {
         super(PLAYER_SATISFACTION_RATING_CONSTANTS.FEATURE);
      }
      
      public function logOpenTeamPanel() : void
      {
         log(PLAYER_SATISFACTION_RATING_CONSTANTS.ACTION_OPENED,PLAYER_SATISFACTION_RATING_CONSTANTS.TEAM_SCORE_TAB,PLAYER_SATISFACTION_RATING_CONSTANTS.BATTLE_RESULTS);
      }
   }
}
