package net.wg.gui.lobby.missions
{
   import net.wg.gui.lobby.missions.event.MissionViewEvent;
   
   public class RtsMissionsCategoriesView extends MissionsGroupedView
   {
       
      
      public function RtsMissionsCategoriesView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MissionViewEvent.RTS_BANNER_GOTO_MISSIONS,this.onRtsBannerGotoMissionsHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MissionViewEvent.RTS_BANNER_GOTO_MISSIONS,this.onRtsBannerGotoMissionsHandler);
      }
      
      private function onRtsBannerGotoMissionsHandler(param1:MissionViewEvent) : void
      {
         onGotoRtsQuestsClick();
      }
   }
}
