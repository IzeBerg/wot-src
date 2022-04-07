package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AcceptActionsVO extends DAAPIDataClass
   {
       
      
      public var acceptButtonVisible:Boolean = false;
      
      public var declineButtonVisible:Boolean = false;
      
      public var acceptButtonEnabled:Boolean = false;
      
      public var declineButtonEnabled:Boolean = false;
      
      public var acceptButtonTooltip:String = "";
      
      public function AcceptActionsVO(param1:Object)
      {
         super(param1);
      }
   }
}
