package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.clans.invites.views.ClanInvitesViewWithTable;
   
   public class ClanPersonalInvitesViewMeta extends ClanInvitesViewWithTable
   {
       
      
      public var acceptInvite:Function;
      
      public var declineInvite:Function;
      
      public var setInviteSelected:Function;
      
      public var setSelectAllInvitesCheckBoxSelected:Function;
      
      public var declineAllSelectedInvites:Function;
      
      public function ClanPersonalInvitesViewMeta()
      {
         super();
      }
      
      public function acceptInviteS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.acceptInvite,"acceptInvite" + Errors.CANT_NULL);
         this.acceptInvite(param1);
      }
      
      public function declineInviteS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.declineInvite,"declineInvite" + Errors.CANT_NULL);
         this.declineInvite(param1);
      }
      
      public function setInviteSelectedS(param1:Number, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setInviteSelected,"setInviteSelected" + Errors.CANT_NULL);
         this.setInviteSelected(param1,param2);
      }
      
      public function setSelectAllInvitesCheckBoxSelectedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setSelectAllInvitesCheckBoxSelected,"setSelectAllInvitesCheckBoxSelected" + Errors.CANT_NULL);
         this.setSelectAllInvitesCheckBoxSelected(param1);
      }
      
      public function declineAllSelectedInvitesS() : void
      {
         App.utils.asserter.assertNotNull(this.declineAllSelectedInvites,"declineAllSelectedInvites" + Errors.CANT_NULL);
         this.declineAllSelectedInvites();
      }
   }
}
