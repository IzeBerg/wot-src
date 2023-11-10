package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.invites.views.ClanInvitesWindowAbstractTabView;
   
   public class ClanRequestsViewMeta extends ClanInvitesWindowAbstractTabView
   {
       
      
      public var acceptRequest:Function;
      
      public var declineRequest:Function;
      
      public var sendInvite:Function;
      
      public function ClanRequestsViewMeta()
      {
         super();
      }
      
      public function acceptRequestS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.acceptRequest,"acceptRequest" + Errors.CANT_NULL);
         this.acceptRequest(param1);
      }
      
      public function declineRequestS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.declineRequest,"declineRequest" + Errors.CANT_NULL);
         this.declineRequest(param1);
      }
      
      public function sendInviteS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.sendInvite,"sendInvite" + Errors.CANT_NULL);
         this.sendInvite(param1);
      }
   }
}
