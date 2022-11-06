package net.wg.gui.battle.views.stats.fullStats
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleIconHolder;
   
   public class SquadInviteStatusView extends BattleIconHolder
   {
       
      
      public var inviteDisabled:BattleAtlasSprite = null;
      
      public var inviteReceivedFromSquad:BattleAtlasSprite = null;
      
      public var inviteReceived:BattleAtlasSprite = null;
      
      public var inviteWasSent:BattleAtlasSprite = null;
      
      public function SquadInviteStatusView()
      {
         super();
         this.inviteDisabled.visible = false;
         this.inviteReceivedFromSquad.visible = false;
         this.inviteReceived.visible = false;
         this.inviteWasSent.visible = false;
         this.inviteDisabled.imageName = BATTLEATLAS.SQUAD_INVITE_DISABLED;
         this.inviteReceived.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED;
         this.inviteReceivedFromSquad.imageName = BATTLEATLAS.SQUAD_INVITE_RECEIVED_FROM_SQUAD;
         this.inviteWasSent.imageName = BATTLEATLAS.SQUAD_INVITE_SENT;
      }
      
      public function showInviteDisabled() : void
      {
         showItem(this.inviteDisabled);
      }
      
      public function showInviteReceived() : void
      {
         showItem(this.inviteReceived);
      }
      
      public function showInviteReceivedFromSquad() : void
      {
         showItem(this.inviteReceivedFromSquad);
      }
      
      public function showInviteSent() : void
      {
         showItem(this.inviteWasSent);
      }
      
      override protected function onDispose() : void
      {
         this.inviteDisabled = null;
         this.inviteReceivedFromSquad = null;
         this.inviteReceived = null;
         this.inviteWasSent = null;
         super.onDispose();
      }
   }
}
