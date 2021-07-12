package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanInvitesWindowHeaderStateVO extends DAAPIDataClass
   {
       
      
      public var inviteButtonEnabled:Boolean = false;
      
      public var inviteButtonText:String = "";
      
      public var inviteButtonTooltip:String = "";
      
      public var freePlacesInClanText:String = "";
      
      public function ClanInvitesWindowHeaderStateVO(param1:Object)
      {
         super(param1);
      }
   }
}
