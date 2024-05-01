package net.wg.gui.lobby.clans.invites.VOs
{
   public class ClanRequestActionsVO extends AcceptActionsVO
   {
       
      
      public var inviteButtonVisible:Boolean = false;
      
      public var inviteButtonEnabled:Boolean = false;
      
      public var inviteButtonText:String = "";
      
      public var inviteButtonTooltip:String = "";
      
      public function ClanRequestActionsVO(param1:Object)
      {
         super(param1);
      }
   }
}
