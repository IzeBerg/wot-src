package net.wg.gui.cyberSport.views.autoSearch
{
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   
   public class SearchEnemyRespawn extends StateViewBase
   {
       
      
      public function SearchEnemyRespawn()
      {
         super();
      }
      
      override protected function getMainLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHENEMYRESPAWN_MAINTEXT;
      }
      
      override protected function getSearchState() : String
      {
         return CYBER_SPORT_ALIASES.AUTO_SEARCH_ENEMY_RESPAWN_STATE;
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         updateTime();
         startTimer();
      }
      
      override protected function onTimer() : void
      {
         super.onTimer();
         updateTime();
         startTimer();
      }
   }
}
