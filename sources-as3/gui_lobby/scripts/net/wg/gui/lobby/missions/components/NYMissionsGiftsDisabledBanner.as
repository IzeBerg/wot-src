package net.wg.gui.lobby.missions.components
{
   public class NYMissionsGiftsDisabledBanner extends NYMissionsBanner
   {
       
      
      public function NYMissionsGiftsDisabledBanner()
      {
         super();
      }
      
      override protected function getMessage() : String
      {
         return "#ny:nyMissionsGiftsDisabledBanner/message";
      }
   }
}
