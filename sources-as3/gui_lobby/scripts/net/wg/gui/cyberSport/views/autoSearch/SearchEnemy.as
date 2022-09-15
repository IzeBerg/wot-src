package net.wg.gui.cyberSport.views.autoSearch
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
   
   public class SearchEnemy extends StateViewBase
   {
       
      
      public var buttonsBG:MovieClip;
      
      public function SearchEnemy()
      {
         super();
      }
      
      override public function changeButtonsState(param1:Boolean, param2:Boolean) : void
      {
         this.buttonsBG.visible = cancelButton.visible = param2;
         cancelButton.enabled = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.buttonsBG.visible = false;
         cancelButton.visible = false;
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         this.buttonsBG.visible = cancelButton.visible = model.canInvokeBattleQueue;
         updateTime();
         if(model.timeDirection > 0)
         {
            startTimer();
         }
      }
      
      override protected function onTimer() : void
      {
         super.onTimer();
         updateTime();
         startTimer();
      }
      
      override protected function getCancelLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
      }
      
      override protected function getMainLabel() : String
      {
         return CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHENEMY_MAINTEXT;
      }
      
      override protected function getSearchState() : String
      {
         return CYBER_SPORT_ALIASES.AUTO_SEARCH_ENEMY_STATE;
      }
   }
}
