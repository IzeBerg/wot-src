package net.wg.gui.battle.views.stats.constants
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvitationStatus;
   import net.wg.data.constants.UserTags;
   
   public class DynamicSquadState
   {
      
      public static var NONE:int = -1;
      
      public static var INVITE_DISABLED:int = 0;
      
      public static var IN_SQUAD:int = 1;
      
      public static var INVITE_AVAILABLE:int = 2;
      
      public static var INVITE_SENT:int = 3;
      
      public static var INVITE_RECEIVED:int = 4;
      
      public static var INVITE_RECEIVED_FROM_SQUAD:int = 5;
       
      
      public function DynamicSquadState()
      {
         super();
      }
      
      public static function getState(param1:DAAPIVehicleInfoVO) : int
      {
         var _loc2_:Boolean = UserTags.isIgnored(param1.userTags);
         var _loc3_:Boolean = param1.isSquadMan();
         var _loc4_:Boolean = UserTags.isCurrentPlayer(param1.userTags);
         if(_loc4_)
         {
            return !!_loc3_ ? int(DynamicSquadState.IN_SQUAD) : int(DynamicSquadState.NONE);
         }
         if(InvitationStatus.isSent(param1.invitationStatus) && !InvitationStatus.isSentInactive(param1.invitationStatus))
         {
            return DynamicSquadState.INVITE_SENT;
         }
         if(InvitationStatus.isReceived(param1.invitationStatus) && !InvitationStatus.isReceivedInactive(param1.invitationStatus) && !_loc2_)
         {
            return !!_loc3_ ? int(DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD) : int(DynamicSquadState.INVITE_RECEIVED);
         }
         if(_loc2_ || InvitationStatus.isForbidden(param1.invitationStatus))
         {
            return !!_loc3_ ? int(DynamicSquadState.IN_SQUAD) : int(DynamicSquadState.INVITE_DISABLED);
         }
         return !!_loc3_ ? int(DynamicSquadState.IN_SQUAD) : int(DynamicSquadState.INVITE_AVAILABLE);
      }
   }
}
