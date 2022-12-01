package net.wg.gui.lobby.missions
{
   import net.wg.gui.lobby.missions.event.MissionViewEvent;
   
   public class MissionsCategoriesView extends MissionsGroupedView
   {
       
      
      public function MissionsCategoriesView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MissionViewEvent.NY_BANNER_GOTO_CHALLENGE,this.onNYBannerGotoChallengeHandler);
         removeEventListener(MissionViewEvent.NY_BANNER_GOTO_DAILY,this.onNYBannerGotoDailyHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MissionViewEvent.NY_BANNER_GOTO_CHALLENGE,this.onNYBannerGotoChallengeHandler);
         addEventListener(MissionViewEvent.NY_BANNER_GOTO_DAILY,this.onNYBannerGotoDailyHandler);
      }
      
      private function onNYBannerGotoDailyHandler(param1:MissionViewEvent) : void
      {
         onDailyClickS();
      }
      
      private function onNYBannerGotoChallengeHandler(param1:MissionViewEvent) : void
      {
         onNYChallengeClickS();
      }
   }
}
