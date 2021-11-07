package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.events.MouseEvent;
   import net.wg.gui.cyberSport.data.CandidatesDataProvider;
   import net.wg.gui.rally.views.room.BaseWaitListSection;
   
   public class SortieWaitListSection extends BaseWaitListSection
   {
       
      
      public function SortieWaitListSection()
      {
         super();
      }
      
      override protected function initializeDP() : void
      {
         candidatesDP = new CandidatesDataProvider();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         lblCandidatesHeader.text = FORTIFICATIONS.SORTIE_ROOM_CANDIDATES;
         btnInviteFriend.label = FORTIFICATIONS.SORTIE_ROOM_INVITEFRIENDS;
      }
      
      override protected function onControlRollOver(param1:MouseEvent) : void
      {
         super.onControlRollOver(param1);
         switch(param1.target)
         {
            case btnInviteFriend:
               App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_INVITEBTN);
         }
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
